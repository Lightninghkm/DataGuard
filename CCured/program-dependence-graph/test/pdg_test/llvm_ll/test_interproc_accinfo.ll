; ModuleID = 'test_interproc_accinfo.c'
source_filename = "test_interproc_accinfo.c"
target datalayout = "e-m:o-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-apple-macosx10.15.0"

%struct.clothes = type { [10 x i8], i32 }
%struct.person_t = type { i32, [10 x i8], %struct.clothes }

@.str = private unnamed_addr constant [4 x i8] c"%d\0A\00", align 1
@.str.1 = private unnamed_addr constant [4 x i8] c"%s\0A\00", align 1
@__const.main.c = private unnamed_addr constant %struct.clothes { [10 x i8] c"red\00\00\00\00\00\00\00", i32 5 }, align 4
@.str.2 = private unnamed_addr constant [10 x i8] c"Jack\00\00\00\00\00\00", align 1

; Function Attrs: noinline nounwind optnone ssp uwtable
define void @f2(i32* %age) #0 !dbg !8 {
entry:
  %age.addr = alloca i32*, align 8
  store i32* %age, i32** %age.addr, align 8
  call void @llvm.dbg.declare(metadata i32** %age.addr, metadata !13, metadata !DIExpression()), !dbg !14
  %0 = load i32*, i32** %age.addr, align 8, !dbg !15
  %1 = load i32, i32* %0, align 4, !dbg !16
  %call = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([4 x i8], [4 x i8]* @.str, i64 0, i64 0), i32 %1), !dbg !17
  ret void, !dbg !18
}

; Function Attrs: nounwind readnone speculatable willreturn
declare void @llvm.dbg.declare(metadata, metadata, metadata) #1

declare i32 @printf(i8*, ...) #2

; Function Attrs: noinline nounwind optnone ssp uwtable
define void @f1(%struct.person_t* %p) #0 !dbg !19 {
entry:
  %p.addr = alloca %struct.person_t*, align 8
  store %struct.person_t* %p, %struct.person_t** %p.addr, align 8
  call void @llvm.dbg.declare(metadata %struct.person_t** %p.addr, metadata !38, metadata !DIExpression()), !dbg !39
  %0 = load %struct.person_t*, %struct.person_t** %p.addr, align 8, !dbg !40
  %name = getelementptr inbounds %struct.person_t, %struct.person_t* %0, i32 0, i32 1, !dbg !41
  %arraydecay = getelementptr inbounds [10 x i8], [10 x i8]* %name, i64 0, i64 0, !dbg !40
  %call = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([4 x i8], [4 x i8]* @.str.1, i64 0, i64 0), i8* %arraydecay), !dbg !42
  %1 = load %struct.person_t*, %struct.person_t** %p.addr, align 8, !dbg !43
  %age = getelementptr inbounds %struct.person_t, %struct.person_t* %1, i32 0, i32 0, !dbg !44
  call void @f2(i32* %age), !dbg !45
  ret void, !dbg !46
}

