; ModuleID = 'test_loading_inst.c'
source_filename = "test_loading_inst.c"
target datalayout = "e-m:o-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-apple-macosx10.15.0"

%struct.clothes = type { i32, i8* }
%struct.Person = type { i32, %struct.clothes* }

@.str = private unnamed_addr constant [4 x i8] c"%s\0A\00", align 1
@.str.1 = private unnamed_addr constant [4 x i8] c"red\00", align 1
@__const.main.c = private unnamed_addr constant %struct.clothes { i32 10, i8* getelementptr inbounds ([4 x i8], [4 x i8]* @.str.1, i32 0, i32 0) }, align 8
@__const.main.b = private unnamed_addr constant [3 x i32] [i32 1, i32 2, i32 3], align 4

; Function Attrs: noinline nounwind optnone ssp uwtable
define i32 @f(%struct.Person* %p) #0 !dbg !8 {
entry:
  %p.addr = alloca %struct.Person*, align 8
  store %struct.Person* %p, %struct.Person** %p.addr, align 8
  call void @llvm.dbg.declare(metadata %struct.Person** %p.addr, metadata !26, metadata !DIExpression()), !dbg !27
  %0 = load %struct.Person*, %struct.Person** %p.addr, align 8, !dbg !28
  %c = getelementptr inbounds %struct.Person, %struct.Person* %0, i32 0, i32 1, !dbg !29
  %1 = load %struct.clothes*, %struct.clothes** %c, align 8, !dbg !29
  %color = getelementptr inbounds %struct.clothes, %struct.clothes* %1, i32 0, i32 1, !dbg !30
  %2 = load i8*, i8** %color, align 8, !dbg !30
  %call = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([4 x i8], [4 x i8]* @.str, i64 0, i64 0), i8* %2), !dbg !31
  %3 = load %struct.Person*, %struct.Person** %p.addr, align 8, !dbg !32
  %age = getelementptr inbounds %struct.Person, %struct.Person* %3, i32 0, i32 0, !dbg !33
  %4 = load i32, i32* %age, align 8, !dbg !33
  ret i32 %4, !dbg !34
}

; Function Attrs: nounwind readnone speculatable willreturn
declare void @llvm.dbg.declare(metadata, metadata, metadata) #1

declare i32 @printf(i8*, ...) #2

; Function Attrs: noinline nounwind optnone ssp uwtable
define i32 @ff(i32 %a) #0 !dbg !35 {
entry:
  %a.addr = alloca i32, align 4
  store i32 %a, i32* %a.addr, align 4
  call void @llvm.dbg.declare(metadata i32* %a.addr, metadata !38, metadata !DIExpression()), !dbg !39
  %0 = load i32, i32* %a.addr, align 4, !dbg !40
  ret i32 %0, !dbg !41
}

; Function Attrs: noinline nounwind optnone ssp uwtable
define void @fff(i8* %c, i32* %a, i32* %b) #0 !dbg !42 {
entry:
  %c.addr = alloca i8*, align 8
  %a.addr = alloca i32*, align 8
  %b.addr = alloca i32*, align 8
  store i8* %c, i8** %c.addr, align 8
  call void @llvm.dbg.declare(metadata i8** %c.addr, metadata !46, metadata !DIExpression()), !dbg !47
  store i32* %a, i32** %a.addr, align 8
  call void @llvm.dbg.declare(metadata i32** %a.addr, metadata !48, metadata !DIExpression()), !dbg !49
  store i32* %b, i32** %b.addr, align 8
  call void @llvm.dbg.declare(metadata i32** %b.addr, metadata !50, metadata !DIExpression()), !dbg !51
  %0 = load i8*, i8** %c.addr, align 8, !dbg !52
  %call = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([4 x i8], [4 x i8]* @.str, i64 0, i64 0), i8* %0), !dbg !53
  ret void, !dbg !54
}

