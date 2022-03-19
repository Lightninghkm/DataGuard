; ModuleID = 'test_arr.c'
source_filename = "test_arr.c"
target datalayout = "e-m:o-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-apple-macosx10.15.0"

%struct.st = type { [10 x i32], i32* }

@.str = private unnamed_addr constant [4 x i8] c"%d\0A\00", align 1
@.str.1 = private unnamed_addr constant [6 x i8] c"hello\00", align 1

; Function Attrs: noinline nounwind optnone ssp uwtable
define void @test1(%struct.st* %ss) #0 !dbg !8 {
entry:
  %ss.addr = alloca %struct.st*, align 8
  store %struct.st* %ss, %struct.st** %ss.addr, align 8
  call void @llvm.dbg.declare(metadata %struct.st** %ss.addr, metadata !21, metadata !DIExpression()), !dbg !22
  %0 = load %struct.st*, %struct.st** %ss.addr, align 8, !dbg !23
  %f1 = getelementptr inbounds %struct.st, %struct.st* %0, i32 0, i32 0, !dbg !24
  %arrayidx = getelementptr inbounds [10 x i32], [10 x i32]* %f1, i64 0, i64 0, !dbg !23
  %1 = load i32, i32* %arrayidx, align 8, !dbg !23
  %call = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([4 x i8], [4 x i8]* @.str, i64 0, i64 0), i32 %1), !dbg !25
  ret void, !dbg !26
}

; Function Attrs: nounwind readnone speculatable willreturn
declare void @llvm.dbg.declare(metadata, metadata, metadata) #1

declare i32 @printf(i8*, ...) #2

; Function Attrs: noinline nounwind optnone ssp uwtable
define void @test2(i32* %s, i32 %len) #0 !dbg !27 {
entry:
  %s.addr = alloca i32*, align 8
  %len.addr = alloca i32, align 4
  %c = alloca i32*, align 8
  store i32* %s, i32** %s.addr, align 8
  call void @llvm.dbg.declare(metadata i32** %s.addr, metadata !30, metadata !DIExpression()), !dbg !31
  store i32 %len, i32* %len.addr, align 4
  call void @llvm.dbg.declare(metadata i32* %len.addr, metadata !32, metadata !DIExpression()), !dbg !33
  call void @llvm.dbg.declare(metadata i32** %c, metadata !34, metadata !DIExpression()), !dbg !35
  %0 = load i32*, i32** %s.addr, align 8, !dbg !36
  %arrayidx = getelementptr inbounds i32, i32* %0, i64 2, !dbg !36
  store i32* %arrayidx, i32** %c, align 8, !dbg !35
  %1 = load i32*, i32** %c, align 8, !dbg !37
  %2 = load i32, i32* %1, align 4, !dbg !38
  %call = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([4 x i8], [4 x i8]* @.str, i64 0, i64 0), i32 %2), !dbg !39
  ret void, !dbg !40
}

; Function Attrs: noinline nounwind optnone ssp uwtable
define void @test3(i8* %name) #0 !dbg !41 {
entry:
  %name.addr = alloca i8*, align 8
  %n = alloca i8*, align 8
  store i8* %name, i8** %name.addr, align 8
  call void @llvm.dbg.declare(metadata i8** %name.addr, metadata !46, metadata !DIExpression()), !dbg !47
  call void @llvm.dbg.declare(metadata i8** %n, metadata !48, metadata !DIExpression()), !dbg !49
  store i8* getelementptr inbounds ([6 x i8], [6 x i8]* @.str.1, i64 0, i64 0), i8** %n, align 8, !dbg !49
  %0 = load i8*, i8** %name.addr, align 8, !dbg !50
  %1 = load i8*, i8** %n, align 8, !dbg !50
  %2 = load i8*, i8** %name.addr, align 8, !dbg !50
  %3 = call i64 @llvm.objectsize.i64.p0i8(i8* %2, i1 false, i1 true, i1 false), !dbg !50
  %call = call i8* @__strncpy_chk(i8* %0, i8* %1, i64 5, i64 %3) #4, !dbg !50
  ret void, !dbg !51
}

; Function Attrs: nounwind
declare i8* @__strncpy_chk(i8*, i8*, i64, i64) #3

; Function Attrs: nounwind readnone speculatable willreturn
declare i64 @llvm.objectsize.i64.p0i8(i8*, i1 immarg, i1 immarg, i1 immarg) #1

