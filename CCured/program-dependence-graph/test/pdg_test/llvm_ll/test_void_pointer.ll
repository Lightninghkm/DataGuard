; ModuleID = 'test_void_pointer.c'
source_filename = "test_void_pointer.c"
target datalayout = "e-m:o-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-apple-macosx10.15.0"

%struct.bar = type { i32, i32 }

@.str = private unnamed_addr constant [4 x i8] c"%d\0A\00", align 1
@__const.main.bae = private unnamed_addr constant %struct.bar { i32 1, i32 2 }, align 4

; Function Attrs: noinline nounwind optnone ssp uwtable
define i8* @bar() #0 !dbg !16 {
entry:
  %b = alloca %struct.bar*, align 8
  call void @llvm.dbg.declare(metadata %struct.bar** %b, metadata !19, metadata !DIExpression()), !dbg !20
  %call = call i8* @malloc(i64 8) #5, !dbg !21
  %0 = bitcast i8* %call to %struct.bar*, !dbg !22
  store %struct.bar* %0, %struct.bar** %b, align 8, !dbg !20
  %1 = load %struct.bar*, %struct.bar** %b, align 8, !dbg !23
  %2 = bitcast %struct.bar* %1 to i8*, !dbg !24
  ret i8* %2, !dbg !25
}

; Function Attrs: nounwind readnone speculatable willreturn
declare void @llvm.dbg.declare(metadata, metadata, metadata) #1

; Function Attrs: allocsize(0)
declare i8* @malloc(i64) #2

; Function Attrs: noinline nounwind optnone ssp uwtable
define void @foo(i8* %data) #0 !dbg !26 {
entry:
  %data.addr = alloca i8*, align 8
  %bae = alloca %struct.bar*, align 8
  store i8* %data, i8** %data.addr, align 8
  call void @llvm.dbg.declare(metadata i8** %data.addr, metadata !29, metadata !DIExpression()), !dbg !30
  call void @llvm.dbg.declare(metadata %struct.bar** %bae, metadata !31, metadata !DIExpression()), !dbg !32
  %0 = load i8*, i8** %data.addr, align 8, !dbg !33
  %1 = bitcast i8* %0 to %struct.bar*, !dbg !34
  store %struct.bar* %1, %struct.bar** %bae, align 8, !dbg !32
  %2 = load %struct.bar*, %struct.bar** %bae, align 8, !dbg !35
  %a = getelementptr inbounds %struct.bar, %struct.bar* %2, i32 0, i32 0, !dbg !36
  %3 = load i32, i32* %a, align 4, !dbg !36
  %call = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([4 x i8], [4 x i8]* @.str, i64 0, i64 0), i32 %3), !dbg !37
  ret void, !dbg !38
}

declare i32 @printf(i8*, ...) #3

; Function Attrs: noinline nounwind optnone ssp uwtable
define i32 @main() #0 !dbg !39 {
entry:
  %retval = alloca i32, align 4
  %bae = alloca %struct.bar, align 4
  store i32 0, i32* %retval, align 4
  call void @llvm.dbg.declare(metadata %struct.bar* %bae, metadata !42, metadata !DIExpression()), !dbg !43
  %0 = bitcast %struct.bar* %bae to i8*, !dbg !43
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 4 %0, i8* align 4 bitcast (%struct.bar* @__const.main.bae to i8*), i64 8, i1 false), !dbg !43
  %1 = bitcast %struct.bar* %bae to i8*, !dbg !44
  call void @foo(i8* %1), !dbg !45
  ret i32 0, !dbg !46
}

; Function Attrs: argmemonly nounwind willreturn
declare void @llvm.memcpy.p0i8.p0i8.i64(i8* noalias nocapture writeonly, i8* noalias nocapture readonly, i64, i1 immarg) #4

attributes #0 = { noinline nounwind optnone ssp uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "frame-pointer"="all" "less-precise-fpmad"="false" "min-legal-vector-width"="0" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="penryn" "target-features"="+cx16,+cx8,+fxsr,+mmx,+sahf,+sse,+sse2,+sse3,+sse4.1,+ssse3,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind readnone speculatable willreturn }
attributes #2 = { allocsize(0) "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "frame-pointer"="all" "less-precise-fpmad"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="penryn" "target-features"="+cx16,+cx8,+fxsr,+mmx,+sahf,+sse,+sse2,+sse3,+sse4.1,+ssse3,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #3 = { "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "frame-pointer"="all" "less-precise-fpmad"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="penryn" "target-features"="+cx16,+cx8,+fxsr,+mmx,+sahf,+sse,+sse2,+sse3,+sse4.1,+ssse3,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #4 = { argmemonly nounwind willreturn }
attributes #5 = { allocsize(0) }