; Function Attrs: noinline nounwind optnone ssp uwtable
define i32 @main() #0 !dbg !55 {
entry:
  %c = alloca %struct.clothes, align 8
  %p = alloca %struct.Person, align 8
  %a = alloca i32, align 4
  %b = alloca [3 x i32], align 4
  call void @llvm.dbg.declare(metadata %struct.clothes* %c, metadata !58, metadata !DIExpression()), !dbg !59
  %0 = bitcast %struct.clothes* %c to i8*, !dbg !59
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 8 %0, i8* align 8 bitcast (%struct.clothes* @__const.main.c to i8*), i64 16, i1 false), !dbg !59
  call void @llvm.dbg.declare(metadata %struct.Person* %p, metadata !60, metadata !DIExpression()), !dbg !61
  %age = getelementptr inbounds %struct.Person, %struct.Person* %p, i32 0, i32 0, !dbg !62
  store i32 21, i32* %age, align 8, !dbg !62
  %c1 = getelementptr inbounds %struct.Person, %struct.Person* %p, i32 0, i32 1, !dbg !62
  store %struct.clothes* %c, %struct.clothes** %c1, align 8, !dbg !62
  %call = call i32 @f(%struct.Person* %p), !dbg !63
  %call2 = call i32 @ff(i32 5), !dbg !64
  call void @llvm.dbg.declare(metadata i32* %a, metadata !65, metadata !DIExpression()), !dbg !66
  store i32 5, i32* %a, align 4, !dbg !66
  call void @llvm.dbg.declare(metadata [3 x i32]* %b, metadata !67, metadata !DIExpression()), !dbg !71
  %1 = bitcast [3 x i32]* %b to i8*, !dbg !71
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 4 %1, i8* align 4 bitcast ([3 x i32]* @__const.main.b to i8*), i64 12, i1 false), !dbg !71
  %color = getelementptr inbounds %struct.clothes, %struct.clothes* %c, i32 0, i32 1, !dbg !72
  %2 = load i8*, i8** %color, align 8, !dbg !72
  %arraydecay = getelementptr inbounds [3 x i32], [3 x i32]* %b, i64 0, i64 0, !dbg !73
  call void @fff(i8* %2, i32* %a, i32* %arraydecay), !dbg !74
  ret i32 0, !dbg !75
}

; Function Attrs: argmemonly nounwind willreturn
declare void @llvm.memcpy.p0i8.p0i8.i64(i8* noalias nocapture writeonly, i8* noalias nocapture readonly, i64, i1 immarg) #3

attributes #0 = { noinline nounwind optnone ssp uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "frame-pointer"="all" "less-precise-fpmad"="false" "min-legal-vector-width"="0" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="penryn" "target-features"="+cx16,+cx8,+fxsr,+mmx,+sahf,+sse,+sse2,+sse3,+sse4.1,+ssse3,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind readnone speculatable willreturn }
attributes #2 = { "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "frame-pointer"="all" "less-precise-fpmad"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="penryn" "target-features"="+cx16,+cx8,+fxsr,+mmx,+sahf,+sse,+sse2,+sse3,+sse4.1,+ssse3,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #3 = { argmemonly nounwind willreturn }

!llvm.dbg.cu = !{!0}
!llvm.module.flags = !{!3, !4, !5, !6}
!llvm.ident = !{!7}

