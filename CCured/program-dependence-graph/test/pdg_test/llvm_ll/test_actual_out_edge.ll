; ModuleID = 'test_actual_out_edge.c'
source_filename = "test_actual_out_edge.c"
target datalayout = "e-m:o-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-apple-macosx10.15.0"

%struct.Person = type { i32, i8* }

@.str = private unnamed_addr constant [4 x i8] c"%d\0A\00", align 1
@.str.1 = private unnamed_addr constant [5 x i8] c"Jack\00", align 1
@__const.main.pp = private unnamed_addr constant %struct.Person { i32 15, i8* getelementptr inbounds ([5 x i8], [5 x i8]* @.str.1, i32 0, i32 0) }, align 8

; Function Attrs: noinline nounwind optnone ssp uwtable
define void @f(i32 %a) #0 !dbg !8 {
entry:
  %a.addr = alloca i32, align 4
  store i32 %a, i32* %a.addr, align 4
  call void @llvm.dbg.declare(metadata i32* %a.addr, metadata !12, metadata !DIExpression()), !dbg !13
  %0 = load i32, i32* %a.addr, align 4, !dbg !14
  %call = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([4 x i8], [4 x i8]* @.str, i64 0, i64 0), i32 %0), !dbg !15
  ret void, !dbg !16
}

; Function Attrs: nounwind readnone speculatable willreturn
declare void @llvm.dbg.declare(metadata, metadata, metadata) #1

declare i32 @printf(i8*, ...) #2

