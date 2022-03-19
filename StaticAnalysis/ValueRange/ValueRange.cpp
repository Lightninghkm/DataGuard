#include "llvm/ADT/APSInt.h"
#include "llvm/Analysis/ConstantFolding.h"
#include "llvm/IR/CallSite.h"
#include "llvm/IR/Constants.h"
#include "llvm/IR/DebugInfo.h"
#include "llvm/IR/LLVMContext.h"
#include "llvm/IR/Module.h"
#include "llvm/IRReader/IRReader.h"
#include "llvm/Support/CommandLine.h"
#include "llvm/Support/ManagedStatic.h"
#include "llvm/Support/PrettyStackTrace.h"
#include "llvm/Support/Signals.h"
#include "llvm/Support/SourceMgr.h"
#include "llvm/Support/raw_ostream.h"

#include <bitset>
#include <memory>
#include <string>

#include "DataflowAnalysis.h"
#include "ValueRange.hpp"


using namespace llvm;
using std::string;
using std::unique_ptr;


enum class PossibleRangeValues {
    unknown,
    constant,
    infinity
};

struct RangeValue {
    PossibleRangeValues kind;
    llvm::ConstantInt *lvalue, *rvalue;

    RangeValue() : kind(PossibleRangeValues::unknown),
                   lvalue(nullptr),
                   rvalue(nullptr) {}


    bool isUnknown() const {
        return kind == PossibleRangeValues::unknown;
    }

    bool isInfinity() const {
        return kind == PossibleRangeValues::infinity;
    }

    bool isConstant() const {
        return kind == PossibleRangeValues::constant;
    }

    RangeValue
    operator|(const RangeValue &other) const {
        RangeValue r;
        if (isUnknown() || other.isUnknown()) {
            if (isUnknown()) {
                return other;
            }
            else {
                return *this;
            }
        }
        else if (isInfinity() || other.isInfinity()) {
            r.kind = PossibleRangeValues::infinity;
            return r;
        }
        else {
            auto &selfL = lvalue->getValue();
            auto &selfR = rvalue->getValue();
            auto &otherL = (other.lvalue)->getValue();
            auto &otherR = (other.rvalue)->getValue();

            r.kind = PossibleRangeValues::constant;
            if (selfL.slt(otherL)) {
                r.lvalue = lvalue;
            }
            else {
                r.lvalue = other.lvalue;
            }

            if (selfR.sgt(otherR)) {
                r.rvalue = rvalue;
            }
            else {
                r.rvalue = other.rvalue;
            }
            return r;
        }
    }

    bool
    operator==(const RangeValue &other) const {
        if (kind == PossibleRangeValues::constant &&
            other.kind == PossibleRangeValues::constant) {
            auto &selfL = lvalue->getValue();
            auto &selfR = rvalue->getValue();
            auto &otherL = (other.lvalue)->getValue();
            auto &otherR = (other.rvalue)->getValue();
            return selfL == otherL && selfR == otherR;
        }
        else {
            return kind == other.kind;
        }
    }

};

RangeValue makeRange(LLVMContext &context, APInt &left, APInt &right) {
    RangeValue r;
    r.kind = PossibleRangeValues::constant;
    r.lvalue = ConstantInt::get(context, left);
    r.rvalue = ConstantInt::get(context, right);
    return r;
}

RangeValue infRange() {
    RangeValue r;
    r.kind = PossibleRangeValues::infinity;
    return r;
}

using RangeState  = analysis::AbstractState<RangeValue>;
using RangeResult = analysis::DataflowResult<RangeValue>;

class RangeMeet : public analysis::Meet<RangeValue, RangeMeet> {
public:
    RangeValue
    meetPair(RangeValue &s1, RangeValue &s2) const {
        return s1 | s2;
    }
};

class RangeTransfer {
public:
    RangeValue getRangeFor(llvm::Value *v, RangeState &state) const {
        if (auto *constant = llvm::dyn_cast<llvm::ConstantInt>(v)) {
            RangeValue r;
            r.kind = PossibleRangeValues::constant;
            r.lvalue = r.rvalue = constant;
            return r;
        }
        return state[v];
    }

