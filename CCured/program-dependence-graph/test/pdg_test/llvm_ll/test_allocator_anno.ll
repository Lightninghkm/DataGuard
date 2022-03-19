; ModuleID = 'test_allocator_anno.c'
source_filename = "test_allocator_anno.c"
target datalayout = "e-m:o-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-apple-macosx10.15.0"

%struct.person_t = type { i32, [10 x i8], %struct.clothes* }
%struct.clothes = type { [10 x i8], i32 }

@p = global %struct.person_t { i32 10, [10 x i8] c"jack\00\00\00\00\00\00", %struct.clothes* null }, align 8, !dbg !0
@.str = private unnamed_addr constant [4 x i8] c"%s\0A\00", align 1
@.str.1 = private unnamed_addr constant [6 x i8] c"green\00", align 1

; Function Attrs: noinline nounwind optnone ssp uwtable
define %struct.person_t* @ReturnNewObj() #0 !dbg !30 {
entry:
  %p = alloca %struct.person_t*, align 8
  call void @llvm.dbg.declare(metadata %struct.person_t** %p, metadata !33, metadata !DIExpression()), !dbg !34
  %call = call i8* @malloc(i64 24) #5, !dbg !35
  %0 = bitcast i8* %call to %struct.person_t*, !dbg !36
  store %struct.person_t* %0, %struct.person_t** %p, align 8, !dbg !34
  %1 = load %struct.person_t*, %struct.person_t** %p, align 8, !dbg !37
  ret %struct.person_t* %1, !dbg !38
}

; Function Attrs: nounwind readnone speculatable willreturn
declare void @llvm.dbg.declare(metadata, metadata, metadata) #1

; Function Attrs: allocsize(0)
declare i8* @malloc(i64) #2

; Function Attrs: noinline nounwind optnone ssp uwtable
define void @PrintClothesColor(%struct.person_t* %pp) #0 !dbg !39 {
entry:
  %pp.addr = alloca %struct.person_t*, align 8
  store %struct.person_t* %pp, %struct.person_t** %pp.addr, align 8
  call void @llvm.dbg.declare(metadata %struct.person_t** %pp.addr, metadata !42, metadata !DIExpression()), !dbg !43
  %0 = load %struct.person_t*, %struct.person_t** %pp.addr, align 8, !dbg !44
  %s = getelementptr inbounds %struct.person_t, %struct.person_t* %0, i32 0, i32 2, !dbg !45
  %1 = load %struct.clothes*, %struct.clothes** %s, align 8, !dbg !45
  %color = getelementptr inbounds %struct.clothes, %struct.clothes* %1, i32 0, i32 0, !dbg !46
  %arraydecay = getelementptr inbounds [10 x i8], [10 x i8]* %color, i64 0, i64 0, !dbg !44
  %call = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([4 x i8], [4 x i8]* @.str, i64 0, i64 0), i8* %arraydecay), !dbg !47
  ret void, !dbg !48
}

declare i32 @printf(i8*, ...) #3

; Function Attrs: noinline nounwind optnone ssp uwtable
define void @AllocNewObj() #0 !dbg !49 {
entry:
  %pp = alloca %struct.person_t*, align 8
  %c = alloca %struct.clothes*, align 8
  call void @llvm.dbg.declare(metadata %struct.person_t** %pp, metadata !52, metadata !DIExpression()), !dbg !53
  %call = call i8* @malloc(i64 24) #5, !dbg !54
  %0 = bitcast i8* %call to %struct.person_t*, !dbg !55
  store %struct.person_t* %0, %struct.person_t** %pp, align 8, !dbg !53
  call void @llvm.dbg.declare(metadata %struct.clothes** %c, metadata !56, metadata !DIExpression()), !dbg !57
  %call1 = call i8* @malloc(i64 16) #5, !dbg !58
  %1 = bitcast i8* %call1 to %struct.clothes*, !dbg !59
  store %struct.clothes* %1, %struct.clothes** %c, align 8, !dbg !57
  %2 = load %struct.clothes*, %struct.clothes** %c, align 8, !dbg !60
  %color = getelementptr inbounds %struct.clothes, %struct.clothes* %2, i32 0, i32 0, !dbg !60
  %arraydecay = getelementptr inbounds [10 x i8], [10 x i8]* %color, i64 0, i64 0, !dbg !60
  %call2 = call i8* @__strcpy_chk(i8* %arraydecay, i8* getelementptr inbounds ([6 x i8], [6 x i8]* @.str.1, i64 0, i64 0), i64 10) #6, !dbg !60
  %3 = load %struct.clothes*, %struct.clothes** %c, align 8, !dbg !61
  %length = getelementptr inbounds %struct.clothes, %struct.clothes* %3, i32 0, i32 1, !dbg !62
  store i32 4, i32* %length, align 4, !dbg !63
  %4 = load %struct.clothes*, %struct.clothes** %c, align 8, !dbg !64
  %5 = load %struct.person_t*, %struct.person_t** %pp, align 8, !dbg !65
  %s = getelementptr inbounds %struct.person_t, %struct.person_t* %5, i32 0, i32 2, !dbg !66
  store %struct.clothes* %4, %struct.clothes** %s, align 8, !dbg !67
  %6 = load %struct.person_t*, %struct.person_t** %pp, align 8, !dbg !68
  call void @PrintClothesColor(%struct.person_t* %6), !dbg !69
  ret void, !dbg !70
}

