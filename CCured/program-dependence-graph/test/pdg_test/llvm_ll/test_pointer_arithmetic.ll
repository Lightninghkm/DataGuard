; ModuleID = 'test_pointer_arithmetic.c'
source_filename = "test_pointer_arithmetic.c"
target datalayout = "e-m:o-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-apple-macosx10.15.0"

%struct.st = type { i32, i32 }

@.str = private unnamed_addr constant [4 x i8] c"%d\0A\00", align 1

; Function Attrs: noinline nounwind optnone ssp uwtable
define i32 @main() #0 !dbg !15 {
entry:
  %retval = alloca i32, align 4
  %s = alloca %struct.st*, align 8
  %c = alloca i32, align 4
  store i32 0, i32* %retval, align 4
  call void @llvm.dbg.declare(metadata %struct.st** %s, metadata !18, metadata !DIExpression()), !dbg !19
  %call = call i8* @malloc(i64 8) #4, !dbg !20
  %0 = bitcast i8* %call to %struct.st*, !dbg !21
  store %struct.st* %0, %struct.st** %s, align 8, !dbg !19
  call void @llvm.dbg.declare(metadata i32* %c, metadata !22, metadata !DIExpression()), !dbg !23
  store i32 4, i32* %c, align 4, !dbg !23
  %1 = load %struct.st*, %struct.st** %s, align 8, !dbg !24
  %a = getelementptr inbounds %struct.st, %struct.st* %1, i32 0, i32 0, !dbg !25
  store i32 5, i32* %a, align 4, !dbg !26
  %2 = load %struct.st*, %struct.st** %s, align 8, !dbg !27
  %b = getelementptr inbounds %struct.st, %struct.st* %2, i32 0, i32 1, !dbg !28
  store i32 10, i32* %b, align 4, !dbg !29
  %3 = load i32, i32* %c, align 4, !dbg !30
  %4 = load %struct.st*, %struct.st** %s, align 8, !dbg !31
  %idx.ext = sext i32 %3 to i64, !dbg !31
  %add.ptr = getelementptr inbounds %struct.st, %struct.st* %4, i64 %idx.ext, !dbg !31
  store %struct.st* %add.ptr, %struct.st** %s, align 8, !dbg !31
  %5 = load %struct.st*, %struct.st** %s, align 8, !dbg !32
  %6 = bitcast %struct.st* %5 to i64*, !dbg !33
  %7 = load i64, i64* %6, align 4, !dbg !33
  %call1 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([4 x i8], [4 x i8]* @.str, i64 0, i64 0), i64 %7), !dbg !33
  ret i32 0, !dbg !34
}

; Function Attrs: nounwind readnone speculatable willreturn
declare void @llvm.dbg.declare(metadata, metadata, metadata) #1

; Function Attrs: allocsize(0)
declare i8* @malloc(i64) #2

declare i32 @printf(i8*, ...) #3

attributes #0 = { noinline nounwind optnone ssp uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "frame-pointer"="all" "less-precise-fpmad"="false" "min-legal-vector-width"="0" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="penryn" "target-features"="+cx16,+cx8,+fxsr,+mmx,+sahf,+sse,+sse2,+sse3,+sse4.1,+ssse3,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind readnone speculatable willreturn }
attributes #2 = { allocsize(0) "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "frame-pointer"="all" "less-precise-fpmad"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="penryn" "target-features"="+cx16,+cx8,+fxsr,+mmx,+sahf,+sse,+sse2,+sse3,+sse4.1,+ssse3,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #3 = { "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "frame-pointer"="all" "less-precise-fpmad"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="penryn" "target-features"="+cx16,+cx8,+fxsr,+mmx,+sahf,+sse,+sse2,+sse3,+sse4.1,+ssse3,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #4 = { allocsize(0) }

!llvm.dbg.cu = !{!0}
!llvm.module.flags = !{!10, !11, !12, !13}
!llvm.ident = !{!14}

!0 = distinct !DICompileUnit(language: DW_LANG_C99, file: !1, producer: "clang version 10.0.0 ", isOptimized: false, runtimeVersion: 0, emissionKind: FullDebug, enums: !2, retainedTypes: !3, nameTableKind: None)
!1 = !DIFile(filename: "test_pointer_arithmetic.c", directory: "/Users/yongzhehuang/Library/Mobile Documents/com~apple~CloudDocs/Documents/llvm_versions/program-dependence-graph/test/pdg_test")
!2 = !{}
!3 = !{!4}
!4 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !5, size: 64)
!5 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "st", file: !1, line: 3, size: 64, elements: !6)
!6 = !{!7, !9}
!7 = !DIDerivedType(tag: DW_TAG_member, name: "a", scope: !5, file: !1, line: 4, baseType: !8, size: 32)
!8 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!9 = !DIDerivedType(tag: DW_TAG_member, name: "b", scope: !5, file: !1, line: 5, baseType: !8, size: 32, offset: 32)
!10 = !{i32 7, !"Dwarf Version", i32 4}
!11 = !{i32 2, !"Debug Info Version", i32 3}
!12 = !{i32 1, !"wchar_size", i32 4}
!13 = !{i32 7, !"PIC Level", i32 2}
!14 = !{!"clang version 10.0.0 "}
!15 = distinct !DISubprogram(name: "main", scope: !1, file: !1, line: 8, type: !16, scopeLine: 8, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !2)
!16 = !DISubroutineType(types: !17)
!17 = !{!8}
!18 = !DILocalVariable(name: "s", scope: !15, file: !1, line: 9, type: !4)
!19 = !DILocation(line: 9, column: 14, scope: !15)
!20 = !DILocation(line: 9, column: 30, scope: !15)
!21 = !DILocation(line: 9, column: 18, scope: !15)
!22 = !DILocalVariable(name: "c", scope: !15, file: !1, line: 10, type: !8)
!23 = !DILocation(line: 10, column: 7, scope: !15)
!24 = !DILocation(line: 11, column: 3, scope: !15)
!25 = !DILocation(line: 11, column: 6, scope: !15)
!26 = !DILocation(line: 11, column: 8, scope: !15)
!27 = !DILocation(line: 12, column: 3, scope: !15)
!28 = !DILocation(line: 12, column: 6, scope: !15)
!29 = !DILocation(line: 12, column: 8, scope: !15)
!30 = !DILocation(line: 13, column: 8, scope: !15)
!31 = !DILocation(line: 13, column: 5, scope: !15)
!32 = !DILocation(line: 14, column: 19, scope: !15)
!33 = !DILocation(line: 14, column: 3, scope: !15)
!34 = !DILocation(line: 15, column: 3, scope: !15)