    RangeValue evaluateBinOP(llvm::BinaryOperator &binOp,
                             RangeState &state) const {
        auto *op1 = binOp.getOperand(0);
        auto *op2 = binOp.getOperand(1);
        auto range1 = getRangeFor(op1, state);
        auto range2 = getRangeFor(op2, state);

        if (range1.isConstant() && range2.isConstant()) {
//            auto &layout = binOp.getModule()->getDataLayout();
            auto l1 = range1.lvalue->getValue();
            auto r1 = range1.rvalue->getValue();
            auto l2 = range2.lvalue->getValue();
            auto r2 = range2.rvalue->getValue();

            auto &context = (range1.lvalue)->getContext();
            auto opcode = binOp.getOpcode();

            if (opcode == Instruction::Add) {
                bool ofl, ofr;
                auto l = l1.sadd_ov(l2, ofl);
                auto r = r1.sadd_ov(r2, ofr);
                if (ofl || ofr) {
                    return infRange();
                }
                else {
                    return makeRange(context, l, r);
                }
            }
            else if (opcode == Instruction::Sub) {
                bool ofl, ofr;
                auto l = l1.ssub_ov(r2, ofl);
                auto r = r1.ssub_ov(l2, ofr);
                if (ofl || ofr) {
                    return infRange();
                }
                else {
                    return makeRange(context, l, r);
                }
            }
            else if (opcode == Instruction::Mul) {
                SmallVector<APInt, 4> candidates;
                bool ofFlags[4];
                candidates.push_back(l1.smul_ov(l2, ofFlags[0]));
                candidates.push_back(l1.smul_ov(r2, ofFlags[1]));
                candidates.push_back(r1.smul_ov(l2, ofFlags[2]));
                candidates.push_back(r1.smul_ov(r2, ofFlags[3]));
                for (auto of:ofFlags) {
                    if (of) {
                        return infRange();
                    }
                }
                auto max = candidates[0];
                for (auto &x : candidates) {
                    if (x.sgt(max)) {
                        max = x;
                    }
                }
                auto min = candidates[0];
                for (auto &x : candidates) {
                    if (x.slt(min)) {
                        min = x;
                    }
                }
                return makeRange(context, min, max);
            }
            else if (opcode == Instruction::SDiv) {
                if (l2.isNegative() && r2.isStrictlyPositive()) {
                    auto abs1 = l1.abs();
                    auto abs2 = r1.abs();
                    auto abs = abs1.sgt(abs2) ? abs1 : abs2;
                    APInt l(abs);
                    l.flipAllBits();
                    ++l;
                    return makeRange(context, l, abs);
                }
                else {
                    SmallVector<APInt, 4> candidates;
                    bool ofFlags[4];
                    candidates.push_back(l1.sdiv_ov(l2, ofFlags[0]));
                    candidates.push_back(l1.sdiv_ov(r2, ofFlags[1]));
                    candidates.push_back(r1.sdiv_ov(l2, ofFlags[2]));
                    candidates.push_back(r1.sdiv_ov(r2, ofFlags[3]));
                    for (auto of:ofFlags) {
                        if (of) {
                            return infRange();
                        }
                    }
                    auto max = candidates[0];
                    for (auto &x : candidates) {
                        if (x.sgt(max)) {
                            max = x;
                        }
                    }
                    auto min = candidates[0];
                    for (auto &x : candidates) {
                        if (x.slt(min)) {
                            min = x;
                        }
                    }
                    return makeRange(context, min, max);
                }
            }
            else if (opcode == Instruction::UDiv) {
                auto l = r1.udiv(l2);
                auto r = l1.udiv(r2);
                return makeRange(context, l, r);
            }
            else {
                // todo: fill in
                return infRange();
            }
        }
        else if (range1.isInfinity() || range2.isInfinity()) {
            RangeValue r;
            r.kind = PossibleRangeValues::infinity;
            return r;
        }
        else {
            RangeValue r;
            return r;
        }
    }

    RangeValue evaluateCast(llvm::CastInst &castOp, RangeState &state) const {
        auto *op = castOp.getOperand(0);
        auto value = getRangeFor(op, state);

        if (value.isConstant()) {
            auto &layout = castOp.getModule()->getDataLayout();
            auto x = ConstantFoldCastOperand(castOp.getOpcode(), value.lvalue,
                                             castOp.getDestTy(), layout);
            auto y = ConstantFoldCastOperand(castOp.getOpcode(), value.rvalue,
                                             castOp.getDestTy(), layout);
            if (llvm::isa<llvm::ConstantExpr>(x) || llvm::isa<llvm::ConstantExpr>(y)) {
                return infRange();
            }
            else {
                RangeValue r;
                auto *cix = dyn_cast<ConstantInt>(x);
                auto *ciy = dyn_cast<ConstantInt>(y);
                r.kind = PossibleRangeValues::constant;
                r.lvalue = cix;
                r.rvalue = ciy;
                return r;
            }
        }
        else {
            RangeValue r;
            r.kind = value.kind;
            return r;
        }
    }