; Function Attrs: nounwind
declare i8* @__strcpy_chk(i8*, i8*, i64) #4

; Function Attrs: noinline nounwind optnone ssp uwtable
define void @InvokeKernelPrint(%struct.person_t* %p) #0 !dbg !71 {
entry:
  %p.addr = alloca %struct.person_t*, align 8
  store %struct.person_t* %p, %struct.person_t** %p.addr, align 8
  call void @llvm.dbg.declare(metadata %struct.person_t** %p.addr, metadata !72, metadata !DIExpression()), !dbg !73
  %0 = load %struct.person_t*, %struct.person_t** %p.addr, align 8, !dbg !74
  call void @PrintClothesColor(%struct.person_t* %0), !dbg !75
  ret void, !dbg !76
}

attributes #0 = { noinline nounwind optnone ssp uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "frame-pointer"="all" "less-precise-fpmad"="false" "min-legal-vector-width"="0" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="penryn" "target-features"="+cx16,+cx8,+fxsr,+mmx,+sahf,+sse,+sse2,+sse3,+sse4.1,+ssse3,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind readnone speculatable willreturn }
attributes #2 = { allocsize(0) "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "frame-pointer"="all" "less-precise-fpmad"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="penryn" "target-features"="+cx16,+cx8,+fxsr,+mmx,+sahf,+sse,+sse2,+sse3,+sse4.1,+ssse3,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #3 = { "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "frame-pointer"="all" "less-precise-fpmad"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="penryn" "target-features"="+cx16,+cx8,+fxsr,+mmx,+sahf,+sse,+sse2,+sse3,+sse4.1,+ssse3,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #4 = { nounwind "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "frame-pointer"="all" "less-precise-fpmad"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="penryn" "target-features"="+cx16,+cx8,+fxsr,+mmx,+sahf,+sse,+sse2,+sse3,+sse4.1,+ssse3,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #5 = { allocsize(0) }
attributes #6 = { nounwind }

!llvm.dbg.cu = !{!2}
!llvm.module.flags = !{!25, !26, !27, !28}
!llvm.ident = !{!29}

