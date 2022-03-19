; ModuleID = 'test_indirect_call.c'
source_filename = "test_indirect_call.c"
target datalayout = "e-m:o-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-apple-macosx10.15.0"

%struct.A = type { void (i32*)*, i32 }

@.str = private unnamed_addr constant [4 x i8] c"%d\0A\00", align 1

; Function Attrs: noinline nounwind optnone ssp uwtable
define void @f1(i32* %b) #0 !dbg !8 {
entry:
  %b.addr = alloca i32*, align 8
  store i32* %b, i32** %b.addr, align 8
  call void @llvm.dbg.declare(metadata i32** %b.addr, metadata !13, metadata !DIExpression()), !dbg !14
  %0 = load i32*, i32** %b.addr, align 8, !dbg !15
  %1 = load i32, i32* %0, align 4, !dbg !16
  %call = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([4 x i8], [4 x i8]* @.str, i64 0, i64 0), i32 %1), !dbg !17
  ret void, !dbg !18
}

; Function Attrs: nounwind readnone speculatable willreturn
declare void @llvm.dbg.declare(metadata, metadata, metadata) #1

declare i32 @printf(i8*, ...) #2

; Function Attrs: noinline nounwind optnone ssp uwtable
define i32 @f(%struct.A* %a) #0 !dbg !19 {
entry:
  %a.addr = alloca %struct.A*, align 8
  store %struct.A* %a, %struct.A** %a.addr, align 8
  call void @llvm.dbg.declare(metadata %struct.A** %a.addr, metadata !28, metadata !DIExpression()), !dbg !29
  %0 = load %struct.A*, %struct.A** %a.addr, align 8, !dbg !30
  %setup = getelementptr inbounds %struct.A, %struct.A* %0, i32 0, i32 0, !dbg !31
  store void (i32*)* @f1, void (i32*)** %setup, align 8, !dbg !32
  %1 = load %struct.A*, %struct.A** %a.addr, align 8, !dbg !33
  %setup1 = getelementptr inbounds %struct.A, %struct.A* %1, i32 0, i32 0, !dbg !34
  %2 = load void (i32*)*, void (i32*)** %setup1, align 8, !dbg !34
  %3 = load %struct.A*, %struct.A** %a.addr, align 8, !dbg !35
  %a2 = getelementptr inbounds %struct.A, %struct.A* %3, i32 0, i32 1, !dbg !36
  call void %2(i32* %a2), !dbg !37
  ret i32 0, !dbg !38
}

; Function Attrs: noinline nounwind optnone ssp uwtable
define i32 @main() #0 !dbg !39 {
entry:
  ret i32 0, !dbg !42
}

attributes #0 = { noinline nounwind optnone ssp uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "frame-pointer"="all" "less-precise-fpmad"="false" "min-legal-vector-width"="0" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="penryn" "target-features"="+cx16,+cx8,+fxsr,+mmx,+sahf,+sse,+sse2,+sse3,+sse4.1,+ssse3,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind readnone speculatable willreturn }
attributes #2 = { "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "frame-pointer"="all" "less-precise-fpmad"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="penryn" "target-features"="+cx16,+cx8,+fxsr,+mmx,+sahf,+sse,+sse2,+sse3,+sse4.1,+ssse3,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }

!llvm.dbg.cu = !{!0}
!llvm.module.flags = !{!3, !4, !5, !6}
!llvm.ident = !{!7}

!0 = distinct !DICompileUnit(language: DW_LANG_C99, file: !1, producer: "clang version 10.0.0 ", isOptimized: false, runtimeVersion: 0, emissionKind: FullDebug, enums: !2, nameTableKind: None)
!1 = !DIFile(filename: "test_indirect_call.c", directory: "/Users/yongzhehuang/Library/Mobile Documents/com~apple~CloudDocs/Documents/llvm_versions/program-dependence-graph/test/pdg_test")
!2 = !{}
!3 = !{i32 7, !"Dwarf Version", i32 4}
!4 = !{i32 2, !"Debug Info Version", i32 3}
!5 = !{i32 1, !"wchar_size", i32 4}
!6 = !{i32 7, !"PIC Level", i32 2}
!7 = !{!"clang version 10.0.0 "}
!8 = distinct !DISubprogram(name: "f1", scope: !1, file: !1, line: 7, type: !9, scopeLine: 7, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !2)
!9 = !DISubroutineType(types: !10)
!10 = !{null, !11}
!11 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !12, size: 64)
!12 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!13 = !DILocalVariable(name: "b", arg: 1, scope: !8, file: !1, line: 7, type: !11)
!14 = !DILocation(line: 7, column: 14, scope: !8)
!15 = !DILocation(line: 8, column: 21, scope: !8)
!16 = !DILocation(line: 8, column: 20, scope: !8)
!17 = !DILocation(line: 8, column: 5, scope: !8)
!18 = !DILocation(line: 9, column: 1, scope: !8)
!19 = distinct !DISubprogram(name: "f", scope: !1, file: !1, line: 11, type: !20, scopeLine: 11, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !2)
!20 = !DISubroutineType(types: !21)
!21 = !{!12, !22}
!22 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !23, size: 64)
!23 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "A", file: !1, line: 2, size: 128, elements: !24)
!24 = !{!25, !27}
!25 = !DIDerivedType(tag: DW_TAG_member, name: "setup", scope: !23, file: !1, line: 3, baseType: !26, size: 64)
!26 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !9, size: 64)
!27 = !DIDerivedType(tag: DW_TAG_member, name: "a", scope: !23, file: !1, line: 4, baseType: !12, size: 32, offset: 64)
!28 = !DILocalVariable(name: "a", arg: 1, scope: !19, file: !1, line: 11, type: !22)
!29 = !DILocation(line: 11, column: 17, scope: !19)
!30 = !DILocation(line: 12, column: 5, scope: !19)
!31 = !DILocation(line: 12, column: 8, scope: !19)
!32 = !DILocation(line: 12, column: 14, scope: !19)
!33 = !DILocation(line: 13, column: 7, scope: !19)
!34 = !DILocation(line: 13, column: 10, scope: !19)
!35 = !DILocation(line: 13, column: 18, scope: !19)
!36 = !DILocation(line: 13, column: 21, scope: !19)
!37 = !DILocation(line: 13, column: 5, scope: !19)
!38 = !DILocation(line: 14, column: 5, scope: !19)
!39 = distinct !DISubprogram(name: "main", scope: !1, file: !1, line: 18, type: !40, scopeLine: 18, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !2)
!40 = !DISubroutineType(types: !41)
!41 = !{!12}
!42 = !DILocation(line: 20, column: 1, scope: !39)
