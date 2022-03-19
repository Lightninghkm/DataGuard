; ModuleID = 'test_two_source_data_dependency.c'
source_filename = "test_two_source_data_dependency.c"
target datalayout = "e-m:o-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-apple-macosx10.15.0"

%struct.struct_t = type { i32, float }

; Function Attrs: noinline nounwind optnone ssp uwtable
define i32 @getFlag() #0 !dbg !8 {
entry:
  ret i32 1, !dbg !12
}

; Function Attrs: noinline nounwind optnone ssp uwtable
define i32 @main() #0 !dbg !13 {
entry:
  %retval = alloca i32, align 4
  %s = alloca %struct.struct_t, align 4
  %a = alloca i32, align 4
  %b = alloca float, align 4
  store i32 0, i32* %retval, align 4
  call void @llvm.dbg.declare(metadata %struct.struct_t* %s, metadata !14, metadata !DIExpression()), !dbg !20
  call void @llvm.dbg.declare(metadata i32* %a, metadata !21, metadata !DIExpression()), !dbg !22
  store i32 5, i32* %a, align 4, !dbg !22
  call void @llvm.dbg.declare(metadata float* %b, metadata !23, metadata !DIExpression()), !dbg !24
  store float 6.000000e+00, float* %b, align 4, !dbg !24
  %call = call i32 @getFlag(), !dbg !25
  %tobool = icmp ne i32 %call, 0, !dbg !25
  br i1 %tobool, label %if.then, label %if.else, !dbg !27

if.then:                                          ; preds = %entry
  %0 = load i32, i32* %a, align 4, !dbg !28
  %a1 = getelementptr inbounds %struct.struct_t, %struct.struct_t* %s, i32 0, i32 0, !dbg !30
  store i32 %0, i32* %a1, align 4, !dbg !31
  br label %if.end, !dbg !32

if.else:                                          ; preds = %entry
  %1 = load float, float* %b, align 4, !dbg !33
  %b2 = getelementptr inbounds %struct.struct_t, %struct.struct_t* %s, i32 0, i32 1, !dbg !35
  store float %1, float* %b2, align 4, !dbg !36
  br label %if.end

if.end:                                           ; preds = %if.else, %if.then
  ret i32 0, !dbg !37
}

; Function Attrs: nounwind readnone speculatable willreturn
declare void @llvm.dbg.declare(metadata, metadata, metadata) #1

attributes #0 = { noinline nounwind optnone ssp uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "frame-pointer"="all" "less-precise-fpmad"="false" "min-legal-vector-width"="0" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="penryn" "target-features"="+cx16,+cx8,+fxsr,+mmx,+sahf,+sse,+sse2,+sse3,+sse4.1,+ssse3,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind readnone speculatable willreturn }

!llvm.dbg.cu = !{!0}
!llvm.module.flags = !{!3, !4, !5, !6}
!llvm.ident = !{!7}

!0 = distinct !DICompileUnit(language: DW_LANG_C99, file: !1, producer: "clang version 10.0.0 ", isOptimized: false, runtimeVersion: 0, emissionKind: FullDebug, enums: !2, nameTableKind: None)
!1 = !DIFile(filename: "test_two_source_data_dependency.c", directory: "/Users/yongzhehuang/Library/Mobile Documents/com~apple~CloudDocs/Documents/llvm_versions/program-dependence-graph/test/pdg_test")
!2 = !{}
!3 = !{i32 7, !"Dwarf Version", i32 4}
!4 = !{i32 2, !"Debug Info Version", i32 3}
!5 = !{i32 1, !"wchar_size", i32 4}
!6 = !{i32 7, !"PIC Level", i32 2}
!7 = !{!"clang version 10.0.0 "}
!8 = distinct !DISubprogram(name: "getFlag", scope: !1, file: !1, line: 8, type: !9, scopeLine: 8, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !2)
!9 = !DISubroutineType(types: !10)
!10 = !{!11}
!11 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!12 = !DILocation(line: 9, column: 5, scope: !8)
!13 = distinct !DISubprogram(name: "main", scope: !1, file: !1, line: 12, type: !9, scopeLine: 12, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !2)
!14 = !DILocalVariable(name: "s", scope: !13, file: !1, line: 13, type: !15)
!15 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "struct_t", file: !1, line: 3, size: 64, elements: !16)
!16 = !{!17, !18}
!17 = !DIDerivedType(tag: DW_TAG_member, name: "a", scope: !15, file: !1, line: 4, baseType: !11, size: 32)
!18 = !DIDerivedType(tag: DW_TAG_member, name: "b", scope: !15, file: !1, line: 5, baseType: !19, size: 32, offset: 32)
!19 = !DIBasicType(name: "float", size: 32, encoding: DW_ATE_float)
!20 = !DILocation(line: 13, column: 21, scope: !13)
!21 = !DILocalVariable(name: "a", scope: !13, file: !1, line: 14, type: !11)
!22 = !DILocation(line: 14, column: 9, scope: !13)
!23 = !DILocalVariable(name: "b", scope: !13, file: !1, line: 15, type: !19)
!24 = !DILocation(line: 15, column: 11, scope: !13)
!25 = !DILocation(line: 17, column: 9, scope: !26)
!26 = distinct !DILexicalBlock(scope: !13, file: !1, line: 17, column: 9)
!27 = !DILocation(line: 17, column: 9, scope: !13)
!28 = !DILocation(line: 18, column: 15, scope: !29)
!29 = distinct !DILexicalBlock(scope: !26, file: !1, line: 17, column: 20)
!30 = !DILocation(line: 18, column: 11, scope: !29)
!31 = !DILocation(line: 18, column: 13, scope: !29)
!32 = !DILocation(line: 19, column: 5, scope: !29)
!33 = !DILocation(line: 20, column: 15, scope: !34)
!34 = distinct !DILexicalBlock(scope: !26, file: !1, line: 19, column: 12)
!35 = !DILocation(line: 20, column: 11, scope: !34)
!36 = !DILocation(line: 20, column: 13, scope: !34)
!37 = !DILocation(line: 24, column: 5, scope: !13)