!0 = !DIGlobalVariableExpression(var: !1, expr: !DIExpression())
!1 = distinct !DIGlobalVariable(name: "p", scope: !2, file: !3, line: 16, type: !7, isLocal: false, isDefinition: true)
!2 = distinct !DICompileUnit(language: DW_LANG_C99, file: !3, producer: "clang version 10.0.0 ", isOptimized: false, runtimeVersion: 0, emissionKind: FullDebug, enums: !4, retainedTypes: !5, globals: !24, nameTableKind: None)
!3 = !DIFile(filename: "test_allocator_anno.c", directory: "/Users/yongzhehuang/Library/Mobile Documents/com~apple~CloudDocs/Documents/llvm_versions/program-dependence-graph/test/pdg_test")
!4 = !{}
!5 = !{!6, !18}
!6 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !7, size: 64)
!7 = !DIDerivedType(tag: DW_TAG_typedef, name: "Person", file: !3, line: 14, baseType: !8)
!8 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "person_t", file: !3, line: 10, size: 192, elements: !9)
!9 = !{!10, !12, !17}
!10 = !DIDerivedType(tag: DW_TAG_member, name: "age", scope: !8, file: !3, line: 11, baseType: !11, size: 32)
!11 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!12 = !DIDerivedType(tag: DW_TAG_member, name: "name", scope: !8, file: !3, line: 12, baseType: !13, size: 80, offset: 32)
!13 = !DICompositeType(tag: DW_TAG_array_type, baseType: !14, size: 80, elements: !15)
!14 = !DIBasicType(name: "char", size: 8, encoding: DW_ATE_signed_char)
!15 = !{!16}
!16 = !DISubrange(count: 10)
!17 = !DIDerivedType(tag: DW_TAG_member, name: "s", scope: !8, file: !3, line: 13, baseType: !18, size: 64, offset: 128)
!18 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !19, size: 64)
!19 = !DIDerivedType(tag: DW_TAG_typedef, name: "Clothes", file: !3, line: 8, baseType: !20)
!20 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "clothes", file: !3, line: 5, size: 128, elements: !21)
!21 = !{!22, !23}
!22 = !DIDerivedType(tag: DW_TAG_member, name: "color", scope: !20, file: !3, line: 6, baseType: !13, size: 80)
!23 = !DIDerivedType(tag: DW_TAG_member, name: "length", scope: !20, file: !3, line: 7, baseType: !11, size: 32, offset: 96)
!24 = !{!0}
!25 = !{i32 7, !"Dwarf Version", i32 4}
!26 = !{i32 2, !"Debug Info Version", i32 3}
!27 = !{i32 1, !"wchar_size", i32 4}
!28 = !{i32 7, !"PIC Level", i32 2}
!29 = !{!"clang version 10.0.0 "}
!30 = distinct !DISubprogram(name: "ReturnNewObj", scope: !3, file: !3, line: 20, type: !31, scopeLine: 20, spFlags: DISPFlagDefinition, unit: !2, retainedNodes: !4)
!31 = !DISubroutineType(types: !32)
!32 = !{!6}
!33 = !DILocalVariable(name: "p", scope: !30, file: !3, line: 21, type: !6)
!34 = !DILocation(line: 21, column: 13, scope: !30)
!35 = !DILocation(line: 21, column: 26, scope: !30)
!36 = !DILocation(line: 21, column: 17, scope: !30)
!37 = !DILocation(line: 22, column: 12, scope: !30)
!38 = !DILocation(line: 22, column: 5, scope: !30)
!39 = distinct !DISubprogram(name: "PrintClothesColor", scope: !3, file: !3, line: 26, type: !40, scopeLine: 26, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !2, retainedNodes: !4)
!40 = !DISubroutineType(types: !41)
!41 = !{null, !6}
!42 = !DILocalVariable(name: "pp", arg: 1, scope: !39, file: !3, line: 26, type: !6)
!43 = !DILocation(line: 26, column: 32, scope: !39)
!44 = !DILocation(line: 28, column: 20, scope: !39)
!45 = !DILocation(line: 28, column: 24, scope: !39)
!46 = !DILocation(line: 28, column: 27, scope: !39)
!47 = !DILocation(line: 28, column: 5, scope: !39)
!48 = !DILocation(line: 29, column: 1, scope: !39)
!49 = distinct !DISubprogram(name: "AllocNewObj", scope: !3, file: !3, line: 32, type: !50, scopeLine: 32, spFlags: DISPFlagDefinition, unit: !2, retainedNodes: !4)
!50 = !DISubroutineType(types: !51)
!51 = !{null}
!52 = !DILocalVariable(name: "pp", scope: !49, file: !3, line: 33, type: !6)
!53 = !DILocation(line: 33, column: 13, scope: !49)
!54 = !DILocation(line: 33, column: 27, scope: !49)
!55 = !DILocation(line: 33, column: 18, scope: !49)
!56 = !DILocalVariable(name: "c", scope: !49, file: !3, line: 34, type: !18)
!57 = !DILocation(line: 34, column: 14, scope: !49)
!58 = !DILocation(line: 34, column: 28, scope: !49)
!59 = !DILocation(line: 34, column: 18, scope: !49)
!60 = !DILocation(line: 35, column: 5, scope: !49)
!61 = !DILocation(line: 36, column: 5, scope: !49)
!62 = !DILocation(line: 36, column: 8, scope: !49)
!63 = !DILocation(line: 36, column: 15, scope: !49)
!64 = !DILocation(line: 37, column: 13, scope: !49)
!65 = !DILocation(line: 37, column: 5, scope: !49)
!66 = !DILocation(line: 37, column: 9, scope: !49)
!67 = !DILocation(line: 37, column: 11, scope: !49)
!68 = !DILocation(line: 40, column: 23, scope: !49)
!69 = !DILocation(line: 40, column: 5, scope: !49)
!70 = !DILocation(line: 41, column: 1, scope: !49)
!71 = distinct !DISubprogram(name: "InvokeKernelPrint", scope: !3, file: !3, line: 44, type: !40, scopeLine: 44, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !2, retainedNodes: !4)
!72 = !DILocalVariable(name: "p", arg: 1, scope: !71, file: !3, line: 44, type: !6)
!73 = !DILocation(line: 44, column: 32, scope: !71)
!74 = !DILocation(line: 45, column: 23, scope: !71)
!75 = !DILocation(line: 45, column: 5, scope: !71)
!76 = !DILocation(line: 46, column: 1, scope: !71)