!llvm.dbg.cu = !{!0}
!llvm.module.flags = !{!11, !12, !13, !14}
!llvm.ident = !{!15}

!0 = distinct !DICompileUnit(language: DW_LANG_C99, file: !1, producer: "clang version 10.0.0 ", isOptimized: false, runtimeVersion: 0, emissionKind: FullDebug, enums: !2, retainedTypes: !3, nameTableKind: None)
!1 = !DIFile(filename: "test_void_pointer.c", directory: "/Users/yongzhehuang/Library/Mobile Documents/com~apple~CloudDocs/Documents/llvm_versions/program-dependence-graph/test/pdg_test")
!2 = !{}
!3 = !{!4, !10}
!4 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !5, size: 64)
!5 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "bar", file: !1, line: 3, size: 64, elements: !6)
!6 = !{!7, !9}
!7 = !DIDerivedType(tag: DW_TAG_member, name: "a", scope: !5, file: !1, line: 4, baseType: !8, size: 32)
!8 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!9 = !DIDerivedType(tag: DW_TAG_member, name: "b", scope: !5, file: !1, line: 5, baseType: !8, size: 32, offset: 32)
!10 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: null, size: 64)
!11 = !{i32 7, !"Dwarf Version", i32 4}
!12 = !{i32 2, !"Debug Info Version", i32 3}
!13 = !{i32 1, !"wchar_size", i32 4}
!14 = !{i32 7, !"PIC Level", i32 2}
!15 = !{!"clang version 10.0.0 "}
!16 = distinct !DISubprogram(name: "bar", scope: !1, file: !1, line: 8, type: !17, scopeLine: 8, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !2)
!17 = !DISubroutineType(types: !18)
!18 = !{!10}
!19 = !DILocalVariable(name: "b", scope: !16, file: !1, line: 9, type: !4)
!20 = !DILocation(line: 9, column: 17, scope: !16)
!21 = !DILocation(line: 9, column: 35, scope: !16)
!22 = !DILocation(line: 9, column: 21, scope: !16)
!23 = !DILocation(line: 10, column: 19, scope: !16)
!24 = !DILocation(line: 10, column: 12, scope: !16)
!25 = !DILocation(line: 10, column: 5, scope: !16)
!26 = distinct !DISubprogram(name: "foo", scope: !1, file: !1, line: 13, type: !27, scopeLine: 13, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !2)
!27 = !DISubroutineType(types: !28)
!28 = !{null, !10}
!29 = !DILocalVariable(name: "data", arg: 1, scope: !26, file: !1, line: 13, type: !10)
!30 = !DILocation(line: 13, column: 16, scope: !26)
!31 = !DILocalVariable(name: "bae", scope: !26, file: !1, line: 14, type: !4)
!32 = !DILocation(line: 14, column: 17, scope: !26)
!33 = !DILocation(line: 14, column: 36, scope: !26)
!34 = !DILocation(line: 14, column: 23, scope: !26)
!35 = !DILocation(line: 15, column: 20, scope: !26)
!36 = !DILocation(line: 15, column: 25, scope: !26)
!37 = !DILocation(line: 15, column: 5, scope: !26)
!38 = !DILocation(line: 16, column: 1, scope: !26)
!39 = distinct !DISubprogram(name: "main", scope: !1, file: !1, line: 18, type: !40, scopeLine: 18, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !2)
!40 = !DISubroutineType(types: !41)
!41 = !{!8}
!42 = !DILocalVariable(name: "bae", scope: !39, file: !1, line: 19, type: !5)
!43 = !DILocation(line: 19, column: 16, scope: !39)
!44 = !DILocation(line: 20, column: 9, scope: !39)
!45 = !DILocation(line: 20, column: 5, scope: !39)
!46 = !DILocation(line: 21, column: 5, scope: !39)