; Function Attrs: noinline nounwind optnone ssp uwtable
define i32 @main() #0 !dbg !17 {
entry:
  %retval = alloca i32, align 4
  %p1 = alloca %struct.Person*, align 8
  %pp = alloca %struct.Person, align 8
  %age = alloca i32, align 4
  %age12 = alloca i32, align 4
  %age2 = alloca i32, align 4
  store i32 0, i32* %retval, align 4
  call void @llvm.dbg.declare(metadata %struct.Person** %p1, metadata !20, metadata !DIExpression()), !dbg !29
  call void @llvm.dbg.declare(metadata %struct.Person* %pp, metadata !30, metadata !DIExpression()), !dbg !31
  %0 = bitcast %struct.Person* %pp to i8*, !dbg !31
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 8 %0, i8* align 8 bitcast (%struct.Person* @__const.main.pp to i8*), i64 16, i1 false), !dbg !31
  store %struct.Person* %pp, %struct.Person** %p1, align 8, !dbg !32
  call void @llvm.dbg.declare(metadata i32* %age, metadata !33, metadata !DIExpression()), !dbg !34
  %1 = load %struct.Person*, %struct.Person** %p1, align 8, !dbg !35
  %age1 = getelementptr inbounds %struct.Person, %struct.Person* %1, i32 0, i32 0, !dbg !36
  %2 = load i32, i32* %age1, align 8, !dbg !36
  store i32 %2, i32* %age, align 4, !dbg !34
  %3 = load i32, i32* %age, align 4, !dbg !37
  call void @f(i32 %3), !dbg !38
  call void @llvm.dbg.declare(metadata i32* %age12, metadata !39, metadata !DIExpression()), !dbg !40
  %4 = load %struct.Person*, %struct.Person** %p1, align 8, !dbg !41
  %age3 = getelementptr inbounds %struct.Person, %struct.Person* %4, i32 0, i32 0, !dbg !42
  %5 = load i32, i32* %age3, align 8, !dbg !42
  store i32 %5, i32* %age12, align 4, !dbg !40
  %6 = load i32, i32* %age12, align 4, !dbg !43
  call void @f(i32 %6), !dbg !44
  call void @llvm.dbg.declare(metadata i32* %age2, metadata !45, metadata !DIExpression()), !dbg !46
  %7 = load %struct.Person*, %struct.Person** %p1, align 8, !dbg !47
  %age4 = getelementptr inbounds %struct.Person, %struct.Person* %7, i32 0, i32 0, !dbg !48
  %8 = load i32, i32* %age4, align 8, !dbg !48
  store i32 %8, i32* %age2, align 4, !dbg !46
  ret i32 1, !dbg !49
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
!1 = !DIFile(filename: "test_actual_out_edge.c", directory: "/Users/yongzhehuang/Library/Mobile Documents/com~apple~CloudDocs/Documents/llvm_versions/program-dependence-graph/test/pdg_test")
!2 = !{}
!3 = !{i32 7, !"Dwarf Version", i32 4}
!4 = !{i32 2, !"Debug Info Version", i32 3}
!5 = !{i32 1, !"wchar_size", i32 4}
!6 = !{i32 7, !"PIC Level", i32 2}
!7 = !{!"clang version 10.0.0 "}
!8 = distinct !DISubprogram(name: "f", scope: !1, file: !1, line: 7, type: !9, scopeLine: 7, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !2)
!9 = !DISubroutineType(types: !10)
!10 = !{null, !11}
!11 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!12 = !DILocalVariable(name: "a", arg: 1, scope: !8, file: !1, line: 7, type: !11)
!13 = !DILocation(line: 7, column: 12, scope: !8)
!14 = !DILocation(line: 8, column: 20, scope: !8)
!15 = !DILocation(line: 8, column: 5, scope: !8)
!16 = !DILocation(line: 9, column: 1, scope: !8)
!17 = distinct !DISubprogram(name: "main", scope: !1, file: !1, line: 11, type: !18, scopeLine: 11, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !2)
!18 = !DISubroutineType(types: !19)
!19 = !{!11}
!20 = !DILocalVariable(name: "p1", scope: !17, file: !1, line: 12, type: !21)
!21 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !22, size: 64)
!22 = !DIDerivedType(tag: DW_TAG_typedef, name: "person_t", file: !1, line: 5, baseType: !23)
!23 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "Person", file: !1, line: 2, size: 128, elements: !24)
!24 = !{!25, !26}
!25 = !DIDerivedType(tag: DW_TAG_member, name: "age", scope: !23, file: !1, line: 3, baseType: !11, size: 32)
!26 = !DIDerivedType(tag: DW_TAG_member, name: "name", scope: !23, file: !1, line: 4, baseType: !27, size: 64, offset: 64)
!27 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !28, size: 64)
!28 = !DIBasicType(name: "char", size: 8, encoding: DW_ATE_signed_char)
!29 = !DILocation(line: 12, column: 15, scope: !17)
!30 = !DILocalVariable(name: "pp", scope: !17, file: !1, line: 13, type: !23)
!31 = !DILocation(line: 13, column: 19, scope: !17)
!32 = !DILocation(line: 14, column: 8, scope: !17)
!33 = !DILocalVariable(name: "age", scope: !17, file: !1, line: 15, type: !11)
!34 = !DILocation(line: 15, column: 9, scope: !17)
!35 = !DILocation(line: 15, column: 15, scope: !17)
!36 = !DILocation(line: 15, column: 19, scope: !17)
!37 = !DILocation(line: 16, column: 7, scope: !17)
!38 = !DILocation(line: 16, column: 5, scope: !17)
!39 = !DILocalVariable(name: "age1", scope: !17, file: !1, line: 17, type: !11)
!40 = !DILocation(line: 17, column: 9, scope: !17)
!41 = !DILocation(line: 17, column: 16, scope: !17)
!42 = !DILocation(line: 17, column: 20, scope: !17)
!43 = !DILocation(line: 18, column: 7, scope: !17)
!44 = !DILocation(line: 18, column: 5, scope: !17)
!45 = !DILocalVariable(name: "age2", scope: !17, file: !1, line: 19, type: !11)
!46 = !DILocation(line: 19, column: 9, scope: !17)
!47 = !DILocation(line: 19, column: 16, scope: !17)
!48 = !DILocation(line: 19, column: 20, scope: !17)
!49 = !DILocation(line: 21, column: 5, scope: !17)
