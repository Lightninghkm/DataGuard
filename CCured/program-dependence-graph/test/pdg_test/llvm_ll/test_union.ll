; ModuleID = 'test_union.c'
source_filename = "test_union.c"
target datalayout = "e-m:o-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-apple-macosx10.15.0"

%union.UTEST = type { %struct.anon }
%struct.anon = type { i32, i32 }

; Function Attrs: noinline nounwind optnone ssp uwtable
define i32 @f(%union.UTEST* %utest) #0 !dbg !8 {
entry:
  %retval = alloca i32, align 4
  %utest.addr = alloca %union.UTEST*, align 8
  store %union.UTEST* %utest, %union.UTEST** %utest.addr, align 8
  call void @llvm.dbg.declare(metadata %union.UTEST** %utest.addr, metadata !24, metadata !DIExpression()), !dbg !25
  %0 = load %union.UTEST*, %union.UTEST** %utest.addr, align 8, !dbg !26
  %B = bitcast %union.UTEST* %0 to %struct.anon*, !dbg !28
  %c = getelementptr inbounds %struct.anon, %struct.anon* %B, i32 0, i32 0, !dbg !29
  %1 = load i32, i32* %c, align 4, !dbg !29
  %cmp = icmp sgt i32 %1, 5, !dbg !30
  br i1 %cmp, label %if.then, label %if.end, !dbg !31

if.then:                                          ; preds = %entry
  %2 = load %union.UTEST*, %union.UTEST** %utest.addr, align 8, !dbg !32
  %B1 = bitcast %union.UTEST* %2 to %struct.anon*, !dbg !33
  %c2 = getelementptr inbounds %struct.anon, %struct.anon* %B1, i32 0, i32 0, !dbg !34
  %3 = load i32, i32* %c2, align 4, !dbg !34
  store i32 %3, i32* %retval, align 4, !dbg !35
  br label %return, !dbg !35

if.end:                                           ; preds = %entry
  store i32 5, i32* %retval, align 4, !dbg !36
  br label %return, !dbg !36

return:                                           ; preds = %if.end, %if.then
  %4 = load i32, i32* %retval, align 4, !dbg !37
  ret i32 %4, !dbg !37
}

; Function Attrs: nounwind readnone speculatable willreturn
declare void @llvm.dbg.declare(metadata, metadata, metadata) #1

; Function Attrs: noinline nounwind optnone ssp uwtable
define i32 @main() #0 !dbg !38 {
entry:
  %retval = alloca i32, align 4
  %utest = alloca %union.UTEST, align 4
  store i32 0, i32* %retval, align 4
  call void @llvm.dbg.declare(metadata %union.UTEST* %utest, metadata !41, metadata !DIExpression()), !dbg !42
  %B = bitcast %union.UTEST* %utest to %struct.anon*, !dbg !43
  %c = getelementptr inbounds %struct.anon, %struct.anon* %B, i32 0, i32 0, !dbg !44
  store i32 10, i32* %c, align 4, !dbg !45
  %call = call i32 @f(%union.UTEST* %utest), !dbg !46
  ret i32 0, !dbg !47
}

attributes #0 = { noinline nounwind optnone ssp uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "frame-pointer"="all" "less-precise-fpmad"="false" "min-legal-vector-width"="0" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="penryn" "target-features"="+cx16,+cx8,+fxsr,+mmx,+sahf,+sse,+sse2,+sse3,+sse4.1,+ssse3,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind readnone speculatable willreturn }

!llvm.dbg.cu = !{!0}
!llvm.module.flags = !{!3, !4, !5, !6}
!llvm.ident = !{!7}

!0 = distinct !DICompileUnit(language: DW_LANG_C99, file: !1, producer: "clang version 10.0.0 ", isOptimized: false, runtimeVersion: 0, emissionKind: FullDebug, enums: !2, nameTableKind: None)
!1 = !DIFile(filename: "test_union.c", directory: "/Users/yongzhehuang/Library/Mobile Documents/com~apple~CloudDocs/Documents/llvm_versions/program-dependence-graph/test/pdg_test")
!2 = !{}
!3 = !{i32 7, !"Dwarf Version", i32 4}
!4 = !{i32 2, !"Debug Info Version", i32 3}
!5 = !{i32 1, !"wchar_size", i32 4}
!6 = !{i32 7, !"PIC Level", i32 2}
!7 = !{!"clang version 10.0.0 "}
!8 = distinct !DISubprogram(name: "f", scope: !1, file: !1, line: 14, type: !9, scopeLine: 14, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !2)
!9 = !DISubroutineType(types: !10)
!10 = !{!11, !12}
!11 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!12 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !13, size: 64)
!13 = distinct !DICompositeType(tag: DW_TAG_union_type, name: "UTEST", file: !1, line: 4, size: 64, elements: !14)
!14 = !{!15, !20}
!15 = !DIDerivedType(tag: DW_TAG_member, name: "B", scope: !13, file: !1, line: 8, baseType: !16, size: 64)
!16 = distinct !DICompositeType(tag: DW_TAG_structure_type, scope: !13, file: !1, line: 5, size: 64, elements: !17)
!17 = !{!18, !19}
!18 = !DIDerivedType(tag: DW_TAG_member, name: "c", scope: !16, file: !1, line: 6, baseType: !11, size: 32)
!19 = !DIDerivedType(tag: DW_TAG_member, name: "b", scope: !16, file: !1, line: 7, baseType: !11, size: 32, offset: 32)
!20 = !DIDerivedType(tag: DW_TAG_member, name: "C", scope: !13, file: !1, line: 11, baseType: !21, size: 32)
!21 = distinct !DICompositeType(tag: DW_TAG_structure_type, scope: !13, file: !1, line: 9, size: 32, elements: !22)
!22 = !{!23}
!23 = !DIDerivedType(tag: DW_TAG_member, name: "d", scope: !21, file: !1, line: 10, baseType: !11, size: 32)
!24 = !DILocalVariable(name: "utest", arg: 1, scope: !8, file: !1, line: 14, type: !12)
!25 = !DILocation(line: 14, column: 20, scope: !8)
!26 = !DILocation(line: 15, column: 9, scope: !27)
!27 = distinct !DILexicalBlock(scope: !8, file: !1, line: 15, column: 9)
!28 = !DILocation(line: 15, column: 16, scope: !27)
!29 = !DILocation(line: 15, column: 18, scope: !27)
!30 = !DILocation(line: 15, column: 20, scope: !27)
!31 = !DILocation(line: 15, column: 9, scope: !8)
!32 = !DILocation(line: 16, column: 16, scope: !27)
!33 = !DILocation(line: 16, column: 23, scope: !27)
!34 = !DILocation(line: 16, column: 25, scope: !27)
!35 = !DILocation(line: 16, column: 9, scope: !27)
!36 = !DILocation(line: 17, column: 5, scope: !8)
!37 = !DILocation(line: 18, column: 1, scope: !8)
!38 = distinct !DISubprogram(name: "main", scope: !1, file: !1, line: 20, type: !39, scopeLine: 20, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !2)
!39 = !DISubroutineType(types: !40)
!40 = !{!11}
!41 = !DILocalVariable(name: "utest", scope: !38, file: !1, line: 21, type: !13)
!42 = !DILocation(line: 21, column: 17, scope: !38)
!43 = !DILocation(line: 22, column: 11, scope: !38)
!44 = !DILocation(line: 22, column: 13, scope: !38)
!45 = !DILocation(line: 22, column: 15, scope: !38)
!46 = !DILocation(line: 23, column: 5, scope: !38)
!47 = !DILocation(line: 24, column: 5, scope: !38)
