; ModuleID = 'test_field_sensitive_pdg.c'
source_filename = "test_field_sensitive_pdg.c"
target datalayout = "e-m:o-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-apple-macosx10.15.0"

%struct.Person = type { i32, i8* }

@.str = private unnamed_addr constant [4 x i8] c"Doo\00", align 1
@__const.main.p = private unnamed_addr constant %struct.Person { i32 20, i8* getelementptr inbounds ([4 x i8], [4 x i8]* @.str, i32 0, i32 0) }, align 8
@Person = common global %struct.Person zeroinitializer, align 8, !dbg !0

; Function Attrs: noinline nounwind optnone ssp uwtable
define i32 @f(%struct.Person* %p) #0 !dbg !18 {
entry:
  %p.addr = alloca %struct.Person*, align 8
  store %struct.Person* %p, %struct.Person** %p.addr, align 8
  call void @llvm.dbg.declare(metadata %struct.Person** %p.addr, metadata !22, metadata !DIExpression()), !dbg !23
  %0 = load %struct.Person*, %struct.Person** %p.addr, align 8, !dbg !24
  %age = getelementptr inbounds %struct.Person, %struct.Person* %0, i32 0, i32 0, !dbg !25
  %1 = load i32, i32* %age, align 8, !dbg !25
  ret i32 %1, !dbg !26
}

; Function Attrs: nounwind readnone speculatable willreturn
declare void @llvm.dbg.declare(metadata, metadata, metadata) #1

; Function Attrs: noinline nounwind optnone ssp uwtable
define i32 @main() #0 !dbg !27 {
entry:
  %retval = alloca i32, align 4
  %p = alloca %struct.Person, align 8
  store i32 0, i32* %retval, align 4
  call void @llvm.dbg.declare(metadata %struct.Person* %p, metadata !30, metadata !DIExpression()), !dbg !31
  %0 = bitcast %struct.Person* %p to i8*, !dbg !31
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 8 %0, i8* align 8 bitcast (%struct.Person* @__const.main.p to i8*), i64 16, i1 false), !dbg !31
  %call = call i32 @f(%struct.Person* %p), !dbg !32
  ret i32 0, !dbg !33
}

; Function Attrs: argmemonly nounwind willreturn
declare void @llvm.memcpy.p0i8.p0i8.i64(i8* noalias nocapture writeonly, i8* noalias nocapture readonly, i64, i1 immarg) #2

attributes #0 = { noinline nounwind optnone ssp uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "frame-pointer"="all" "less-precise-fpmad"="false" "min-legal-vector-width"="0" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="penryn" "target-features"="+cx16,+cx8,+fxsr,+mmx,+sahf,+sse,+sse2,+sse3,+sse4.1,+ssse3,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind readnone speculatable willreturn }
attributes #2 = { argmemonly nounwind willreturn }

!llvm.dbg.cu = !{!2}
!llvm.module.flags = !{!13, !14, !15, !16}
!llvm.ident = !{!17}

!0 = !DIGlobalVariableExpression(var: !1, expr: !DIExpression())
!1 = distinct !DIGlobalVariable(name: "Person", scope: !2, file: !3, line: 5, type: !6, isLocal: false, isDefinition: true)
!2 = distinct !DICompileUnit(language: DW_LANG_C99, file: !3, producer: "clang version 10.0.0 ", isOptimized: false, runtimeVersion: 0, emissionKind: FullDebug, enums: !4, globals: !5, nameTableKind: None)
!3 = !DIFile(filename: "test_field_sensitive_pdg.c", directory: "/Users/yongzhehuang/Library/Mobile Documents/com~apple~CloudDocs/Documents/llvm_versions/program-dependence-graph/test/pdg_test")
!4 = !{}
!5 = !{!0}
!6 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "Person", file: !3, line: 2, size: 128, elements: !7)
!7 = !{!8, !10}
!8 = !DIDerivedType(tag: DW_TAG_member, name: "age", scope: !6, file: !3, line: 3, baseType: !9, size: 32)
!9 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!10 = !DIDerivedType(tag: DW_TAG_member, name: "name", scope: !6, file: !3, line: 4, baseType: !11, size: 64, offset: 64)
!11 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !12, size: 64)
!12 = !DIBasicType(name: "char", size: 8, encoding: DW_ATE_signed_char)
!13 = !{i32 7, !"Dwarf Version", i32 4}
!14 = !{i32 2, !"Debug Info Version", i32 3}
!15 = !{i32 1, !"wchar_size", i32 4}
!16 = !{i32 7, !"PIC Level", i32 2}
!17 = !{!"clang version 10.0.0 "}
!18 = distinct !DISubprogram(name: "f", scope: !3, file: !3, line: 7, type: !19, scopeLine: 7, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !2, retainedNodes: !4)
!19 = !DISubroutineType(types: !20)
!20 = !{!9, !21}
!21 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !6, size: 64)
!22 = !DILocalVariable(name: "p", arg: 1, scope: !18, file: !3, line: 7, type: !21)
!23 = !DILocation(line: 7, column: 22, scope: !18)
!24 = !DILocation(line: 8, column: 12, scope: !18)
!25 = !DILocation(line: 8, column: 15, scope: !18)
!26 = !DILocation(line: 8, column: 5, scope: !18)
!27 = distinct !DISubprogram(name: "main", scope: !3, file: !3, line: 11, type: !28, scopeLine: 11, spFlags: DISPFlagDefinition, unit: !2, retainedNodes: !4)
!28 = !DISubroutineType(types: !29)
!29 = !{!9}
!30 = !DILocalVariable(name: "p", scope: !27, file: !3, line: 12, type: !6)
!31 = !DILocation(line: 12, column: 19, scope: !27)
!32 = !DILocation(line: 13, column: 5, scope: !27)
!33 = !DILocation(line: 14, column: 5, scope: !27)
