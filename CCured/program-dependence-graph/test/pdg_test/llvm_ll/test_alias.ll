; ModuleID = 'test_alias.c'
source_filename = "test_alias.c"
target datalayout = "e-m:o-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-apple-macosx10.15.0"

%struct.C = type { i32, i32 }

; Function Attrs: noinline nounwind optnone ssp uwtable
define i32* @f(%struct.C* %c) #0 !dbg !8 {
entry:
  %c.addr = alloca %struct.C*, align 8
  store %struct.C* %c, %struct.C** %c.addr, align 8
  call void @llvm.dbg.declare(metadata %struct.C** %c.addr, metadata !18, metadata !DIExpression()), !dbg !19
  %0 = load %struct.C*, %struct.C** %c.addr, align 8, !dbg !20
  %a = getelementptr inbounds %struct.C, %struct.C* %0, i32 0, i32 0, !dbg !21
  ret i32* %a, !dbg !22
}

; Function Attrs: nounwind readnone speculatable willreturn
declare void @llvm.dbg.declare(metadata, metadata, metadata) #1

; Function Attrs: noinline nounwind optnone ssp uwtable
define i32 @main() #0 !dbg !23 {
entry:
  %retval = alloca i32, align 4
  %a = alloca i32, align 4
  %c = alloca %struct.C, align 4
  %b2 = alloca i32*, align 8
  store i32 0, i32* %retval, align 4
  call void @llvm.dbg.declare(metadata i32* %a, metadata !26, metadata !DIExpression()), !dbg !27
  store i32 5, i32* %a, align 4, !dbg !27
  call void @llvm.dbg.declare(metadata %struct.C* %c, metadata !28, metadata !DIExpression()), !dbg !29
  %a1 = getelementptr inbounds %struct.C, %struct.C* %c, i32 0, i32 0, !dbg !30
  %0 = load i32, i32* %a, align 4, !dbg !31
  store i32 %0, i32* %a1, align 4, !dbg !30
  %b = getelementptr inbounds %struct.C, %struct.C* %c, i32 0, i32 1, !dbg !30
  store i32 3, i32* %b, align 4, !dbg !30
  call void @llvm.dbg.declare(metadata i32** %b2, metadata !32, metadata !DIExpression()), !dbg !33
  %call = call i32* @f(%struct.C* %c), !dbg !34
  store i32* %call, i32** %b2, align 8, !dbg !33
  ret i32 0, !dbg !35
}

attributes #0 = { noinline nounwind optnone ssp uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "frame-pointer"="all" "less-precise-fpmad"="false" "min-legal-vector-width"="0" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="penryn" "target-features"="+cx16,+cx8,+fxsr,+mmx,+sahf,+sse,+sse2,+sse3,+sse4.1,+ssse3,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind readnone speculatable willreturn }

!llvm.dbg.cu = !{!0}
!llvm.module.flags = !{!3, !4, !5, !6}
!llvm.ident = !{!7}

!0 = distinct !DICompileUnit(language: DW_LANG_C99, file: !1, producer: "clang version 10.0.0 ", isOptimized: false, runtimeVersion: 0, emissionKind: FullDebug, enums: !2, nameTableKind: None)
!1 = !DIFile(filename: "test_alias.c", directory: "/Users/yongzhehuang/Library/Mobile Documents/com~apple~CloudDocs/Documents/llvm_versions/program-dependence-graph/test/pdg_test")
!2 = !{}
!3 = !{i32 7, !"Dwarf Version", i32 4}
!4 = !{i32 2, !"Debug Info Version", i32 3}
!5 = !{i32 1, !"wchar_size", i32 4}
!6 = !{i32 7, !"PIC Level", i32 2}
!7 = !{!"clang version 10.0.0 "}
!8 = distinct !DISubprogram(name: "f", scope: !1, file: !1, line: 8, type: !9, scopeLine: 8, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !2)
!9 = !DISubroutineType(types: !10)
!10 = !{!11, !13}
!11 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !12, size: 64)
!12 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!13 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !14, size: 64)
!14 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "C", file: !1, line: 3, size: 64, elements: !15)
!15 = !{!16, !17}
!16 = !DIDerivedType(tag: DW_TAG_member, name: "a", scope: !14, file: !1, line: 4, baseType: !12, size: 32)
!17 = !DIDerivedType(tag: DW_TAG_member, name: "b", scope: !14, file: !1, line: 5, baseType: !12, size: 32, offset: 32)
!18 = !DILocalVariable(name: "c", arg: 1, scope: !8, file: !1, line: 8, type: !13)
!19 = !DILocation(line: 8, column: 18, scope: !8)
!20 = !DILocation(line: 9, column: 14, scope: !8)
!21 = !DILocation(line: 9, column: 17, scope: !8)
!22 = !DILocation(line: 9, column: 5, scope: !8)
!23 = distinct !DISubprogram(name: "main", scope: !1, file: !1, line: 12, type: !24, scopeLine: 12, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !2)
!24 = !DISubroutineType(types: !25)
!25 = !{!12}
!26 = !DILocalVariable(name: "a", scope: !23, file: !1, line: 13, type: !12)
!27 = !DILocation(line: 13, column: 9, scope: !23)
!28 = !DILocalVariable(name: "c", scope: !23, file: !1, line: 14, type: !14)
!29 = !DILocation(line: 14, column: 14, scope: !23)
!30 = !DILocation(line: 14, column: 18, scope: !23)
!31 = !DILocation(line: 14, column: 19, scope: !23)
!32 = !DILocalVariable(name: "b", scope: !23, file: !1, line: 15, type: !11)
!33 = !DILocation(line: 15, column: 10, scope: !23)
!34 = !DILocation(line: 15, column: 14, scope: !23)
!35 = !DILocation(line: 16, column: 5, scope: !23)