    void
    operator()(llvm::Value &i, RangeState &state) {
        if (auto *constant = llvm::dyn_cast<llvm::ConstantInt>(&i)) {
            RangeValue r;
            r.kind = PossibleRangeValues::constant;
            r.lvalue = r.rvalue = constant;
            state[&i] = r;
        }
        else if (auto *binOp = llvm::dyn_cast<llvm::BinaryOperator>(&i)) {
            state[binOp] = evaluateBinOP(*binOp, state);
        }
        else if (auto *castOp = llvm::dyn_cast<llvm::CastInst>(&i)) {
            state[castOp] = evaluateCast(*castOp, state);
        }
        else {
            state[&i].kind = PossibleRangeValues::infinity;
        }
    }
};

void printRange(RangeValue &rangeValue) {
    if (rangeValue.isInfinity()) {
        errs() << "-inf:inf" << "\n";
    }
    else if (rangeValue.isUnknown()) {
        errs() << "unknown" << "\n";
    }
    else {
        errs() << rangeValue.lvalue->getValue() << ":" << rangeValue.rvalue->getValue();
    }
}

void
debugPrint(RangeResult &rangeStates) {
    RangeState state;
    for (auto &valueStatePair : rangeStates) {
        auto *inst = llvm::dyn_cast<llvm::GetElementPtrInst>(valueStatePair.first);
        if (!inst) {
            continue;
        }
        state = analysis::getIncomingState(rangeStates, *inst);
    }

    for (auto &valueStatePair : rangeStates) {
        auto *inst = llvm::dyn_cast<llvm::Instruction>(valueStatePair.first);
        if (!inst) {
            continue;
        }
        errs() << *inst << '\n';
        auto range = state[inst];
        printRange(range);
        errs() << "==================\n";
    }
}

bool queryAliasing(Value* v1, Value* v2)
	{
	  if (!v1->getType()->isPointerTy() || !v2->getType()->isPointerTy()){
	  	errs() << "Not a Pointer!" << '\n';
		return false;
	  }
	  // check bit cast
	  if (BitCastInst *bci = dyn_cast<BitCastInst>(v1))
	  {
		if (bci->getOperand(0) == v2)
		  return true;
	  }
	  // handle load instruction  
	  if (LoadInst* li = dyn_cast<LoadInst>(v1))
	  {
		auto load_addr = li->getPointerOperand();
		for (auto user : load_addr->users())
		{
		  if (isa<LoadInst>(user))
		  {
		    if (user == v2)
		      return true;
		  }
		  if (StoreInst *si = dyn_cast<StoreInst>(user))
		  {
		    if (si->getPointerOperand() == load_addr)
		    {
		      if (si->getValueOperand() == v2)
		        return true;
		    }
		  }
		}
	  }
	}