attributes #0 = { noinline nounwind optnone ssp uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "frame-pointer"="all" "less-precise-fpmad"="false" "min-legal-vector-width"="0" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="penryn" "target-features"="+cx16,+cx8,+fxsr,+mmx,+sahf,+sse,+sse2,+sse3,+sse4.1,+ssse3,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind readnone speculatable willreturn }
attributes #2 = { "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "frame-pointer"="all" "less-precise-fpmad"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="penryn" "target-features"="+cx16,+cx8,+fxsr,+mmx,+sahf,+sse,+sse2,+sse3,+sse4.1,+ssse3,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #3 = { nounwind "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "frame-pointer"="all" "less-precise-fpmad"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="penryn" "target-features"="+cx16,+cx8,+fxsr,+mmx,+sahf,+sse,+sse2,+sse3,+sse4.1,+ssse3,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #4 = { nounwind }

!llvm.dbg.cu = !{!0}
!llvm.module.flags = !{!3, !4, !5, !6}
!llvm.ident = !{!7}

!0 = distinct !DICompileUnit(language: DW_LANG_C99, file: !1, producer: "clang version 10.0.0 ", isOptimized: false, runtimeVersion: 0, emissionKind: FullDebug, enums: !2, nameTableKind: None)
!1 = !DIFile(filename: "test_arr.c", directory: "/Users/yongzhehuang/Library/Mobile Documents/com~apple~CloudDocs/Documents/llvm_versions/program-dependence-graph/test/pdg_test")
!2 = !{}
!3 = !{i32 7, !"Dwarf Version", i32 4}
!4 = !{i32 2, !"Debug Info Version", i32 3}
!5 = !{i32 1, !"wchar_size", i32 4}
!6 = !{i32 7, !"PIC Level", i32 2}
!7 = !{!"clang version 10.0.0 "}
!8 = distinct !DISubprogram(name: "test1", scope: !1, file: !1, line: 9, type: !9, scopeLine: 9, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !2)
!9 = !DISubroutineType(types: !10)
!10 = !{null, !11}
!11 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !12, size: 64)
!12 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "st", file: !1, line: 4, size: 384, elements: !13)
!13 = !{!14, !19}
!14 = !DIDerivedType(tag: DW_TAG_member, name: "f1", scope: !12, file: !1, line: 5, baseType: !15, size: 320)
!15 = !DICompositeType(tag: DW_TAG_array_type, baseType: !16, size: 320, elements: !17)
!16 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!17 = !{!18}
!18 = !DISubrange(count: 10)
!19 = !DIDerivedType(tag: DW_TAG_member, name: "f2", scope: !12, file: !1, line: 6, baseType: !20, size: 64, offset: 320)
!20 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !16, size: 64)
!21 = !DILocalVariable(name: "ss", arg: 1, scope: !8, file: !1, line: 9, type: !11)
!22 = !DILocation(line: 9, column: 23, scope: !8)
!23 = !DILocation(line: 10, column: 19, scope: !8)
!24 = !DILocation(line: 10, column: 23, scope: !8)
!25 = !DILocation(line: 10, column: 4, scope: !8)
!26 = !DILocation(line: 11, column: 1, scope: !8)
!27 = distinct !DISubprogram(name: "test2", scope: !1, file: !1, line: 14, type: !28, scopeLine: 14, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !2)
!28 = !DISubroutineType(types: !29)
!29 = !{null, !20, !16}
!30 = !DILocalVariable(name: "s", arg: 1, scope: !27, file: !1, line: 14, type: !20)
!31 = !DILocation(line: 14, column: 17, scope: !27)
!32 = !DILocalVariable(name: "len", arg: 2, scope: !27, file: !1, line: 14, type: !16)
!33 = !DILocation(line: 14, column: 24, scope: !27)
!34 = !DILocalVariable(name: "c", scope: !27, file: !1, line: 15, type: !20)
!35 = !DILocation(line: 15, column: 10, scope: !27)
!36 = !DILocation(line: 15, column: 15, scope: !27)
!37 = !DILocation(line: 16, column: 21, scope: !27)
!38 = !DILocation(line: 16, column: 20, scope: !27)
!39 = !DILocation(line: 16, column: 5, scope: !27)
!40 = !DILocation(line: 19, column: 1, scope: !27)
!41 = distinct !DISubprogram(name: "test3", scope: !1, file: !1, line: 21, type: !42, scopeLine: 21, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !2)
!42 = !DISubroutineType(types: !43)
!43 = !{null, !44}
!44 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !45, size: 64)
!45 = !DIBasicType(name: "char", size: 8, encoding: DW_ATE_signed_char)
!46 = !DILocalVariable(name: "name", arg: 1, scope: !41, file: !1, line: 21, type: !44)
!47 = !DILocation(line: 21, column: 18, scope: !41)
!48 = !DILocalVariable(name: "n", scope: !41, file: !1, line: 22, type: !44)
!49 = !DILocation(line: 22, column: 10, scope: !41)
!50 = !DILocation(line: 23, column: 4, scope: !41)
!51 = !DILocation(line: 24, column: 1, scope: !41)
