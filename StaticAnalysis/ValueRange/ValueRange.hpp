#ifndef _ValueRange_
#define _ValueRange_
#include "DataflowAnalysis.h"
using namespace llvm;
void valueRangeAnalysis(Module *, std::set<Value*>);
#endif