; Function Attrs: noinline nounwind optnone ssp uwtable
define i32 @main() #0 !dbg !47 {
entry:
  %retval = alloca i32, align 4
  %c = alloca %struct.clothes, align 4
  %p = alloca %struct.person_t, align 4
  %pt = alloca %struct.person_t*, align 8
  store i32 0, i32* %retval, align 4
  call void @llvm.dbg.declare(metadata %struct.clothes* %c, metadata !50, metadata !DIExpression()), !dbg !51
  %0 = bitcast %struct.clothes* %c to i8*, !dbg !51
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 4 %0, i8* align 4 getelementptr inbounds (%struct.clothes, %struct.clothes* @__const.main.c, i32 0, i32 0, i32 0), i64 16, i1 false), !dbg !51
  call void @llvm.dbg.declare(metadata %struct.person_t* %p, metadata !52, metadata !DIExpression()), !dbg !53
  %age = getelementptr inbounds %struct.person_t, %struct.person_t* %p, i32 0, i32 0, !dbg !54
  store i32 10, i32* %age, align 4, !dbg !54
  %name = getelementptr inbounds %struct.person_t, %struct.person_t* %p, i32 0, i32 1, !dbg !54
  %1 = bitcast [10 x i8]* %name to i8*, !dbg !55
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 4 %1, i8* align 1 getelementptr inbounds ([10 x i8], [10 x i8]* @.str.2, i32 0, i32 0), i64 10, i1 false), !dbg !55
  %s = getelementptr inbounds %struct.person_t, %struct.person_t* %p, i32 0, i32 2, !dbg !54
  %2 = bitcast %struct.clothes* %s to i8*, !dbg !56
  %3 = bitcast %struct.clothes* %c to i8*, !dbg !56
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 4 %2, i8* align 4 %3, i64 16, i1 false), !dbg !56
  call void @llvm.dbg.declare(metadata %struct.person_t** %pt, metadata !57, metadata !DIExpression()), !dbg !58
  store %struct.person_t* %p, %struct.person_t** %pt, align 8, !dbg !58
  %4 = load %struct.person_t*, %struct.person_t** %pt, align 8, !dbg !59
  call void @f1(%struct.person_t* %4), !dbg !60
  ret i32 0, !dbg !61
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
!1 = !DIFile(filename: "test_interproc_accinfo.c", directory: "/Users/yongzhehuang/Library/Mobile Documents/com~apple~CloudDocs/Documents/llvm_versions/program-dependence-graph/test/pdg_test")
!2 = !{}
!3 = !{i32 7, !"Dwarf Version", i32 4}
!4 = !{i32 2, !"Debug Info Version", i32 3}
!5 = !{i32 1, !"wchar_size", i32 4}
!6 = !{i32 7, !"PIC Level", i32 2}
!7 = !{!"clang version 10.0.0 "}
!8 = distinct !DISubprogram(name: "f2", scope: !1, file: !1, line: 14, type: !9, scopeLine: 14, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !2)
!9 = !DISubroutineType(types: !10)
!10 = !{null, !11}
!11 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !12, size: 64)
!12 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!13 = !DILocalVariable(name: "age", arg: 1, scope: !8, file: !1, line: 14, type: !11)
!14 = !DILocation(line: 14, column: 14, scope: !8)
!15 = !DILocation(line: 15, column: 21, scope: !8)
!16 = !DILocation(line: 15, column: 20, scope: !8)
!17 = !DILocation(line: 15, column: 5, scope: !8)
!18 = !DILocation(line: 16, column: 1, scope: !8)
!19 = distinct !DISubprogram(name: "f1", scope: !1, file: !1, line: 18, type: !20, scopeLine: 18, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !2)
!20 = !DISubroutineType(types: !21)
!21 = !{null, !22}
!22 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !23, size: 64)
!23 = !DIDerivedType(tag: DW_TAG_typedef, name: "Person", file: !1, line: 12, baseType: !24)
!24 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "person_t", file: !1, line: 8, size: 256, elements: !25)
!25 = !{!26, !27, !32}
!26 = !DIDerivedType(tag: DW_TAG_member, name: "age", scope: !24, file: !1, line: 9, baseType: !12, size: 32)
!27 = !DIDerivedType(tag: DW_TAG_member, name: "name", scope: !24, file: !1, line: 10, baseType: !28, size: 80, offset: 32)
!28 = !DICompositeType(tag: DW_TAG_array_type, baseType: !29, size: 80, elements: !30)
!29 = !DIBasicType(name: "char", size: 8, encoding: DW_ATE_signed_char)
!30 = !{!31}
!31 = !DISubrange(count: 10)
!32 = !DIDerivedType(tag: DW_TAG_member, name: "s", scope: !24, file: !1, line: 11, baseType: !33, size: 128, offset: 128)
!33 = !DIDerivedType(tag: DW_TAG_typedef, name: "Clothes", file: !1, line: 6, baseType: !34)
!34 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "clothes", file: !1, line: 3, size: 128, elements: !35)
!35 = !{!36, !37}
!36 = !DIDerivedType(tag: DW_TAG_member, name: "color", scope: !34, file: !1, line: 4, baseType: !28, size: 80)
!37 = !DIDerivedType(tag: DW_TAG_member, name: "length", scope: !34, file: !1, line: 5, baseType: !12, size: 32, offset: 96)
!38 = !DILocalVariable(name: "p", arg: 1, scope: !19, file: !1, line: 18, type: !22)
!39 = !DILocation(line: 18, column: 17, scope: !19)
!40 = !DILocation(line: 19, column: 20, scope: !19)
!41 = !DILocation(line: 19, column: 23, scope: !19)
!42 = !DILocation(line: 19, column: 5, scope: !19)
!43 = !DILocation(line: 20, column: 9, scope: !19)
!44 = !DILocation(line: 20, column: 12, scope: !19)
!45 = !DILocation(line: 20, column: 5, scope: !19)
!46 = !DILocation(line: 21, column: 1, scope: !19)
!47 = distinct !DISubprogram(name: "main", scope: !1, file: !1, line: 23, type: !48, scopeLine: 23, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !2)
!48 = !DISubroutineType(types: !49)
!49 = !{!12}
!50 = !DILocalVariable(name: "c", scope: !47, file: !1, line: 24, type: !33)
!51 = !DILocation(line: 24, column: 13, scope: !47)
!52 = !DILocalVariable(name: "p", scope: !47, file: !1, line: 25, type: !23)
!53 = !DILocation(line: 25, column: 12, scope: !47)
!54 = !DILocation(line: 25, column: 16, scope: !47)
!55 = !DILocation(line: 25, column: 21, scope: !47)
!56 = !DILocation(line: 25, column: 29, scope: !47)
!57 = !DILocalVariable(name: "pt", scope: !47, file: !1, line: 26, type: !22)
!58 = !DILocation(line: 26, column: 13, scope: !47)
!59 = !DILocation(line: 27, column: 8, scope: !47)
!60 = !DILocation(line: 27, column: 5, scope: !47)
!61 = !DILocation(line: 28, column: 5, scope: !47)