void valueRangeAnalysis(Module *M, std::set<Value*> stackSeqPointerSet){
	auto *mainFunction = M->getFunction("main_nesCheck");
    if (!mainFunction) {
        llvm::report_fatal_error("Unable to find main function.");
    }
    
    using Value    = RangeValue;
    using Transfer = RangeTransfer;
    using Meet     = RangeMeet;
    using Analysis = analysis::ForwardDataflowAnalysis<Value, Transfer, Meet>;
    Analysis analysis{*M, mainFunction};
    auto results = analysis.computeForwardDataflow();
    errs() << "Computing Value Range" << '\n';
    for (auto & [ctxt, contextResults] : results) {
        for (auto & [function, rangeStates] : contextResults) {
            for (auto &valueStatePair : rangeStates) {
                auto *inst = llvm::dyn_cast<llvm::GetElementPtrInst>(valueStatePair.first);
                if (!inst) {
                    //errs() << "INST is NULL!" << '\n';
                    continue;
                }
                errs() << '\n' << *inst ;
		            auto &state = analysis::getIncomingState(rangeStates, *inst);
		            Type *type = cast<PointerType>(
		                    cast<GetElementPtrInst>(inst)->getPointerOperandType())->getElementType();
		            auto pointerTy = dyn_cast_or_null<PointerType>(type);
		            auto arrayTy = dyn_cast_or_null<ArrayType>(type);
		            auto structTy = dyn_cast_or_null<StructType>(type);
		            
		            if(!arrayTy && !structTy){
	            		errs() << "\nThis is a pointer to type: "<< *type << '\n';
	            		auto index = inst->getOperand(1);
						auto constant = dyn_cast<ConstantInt>(index);
						if (constant) {
							//outs() << "Index is constant!" << '\n';
							if (!constant->isNegative()) {
							//if (!constant->isNegative() && !constant->uge(size)) {
							    // print context
							    for (Instruction *c_instr: ctxt) {
					                if (c_instr) {
					                		errs() << "Call Site: ";
					                		errs() << *c_instr << '\n';
					                		//TODO: Call site rewrited by NesCheck, print instruction instead
					                        //c_instr->getDebugLoc().print(errs());
					                        //errs() << "\n";
					                    
					                }
					            }
					        }
				       		errs() << "Definition Site: ";
				            inst->getDebugLoc().print(errs());
				            errs() << ", ";
				            // print fn name
				            errs() << "In Func: " << function->getName().str() << ", ";
				            //print line
				            errs() << "At Line: " << inst->getDebugLoc().getLine();
				            //print buf bytes
				            errs() << "\n" << "Declared Size: Undetermined due to parameter passing" << ", ";
				            //print indices
				            //auto x = (int64_t) constant->getValue().getLimitedValue();// * elmtBytes;
				            errs() << "Access Range: " << (int64_t) constant->getValue().getLimitedValue()<< '\n';
			            	errs() << "Classify this pointer as unsafe!\n";
						}
				    }
		            
		            
		            if(arrayTy){
		                errs() << '\n' << "This is an array!" << '\n';
						auto size = arrayTy->getNumElements();
						auto elmtTy = arrayTy->getElementType();
						auto &layout = M->getDataLayout();
						auto numBytes = layout.getTypeAllocSize(arrayTy);
						auto elmtBytes = layout.getTypeAllocSize(elmtTy);
						auto index = inst->getOperand(2);
						auto constant = dyn_cast<ConstantInt>(index);
						if (constant) {
						    //errs() << "Index is constant!" << '\n';
						    if (!constant->isNegative() && !constant->uge(size)) {
						        // print context
						        bool first = true;
						        for (Instruction *c_instr: ctxt) {
				                    if (c_instr) {		                         		                                                                                    
				                        if (first) {
				                            first = false;
				                            errs() << "Direct Use Site: ";
				                            c_instr->getDebugLoc().print(errs());
				                            errs() << "\n";
				                        }
				                        else {
				                            errs() << "Indirect Use Site: ";
				                            c_instr->getDebugLoc().print(errs());
				                            errs() << "\n";
				                        }
				                    }
				                }
				                // print file name
				                errs() << "Definition Site: ";
				                inst->getDebugLoc().print(errs());
				                errs() << ", ";
				                // print fn name
				                errs() << "In Func: " << function->getName().str() << ", ";
				                //print line
				                errs() << "At Line: " << inst->getDebugLoc().getLine();
				                //print buf bytes
				                errs() << "\n" << "Declared Size: " << numBytes << ", ";
				                //print indices
				                //auto x = (int64_t) constant->getValue().getLimitedValue();// * elmtBytes;
				                errs() << "Access Range: " << (int64_t) constant->getValue().getLimitedValue() * elmtBytes << '\n';
				                if (numBytes >= ((int64_t) constant->getValue().getLimitedValue() * elmtBytes))
				                	errs() << "Classify this array as safe!\n";
				                else
				                	errs() << "Classify this array as unsafe!\n";
						    }
						}
						else {
						    auto &rangeValue = state[index];
						    if (rangeValue.isUnknown() ||
						        rangeValue.isInfinity() ||
						        rangeValue.lvalue->isNegative() ||
						        rangeValue.rvalue->uge(size)) {
						        // print context
						        bool first = true;
						        for (Instruction *c_instr: ctxt) {
				                    if (c_instr) {		                         		                                                                                    
				                        if (first) {
				                            first = false;
				                            errs() << "Direct Use Site: ";
				                            c_instr->getDebugLoc().print(errs());
				                            errs() << "\n";
				                        }
				                        else {
				                            errs() << "Indirect Use Site: ";
				                            c_instr->getDebugLoc().print(errs());
				                            errs() << "\n";
				                        }
				                    }
				                }
				                // print file name
				                errs() << "Definition Site: ";
				                inst->getDebugLoc().print(errs());
				                errs() << ", ";
				                // print fn name
				                errs() << "In Func: " << function->getName().str() << ", ";
				                //print line
				                errs() << "At Line: " << inst->getDebugLoc().getLine();
				                //print buf bytes
				                errs() << "\n" << "Declared Size: " << numBytes << ", ";
						        if (rangeValue.isInfinity() || rangeValue.isUnknown()) {
						            errs() << "Access Range: " << "Undetermined!\n";
						            errs() << "GEP has non-constant offset operand!" << '\n';
						            errs() << "Classify this array as unsafe!\n";
						        }
						        else {
						            auto l = (int64_t) rangeValue.lvalue->getLimitedValue();
						            auto r = (int64_t) rangeValue.rvalue->getLimitedValue();
						            errs() << l * (int64_t) elmtBytes << ':' << r * (int64_t) elmtBytes << '\n';
						        }
						    }
						}
					}
		        
		            if(structTy){
				        errs() << '\n'  << "This is a structure!" << '\n';
				        //std::string instPrint;
				        //llvm::raw_string_ostream rso(instPrint);
				        //inst->print(rso);
				        //errs() << "INST:" << rso.str() << "\n";
				        auto size = structTy->getNumElements();
				        //auto elmtTy = structTy->getElementType();
				        auto &layout = M->getDataLayout();
				        auto numBytes = layout.getTypeAllocSize(structTy);
				        //auto elmtBytes = layout.getTypeAllocSize(elmtTy);
				        llvm::Value* index;
				        if(inst->getNumOperands() > 2)
				            index = inst->getOperand(2);
				        
				        else{
							index = inst->getOperand(1);
				        }
				        
				        const llvm::StructLayout* structureLayout = layout.getStructLayout(structTy);
				        auto constant = dyn_cast<ConstantInt>(index);
			        	auto intIndex = (int64_t)constant->getValue().getLimitedValue();
			        	//errs() << intIndex << '\n';
			        	auto offset = structureLayout->getElementOffset(intIndex);
			            //errs() << "Index is constant!" << '\n';
				        if (constant) {
				            if (!constant->isNegative() && !constant->uge(size)) {
				                // print context
				                bool first = true;
				                for (Instruction *c_instr: ctxt) {
				                    if (c_instr) {		                         		                                                                                    
				                        if (first) {
				                            first = false;
				                            errs() << "Direct Use Site: ";
				                            c_instr->getDebugLoc().print(errs());
				                            errs() << "\n";
				                        }
				                        else {
				                            errs() << "Indirect Use Site: ";
				                            c_instr->getDebugLoc().print(errs());
				                            errs() << "\n";
				                        }
				                    }
				                }
				                // print file name
				                errs() << "Definition Site: ";
				                inst->getDebugLoc().print(errs());
				                errs() << ", ";
				                // print fn name
				                errs() << "In Func: " << function->getName().str() << ", ";
				                //print line
				                errs() << "At Line: " << inst->getDebugLoc().getLine();
				                //print buf bytes
				                errs() << "\n" << "Declared Size: " << numBytes << ", ";
				                //print indices
				                //auto x = (int64_t) constant->getValue().getLimitedValue();// * elmtBytes;
				                errs() << "Access Range: " << offset << '\n';
				                if (numBytes >= offset)
				                	errs() << "Classify this structure as safe!\n";
				                else
				                	errs() << "Classify this structure as unsafe!\n";
				            }
				        }
				        else {
				            auto &rangeValue = state[index];
				            if (rangeValue.isUnknown() ||
				                rangeValue.isInfinity() ||
				                rangeValue.lvalue->isNegative() ||
				                rangeValue.rvalue->uge(size)) {
				                // print context
				                bool first = true;
				                for (Instruction *c_instr: ctxt) {
				                    if (c_instr) {		                         		                                                                                    
				                        if (first) {
				                            first = false;
				                            errs() << "Direct Use Site: ";
				                            c_instr->getDebugLoc().print(errs());
				                            errs() << "\n";
				                        }
				                        else {
				                            errs() << "Indirect Use Site: ";
				                            c_instr->getDebugLoc().print(errs());
				                            errs() << "\n";
				                        }
				                    }
				                }
				                // print file name
				                errs() << "Definition Site: ";
				                inst->getDebugLoc().print(errs());
				                errs() << ", ";
				                // print fn name
				                errs() << "In Func: " << function->getName().str() << ", ";
				                //print line
				                errs() << "At Line: " << inst->getDebugLoc().getLine();
				                //print buf bytes
				                errs() << "\n" << "Declared Size: " << numBytes << ", ";
				                if (rangeValue.isInfinity() || rangeValue.isUnknown()) {
				                    errs() << "Access Range: " << "Undetermined!\n";
				                    errs() << "GEP has non-constant offset operand!" << '\n';
				                    errs() << "Classify this structure as unsafe!\n";
				                }
				            }
				        }
				  }         
            }
        }
    }
}
