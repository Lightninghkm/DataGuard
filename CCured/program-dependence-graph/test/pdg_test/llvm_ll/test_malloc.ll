; ModuleID = 'test_malloc.c'
source_filename = "test_malloc.c"
target datalayout = "e-m:o-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-apple-macosx10.15.0"

%struct.foo = type { i32, %struct.bar* }
%struct.bar = type { i32, float }

; Function Attrs: noinline nounwind optnone ssp uwtable
define void @test1(%struct.foo* %f) #0 !dbg !21 {
entry:
  %f.addr = alloca %struct.foo*, align 8
  store %struct.foo* %f, %struct.foo** %f.addr, align 8
  call void @llvm.dbg.declare(metadata %struct.foo** %f.addr, metadata !24, metadata !DIExpression()), !dbg !25
  %call = call i8* @malloc(i64 16) #3, !dbg !26
  %0 = bitcast i8* %call to %struct.foo*, !dbg !27
  store %struct.foo* %0, %struct.foo** %f.addr, align 8, !dbg !28
  ret void, !dbg !29
}

; Function Attrs: nounwind readnone speculatable willreturn
declare void @llvm.dbg.declare(metadata, metadata, metadata) #1

; Function Attrs: allocsize(0)
declare i8* @malloc(i64) #2

attributes #0 = { noinline nounwind optnone ssp uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "frame-pointer"="all" "less-precise-fpmad"="false" "min-legal-vector-width"="0" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="penryn" "target-features"="+cx16,+cx8,+fxsr,+mmx,+sahf,+sse,+sse2,+sse3,+sse4.1,+ssse3,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind readnone speculatable willreturn }
attributes #2 = { allocsize(0) "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "frame-pointer"="all" "less-precise-fpmad"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="penryn" "target-features"="+cx16,+cx8,+fxsr,+mmx,+sahf,+sse,+sse2,+sse3,+sse4.1,+ssse3,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #3 = { allocsize(0) }

!llvm.dbg.cu = !{!0}
!llvm.module.flags = !{!16, !17, !18, !19}
!llvm.ident = !{!20}

!0 = distinct !DICompileUnit(language: DW_LANG_C99, file: !1, producer: "clang version 10.0.0 ", isOptimized: false, runtimeVersion: 0, emissionKind: FullDebug, enums: !2, retainedTypes: !3, nameTableKind: None)
!1 = !DIFile(filename: "test_malloc.c", directory: "/Users/yongzhehuang/Library/Mobile Documents/com~apple~CloudDocs/Documents/llvm_versions/program-dependence-graph/test/pdg_test")
!2 = !{}
!3 = !{!4}
!4 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !5, size: 64)
!5 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "foo", file: !1, line: 9, size: 128, elements: !6)
!6 = !{!7, !9}
!7 = !DIDerivedType(tag: DW_TAG_member, name: "f1", scope: !5, file: !1, line: 10, baseType: !8, size: 32)
!8 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!9 = !DIDerivedType(tag: DW_TAG_member, name: "b", scope: !5, file: !1, line: 11, baseType: !10, size: 64, offset: 64)
!10 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !11, size: 64)
!11 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "bar", file: !1, line: 4, size: 64, elements: !12)
!12 = !{!13, !14}
!13 = !DIDerivedType(tag: DW_TAG_member, name: "b1", scope: !11, file: !1, line: 5, baseType: !8, size: 32)
!14 = !DIDerivedType(tag: DW_TAG_member, name: "b2", scope: !11, file: !1, line: 6, baseType: !15, size: 32, offset: 32)
!15 = !DIBasicType(name: "float", size: 32, encoding: DW_ATE_float)
!16 = !{i32 7, !"Dwarf Version", i32 4}
!17 = !{i32 2, !"Debug Info Version", i32 3}
!18 = !{i32 1, !"wchar_size", i32 4}
!19 = !{i32 7, !"PIC Level", i32 2}
!20 = !{!"clang version 10.0.0 "}
!21 = distinct !DISubprogram(name: "test1", scope: !1, file: !1, line: 14, type: !22, scopeLine: 14, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !2)
!22 = !DISubroutineType(types: !23)
!23 = !{null, !4}
!24 = !DILocalVariable(name: "f", arg: 1, scope: !21, file: !1, line: 14, type: !4)
!25 = !DILocation(line: 14, column: 24, scope: !21)
!26 = !DILocation(line: 15, column: 22, scope: !21)
!27 = !DILocation(line: 15, column: 9, scope: !21)
!28 = !DILocation(line: 15, column: 7, scope: !21)
!29 = !DILocation(line: 16, column: 1, scope: !21)
