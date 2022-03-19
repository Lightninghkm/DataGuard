; ModuleID = 'test.c'
source_filename = "test.c"
target datalayout = "e-m:o-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-apple-macosx10.15.0"

%struct.S = type { i32, i32 }

@.str = private unnamed_addr constant [4 x i8] c"%d\0A\00", align 1

; Function Attrs: noinline nounwind optnone ssp uwtable
define void @f(%struct.S* %s) #0 !dbg !8 {
entry:
  %s.addr = alloca %struct.S*, align 8
  store %struct.S* %s, %struct.S** %s.addr, align 8
  call void @llvm.dbg.declare(metadata %struct.S** %s.addr, metadata !17, metadata !DIExpression()), !dbg !18
  %0 = load %struct.S*, %struct.S** %s.addr, align 8, !dbg !19
  %a = getelementptr inbounds %struct.S, %struct.S* %0, i32 0, i32 0, !dbg !20
  %1 = load i32, i32* %a, align 4, !dbg !21
  %or = or i32 %1, 10, !dbg !21
  store i32 %or, i32* %a, align 4, !dbg !21
  %2 = load %struct.S*, %struct.S** %s.addr, align 8, !dbg !22
  %a1 = getelementptr inbounds %struct.S, %struct.S* %2, i32 0, i32 0, !dbg !23
  %3 = load i32, i32* %a1, align 4, !dbg !23
  %call = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([4 x i8], [4 x i8]* @.str, i64 0, i64 0), i32 %3), !dbg !24
  ret void, !dbg !25
}

; Function Attrs: nounwind readnone speculatable willreturn
declare void @llvm.dbg.declare(metadata, metadata, metadata) #1

declare i32 @printf(i8*, ...) #2

; Function Attrs: noinline nounwind optnone ssp uwtable
define i32 @main() #0 !dbg !26 {
entry:
  %retval = alloca i32, align 4
  store i32 0, i32* %retval, align 4
  ret i32 0, !dbg !29
}

attributes #0 = { noinline nounwind optnone ssp uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "frame-pointer"="all" "less-precise-fpmad"="false" "min-legal-vector-width"="0" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="penryn" "target-features"="+cx16,+cx8,+fxsr,+mmx,+sahf,+sse,+sse2,+sse3,+sse4.1,+ssse3,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind readnone speculatable willreturn }
attributes #2 = { "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "frame-pointer"="all" "less-precise-fpmad"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="penryn" "target-features"="+cx16,+cx8,+fxsr,+mmx,+sahf,+sse,+sse2,+sse3,+sse4.1,+ssse3,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }

!llvm.dbg.cu = !{!0}
!llvm.module.flags = !{!3, !4, !5, !6}
!llvm.ident = !{!7}

!0 = distinct !DICompileUnit(language: DW_LANG_C99, file: !1, producer: "clang version 10.0.0 ", isOptimized: false, runtimeVersion: 0, emissionKind: FullDebug, enums: !2, nameTableKind: None)
!1 = !DIFile(filename: "test.c", directory: "/Users/yongzhehuang/Library/Mobile Documents/com~apple~CloudDocs/Documents/llvm_versions/program-dependence-graph/test/pdg_test")
!2 = !{}
!3 = !{i32 7, !"Dwarf Version", i32 4}
!4 = !{i32 2, !"Debug Info Version", i32 3}
!5 = !{i32 1, !"wchar_size", i32 4}
!6 = !{i32 7, !"PIC Level", i32 2}
!7 = !{!"clang version 10.0.0 "}
!8 = distinct !DISubprogram(name: "f", scope: !1, file: !1, line: 7, type: !9, scopeLine: 7, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !2)
!9 = !DISubroutineType(types: !10)
!10 = !{null, !11}
!11 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !12, size: 64)
!12 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "S", file: !1, line: 2, size: 64, elements: !13)
!13 = !{!14, !16}
!14 = !DIDerivedType(tag: DW_TAG_member, name: "a", scope: !12, file: !1, line: 3, baseType: !15, size: 32)
!15 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!16 = !DIDerivedType(tag: DW_TAG_member, name: "b", scope: !12, file: !1, line: 4, baseType: !15, size: 32, offset: 32)
!17 = !DILocalVariable(name: "s", arg: 1, scope: !8, file: !1, line: 7, type: !11)
!18 = !DILocation(line: 7, column: 18, scope: !8)
!19 = !DILocation(line: 8, column: 5, scope: !8)
!20 = !DILocation(line: 8, column: 8, scope: !8)
!21 = !DILocation(line: 8, column: 10, scope: !8)
!22 = !DILocation(line: 9, column: 20, scope: !8)
!23 = !DILocation(line: 9, column: 23, scope: !8)
!24 = !DILocation(line: 9, column: 5, scope: !8)
!25 = !DILocation(line: 10, column: 1, scope: !8)
!26 = distinct !DISubprogram(name: "main", scope: !1, file: !1, line: 12, type: !27, scopeLine: 12, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !2)
!27 = !DISubroutineType(types: !28)
!28 = !{!15}
!29 = !DILocation(line: 13, column: 5, scope: !26)