!0 = distinct !DICompileUnit(language: DW_LANG_C99, file: !1, producer: "clang version 10.0.0 ", isOptimized: false, runtimeVersion: 0, emissionKind: FullDebug, enums: !2, nameTableKind: None)
!1 = !DIFile(filename: "test_loading_inst.c", directory: "/Users/yongzhehuang/Library/Mobile Documents/com~apple~CloudDocs/Documents/llvm_versions/program-dependence-graph/test/pdg_test")
!2 = !{}
!3 = !{i32 7, !"Dwarf Version", i32 4}
!4 = !{i32 2, !"Debug Info Version", i32 3}
!5 = !{i32 1, !"wchar_size", i32 4}
!6 = !{i32 7, !"PIC Level", i32 2}
!7 = !{!"clang version 10.0.0 "}
!8 = distinct !DISubprogram(name: "f", scope: !1, file: !1, line: 13, type: !9, scopeLine: 13, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !2)
!9 = !DISubroutineType(types: !10)
!10 = !{!11, !12}
!11 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!12 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !13, size: 64)
!13 = !DIDerivedType(tag: DW_TAG_typedef, name: "person_t", file: !1, line: 11, baseType: !14)
!14 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "Person", file: !1, line: 8, size: 128, elements: !15)
!15 = !{!16, !17}
!16 = !DIDerivedType(tag: DW_TAG_member, name: "age", scope: !14, file: !1, line: 9, baseType: !11, size: 32)
!17 = !DIDerivedType(tag: DW_TAG_member, name: "c", scope: !14, file: !1, line: 10, baseType: !18, size: 64, offset: 64)
!18 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !19, size: 64)
!19 = !DIDerivedType(tag: DW_TAG_typedef, name: "clothes_t", file: !1, line: 6, baseType: !20)
!20 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "clothes", file: !1, line: 3, size: 128, elements: !21)
!21 = !{!22, !23}
!22 = !DIDerivedType(tag: DW_TAG_member, name: "length", scope: !20, file: !1, line: 4, baseType: !11, size: 32)
!23 = !DIDerivedType(tag: DW_TAG_member, name: "color", scope: !20, file: !1, line: 5, baseType: !24, size: 64, offset: 64)
!24 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !25, size: 64)
!25 = !DIBasicType(name: "char", size: 8, encoding: DW_ATE_signed_char)
!26 = !DILocalVariable(name: "p", arg: 1, scope: !8, file: !1, line: 13, type: !12)
!27 = !DILocation(line: 13, column: 17, scope: !8)
!28 = !DILocation(line: 14, column: 20, scope: !8)
!29 = !DILocation(line: 14, column: 23, scope: !8)
!30 = !DILocation(line: 14, column: 26, scope: !8)
!31 = !DILocation(line: 14, column: 5, scope: !8)
!32 = !DILocation(line: 15, column: 12, scope: !8)
!33 = !DILocation(line: 15, column: 15, scope: !8)
!34 = !DILocation(line: 15, column: 5, scope: !8)
!35 = distinct !DISubprogram(name: "ff", scope: !1, file: !1, line: 18, type: !36, scopeLine: 18, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !2)
!36 = !DISubroutineType(types: !37)
!37 = !{!11, !11}
!38 = !DILocalVariable(name: "a", arg: 1, scope: !35, file: !1, line: 18, type: !11)
!39 = !DILocation(line: 18, column: 13, scope: !35)
!40 = !DILocation(line: 19, column: 12, scope: !35)
!41 = !DILocation(line: 19, column: 5, scope: !35)
!42 = distinct !DISubprogram(name: "fff", scope: !1, file: !1, line: 22, type: !43, scopeLine: 22, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !2)
!43 = !DISubroutineType(types: !44)
!44 = !{null, !24, !45, !45}
!45 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !11, size: 64)
!46 = !DILocalVariable(name: "c", arg: 1, scope: !42, file: !1, line: 22, type: !24)
!47 = !DILocation(line: 22, column: 16, scope: !42)
!48 = !DILocalVariable(name: "a", arg: 2, scope: !42, file: !1, line: 22, type: !45)
!49 = !DILocation(line: 22, column: 24, scope: !42)
!50 = !DILocalVariable(name: "b", arg: 3, scope: !42, file: !1, line: 22, type: !45)
!51 = !DILocation(line: 22, column: 31, scope: !42)
!52 = !DILocation(line: 23, column: 19, scope: !42)
!53 = !DILocation(line: 23, column: 4, scope: !42)
!54 = !DILocation(line: 24, column: 1, scope: !42)
!55 = distinct !DISubprogram(name: "main", scope: !1, file: !1, line: 26, type: !56, scopeLine: 26, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !2)
!56 = !DISubroutineType(types: !57)
!57 = !{!11}
!58 = !DILocalVariable(name: "c", scope: !55, file: !1, line: 27, type: !19)
!59 = !DILocation(line: 27, column: 15, scope: !55)
!60 = !DILocalVariable(name: "p", scope: !55, file: !1, line: 28, type: !13)
!61 = !DILocation(line: 28, column: 14, scope: !55)
!62 = !DILocation(line: 28, column: 18, scope: !55)
!63 = !DILocation(line: 29, column: 5, scope: !55)
!64 = !DILocation(line: 30, column: 5, scope: !55)
!65 = !DILocalVariable(name: "a", scope: !55, file: !1, line: 31, type: !11)
!66 = !DILocation(line: 31, column: 9, scope: !55)
!67 = !DILocalVariable(name: "b", scope: !55, file: !1, line: 32, type: !68)
!68 = !DICompositeType(tag: DW_TAG_array_type, baseType: !11, size: 96, elements: !69)
!69 = !{!70}
!70 = !DISubrange(count: 3)
!71 = !DILocation(line: 32, column: 9, scope: !55)
!72 = !DILocation(line: 33, column: 11, scope: !55)
!73 = !DILocation(line: 33, column: 22, scope: !55)
!74 = !DILocation(line: 33, column: 5, scope: !55)
!75 = !DILocation(line: 34, column: 1, scope: !55)
