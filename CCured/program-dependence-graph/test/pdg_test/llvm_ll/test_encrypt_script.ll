; ModuleID = 'test_encrypt_script.c'
source_filename = "test_encrypt_script.c"
target datalayout = "e-m:o-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-apple-macosx10.15.0"

@greeter.sample = internal global i32 1, align 4, !dbg !0
@.str = private unnamed_addr constant [4 x i8] c"%s\0A\00", align 1
@.str.1 = private unnamed_addr constant [12 x i8] c", welcome!\0A\00", align 1
@key = common global i8* null, align 8, !dbg !14
@i = internal global i32 0, align 4, !dbg !18
@ciphertext = common global i8* null, align 8, !dbg !16
@.str.2 = private unnamed_addr constant [6 x i8] c"green\00", section "llvm.metadata"
@.str.3 = private unnamed_addr constant [22 x i8] c"test_encrypt_script.c\00", section "llvm.metadata"
@.str.4 = private unnamed_addr constant [7 x i8] c"orange\00", section "llvm.metadata"
@.str.5 = private unnamed_addr constant [17 x i8] c"Enter username: \00", align 1
@.str.6 = private unnamed_addr constant [5 x i8] c"%19s\00", align 1
@.str.7 = private unnamed_addr constant [18 x i8] c"Enter plaintext: \00", align 1
@.str.8 = private unnamed_addr constant [7 x i8] c"%1023s\00", align 1
@.str.9 = private unnamed_addr constant [14 x i8] c"Cipher text: \00", align 1
@.str.10 = private unnamed_addr constant [4 x i8] c"%x \00", align 1
@.str.11 = private unnamed_addr constant [22 x i8] c"encryption length: %d\00", align 1
@.str.12 = private unnamed_addr constant [5 x i8] c"blue\00", section "llvm.metadata"
@llvm.global.annotations = appending global [2 x { i8*, i8*, i8*, i32 }] [{ i8*, i8*, i8*, i32 } { i8* bitcast (i32 (i8*, i32)* @encrypt to i8*), i8* getelementptr inbounds ([6 x i8], [6 x i8]* @.str.2, i32 0, i32 0), i8* getelementptr inbounds ([22 x i8], [22 x i8]* @.str.3, i32 0, i32 0), i32 23 }, { i8*, i8*, i8*, i32 } { i8* bitcast (i8** @key to i8*), i8* getelementptr inbounds ([5 x i8], [5 x i8]* @.str.12, i32 0, i32 0), i8* getelementptr inbounds ([22 x i8], [22 x i8]* @.str.3, i32 0, i32 0), i32 5 }], section "llvm.metadata"

; Function Attrs: noinline nounwind optnone ssp uwtable
define void @greeter(i8* %str, i32* %s) #0 !dbg !2 {
entry:
  %str.addr = alloca i8*, align 8
  %s.addr = alloca i32*, align 8
  %p = alloca i8*, align 8
  store i8* %str, i8** %str.addr, align 8
  call void @llvm.dbg.declare(metadata i8** %str.addr, metadata !26, metadata !DIExpression()), !dbg !27
  store i32* %s, i32** %s.addr, align 8
  call void @llvm.dbg.declare(metadata i32** %s.addr, metadata !28, metadata !DIExpression()), !dbg !29
  call void @llvm.dbg.declare(metadata i8** %p, metadata !30, metadata !DIExpression()), !dbg !31
  %0 = load i8*, i8** %str.addr, align 8, !dbg !32
  store i8* %0, i8** %p, align 8, !dbg !31
  %1 = load i8*, i8** %p, align 8, !dbg !33
  %call = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([4 x i8], [4 x i8]* @.str, i64 0, i64 0), i8* %1), !dbg !34
  %call1 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([12 x i8], [12 x i8]* @.str.1, i64 0, i64 0)), !dbg !35
  %2 = load i32*, i32** %s.addr, align 8, !dbg !36
  store i32 15, i32* %2, align 4, !dbg !37
  ret void, !dbg !38
}

; Function Attrs: nounwind readnone speculatable willreturn
declare void @llvm.dbg.declare(metadata, metadata, metadata) #1

declare i32 @printf(i8*, ...) #2

; Function Attrs: noinline nounwind optnone ssp uwtable
define void @initkey(i32 %sz) #0 !dbg !39 {
entry:
  %sz.addr = alloca i32, align 4
  store i32 %sz, i32* %sz.addr, align 4
  call void @llvm.dbg.declare(metadata i32* %sz.addr, metadata !42, metadata !DIExpression()), !dbg !43
  %0 = load i32, i32* %sz.addr, align 4, !dbg !44
  %conv = sext i32 %0 to i64, !dbg !44
  %call = call i8* @malloc(i64 %conv) #5, !dbg !45
  store i8* %call, i8** @key, align 8, !dbg !46
  store i32 0, i32* @i, align 4, !dbg !47
  br label %for.cond, !dbg !49

for.cond:                                         ; preds = %for.inc, %entry
  %1 = load i32, i32* @i, align 4, !dbg !50
  %2 = load i32, i32* %sz.addr, align 4, !dbg !52
  %cmp = icmp ult i32 %1, %2, !dbg !53
  br i1 %cmp, label %for.body, label %for.end, !dbg !54

for.body:                                         ; preds = %for.cond
  %3 = load i8*, i8** @key, align 8, !dbg !55
  %4 = load i32, i32* @i, align 4, !dbg !56
  %idxprom = zext i32 %4 to i64, !dbg !55
  %arrayidx = getelementptr inbounds i8, i8* %3, i64 %idxprom, !dbg !55
  store i8 1, i8* %arrayidx, align 1, !dbg !57
  br label %for.inc, !dbg !55

for.inc:                                          ; preds = %for.body
  %5 = load i32, i32* @i, align 4, !dbg !58
  %inc = add i32 %5, 1, !dbg !58
  store i32 %inc, i32* @i, align 4, !dbg !58
  br label %for.cond, !dbg !59, !llvm.loop !60

for.end:                                          ; preds = %for.cond
  ret void, !dbg !62
}

; Function Attrs: allocsize(0)
declare i8* @malloc(i64) #3

; Function Attrs: noinline nounwind optnone ssp uwtable
define i32 @encrypt(i8* %plaintext, i32 %sz) #0 !dbg !63 {
entry:
  %plaintext.addr = alloca i8*, align 8
  %sz.addr = alloca i32, align 4
  store i8* %plaintext, i8** %plaintext.addr, align 8
  call void @llvm.dbg.declare(metadata i8** %plaintext.addr, metadata !66, metadata !DIExpression()), !dbg !67
  store i32 %sz, i32* %sz.addr, align 4
  call void @llvm.dbg.declare(metadata i32* %sz.addr, metadata !68, metadata !DIExpression()), !dbg !69
  %0 = load i32, i32* %sz.addr, align 4, !dbg !70
  %conv = sext i32 %0 to i64, !dbg !70
  %call = call i8* @malloc(i64 %conv) #5, !dbg !71
  store i8* %call, i8** @ciphertext, align 8, !dbg !72
  store i32 0, i32* @i, align 4, !dbg !73
  br label %for.cond, !dbg !75

for.cond:                                         ; preds = %for.inc, %entry
  %1 = load i32, i32* @i, align 4, !dbg !76
  %2 = load i32, i32* %sz.addr, align 4, !dbg !78
  %cmp = icmp ult i32 %1, %2, !dbg !79
  br i1 %cmp, label %for.body, label %for.end, !dbg !80

for.body:                                         ; preds = %for.cond
  %3 = load i8*, i8** %plaintext.addr, align 8, !dbg !81
  %4 = load i32, i32* @i, align 4, !dbg !82
  %idxprom = zext i32 %4 to i64, !dbg !81
  %arrayidx = getelementptr inbounds i8, i8* %3, i64 %idxprom, !dbg !81
  %5 = load i8, i8* %arrayidx, align 1, !dbg !81
  %conv2 = sext i8 %5 to i32, !dbg !81
  %6 = load i8*, i8** @key, align 8, !dbg !83
  %7 = load i32, i32* @i, align 4, !dbg !84
  %idxprom3 = zext i32 %7 to i64, !dbg !83
  %arrayidx4 = getelementptr inbounds i8, i8* %6, i64 %idxprom3, !dbg !83
  %8 = load i8, i8* %arrayidx4, align 1, !dbg !83
  %conv5 = sext i8 %8 to i32, !dbg !83
  %xor = xor i32 %conv2, %conv5, !dbg !85
  %conv6 = trunc i32 %xor to i8, !dbg !81
  %9 = load i8*, i8** @ciphertext, align 8, !dbg !86
  %10 = load i32, i32* @i, align 4, !dbg !87
  %idxprom7 = zext i32 %10 to i64, !dbg !86
  %arrayidx8 = getelementptr inbounds i8, i8* %9, i64 %idxprom7, !dbg !86
  store i8 %conv6, i8* %arrayidx8, align 1, !dbg !88
  br label %for.inc, !dbg !86

for.inc:                                          ; preds = %for.body
  %11 = load i32, i32* @i, align 4, !dbg !89
  %inc = add i32 %11, 1, !dbg !89
  store i32 %inc, i32* @i, align 4, !dbg !89
  br label %for.cond, !dbg !90, !llvm.loop !91

for.end:                                          ; preds = %for.cond
  %12 = load i32, i32* %sz.addr, align 4, !dbg !93
  ret i32 %12, !dbg !94
}

; Function Attrs: noinline nounwind optnone ssp uwtable
define i32 @main() #0 !dbg !95 {
entry:
  %retval = alloca i32, align 4
  %age = alloca i32, align 4
  %username = alloca [20 x i8], align 16
  %text = alloca [1024 x i8], align 16
  %sz = alloca i32, align 4
  store i32 0, i32* %retval, align 4
  call void @llvm.dbg.declare(metadata i32* %age, metadata !98, metadata !DIExpression()), !dbg !99
  store i32 10, i32* %age, align 4, !dbg !99
  call void @llvm.dbg.declare(metadata [20 x i8]* %username, metadata !100, metadata !DIExpression()), !dbg !104
  %username1 = bitcast [20 x i8]* %username to i8*, !dbg !105
  call void @llvm.var.annotation(i8* %username1, i8* getelementptr inbounds ([7 x i8], [7 x i8]* @.str.4, i32 0, i32 0), i8* getelementptr inbounds ([22 x i8], [22 x i8]* @.str.3, i32 0, i32 0), i32 32), !dbg !105
  call void @llvm.dbg.declare(metadata [1024 x i8]* %text, metadata !106, metadata !DIExpression()), !dbg !110
  %call = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([17 x i8], [17 x i8]* @.str.5, i64 0, i64 0)), !dbg !111
  %arraydecay = getelementptr inbounds [20 x i8], [20 x i8]* %username, i64 0, i64 0, !dbg !112
  %call2 = call i32 (i8*, ...) @scanf(i8* getelementptr inbounds ([5 x i8], [5 x i8]* @.str.6, i64 0, i64 0), i8* %arraydecay), !dbg !113
  %arraydecay3 = getelementptr inbounds [20 x i8], [20 x i8]* %username, i64 0, i64 0, !dbg !114
  call void @greeter(i8* %arraydecay3, i32* %age), !dbg !115
  %call4 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([18 x i8], [18 x i8]* @.str.7, i64 0, i64 0)), !dbg !116
  %arraydecay5 = getelementptr inbounds [1024 x i8], [1024 x i8]* %text, i64 0, i64 0, !dbg !117
  %call6 = call i32 (i8*, ...) @scanf(i8* getelementptr inbounds ([7 x i8], [7 x i8]* @.str.8, i64 0, i64 0), i8* %arraydecay5), !dbg !118
  %arraydecay7 = getelementptr inbounds [1024 x i8], [1024 x i8]* %text, i64 0, i64 0, !dbg !119
  %call8 = call i64 @strlen(i8* %arraydecay7), !dbg !120
  %conv = trunc i64 %call8 to i32, !dbg !120
  call void @initkey(i32 %conv), !dbg !121
  call void @llvm.dbg.declare(metadata i32* %sz, metadata !122, metadata !DIExpression()), !dbg !123
  %arraydecay9 = getelementptr inbounds [1024 x i8], [1024 x i8]* %text, i64 0, i64 0, !dbg !124
  %arraydecay10 = getelementptr inbounds [1024 x i8], [1024 x i8]* %text, i64 0, i64 0, !dbg !125
  %call11 = call i64 @strlen(i8* %arraydecay10), !dbg !126
  %conv12 = trunc i64 %call11 to i32, !dbg !126
  %call13 = call i32 @encrypt(i8* %arraydecay9, i32 %conv12), !dbg !127
  store i32 %call13, i32* %sz, align 4, !dbg !123
  %call14 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([14 x i8], [14 x i8]* @.str.9, i64 0, i64 0)), !dbg !128
  store i32 0, i32* @i, align 4, !dbg !129
  br label %for.cond, !dbg !131

for.cond:                                         ; preds = %for.inc, %entry
  %0 = load i32, i32* @i, align 4, !dbg !132
  %conv15 = zext i32 %0 to i64, !dbg !132
  %arraydecay16 = getelementptr inbounds [1024 x i8], [1024 x i8]* %text, i64 0, i64 0, !dbg !134
  %call17 = call i64 @strlen(i8* %arraydecay16), !dbg !135
  %cmp = icmp ult i64 %conv15, %call17, !dbg !136
  br i1 %cmp, label %for.body, label %for.end, !dbg !137

for.body:                                         ; preds = %for.cond
  %1 = load i8*, i8** @ciphertext, align 8, !dbg !138
  %2 = load i32, i32* @i, align 4, !dbg !139
  %idxprom = zext i32 %2 to i64, !dbg !138
  %arrayidx = getelementptr inbounds i8, i8* %1, i64 %idxprom, !dbg !138
  %3 = load i8, i8* %arrayidx, align 1, !dbg !138
  %conv19 = sext i8 %3 to i32, !dbg !138
  %call20 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([4 x i8], [4 x i8]* @.str.10, i64 0, i64 0), i32 %conv19), !dbg !140
  br label %for.inc, !dbg !140

for.inc:                                          ; preds = %for.body
  %4 = load i32, i32* @i, align 4, !dbg !141
  %inc = add i32 %4, 1, !dbg !141
  store i32 %inc, i32* @i, align 4, !dbg !141
  br label %for.cond, !dbg !142, !llvm.loop !143

for.end:                                          ; preds = %for.cond
  %5 = load i32, i32* %sz, align 4, !dbg !145
  %call21 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([22 x i8], [22 x i8]* @.str.11, i64 0, i64 0), i32 %5), !dbg !146
  ret i32 0, !dbg !147
}

; Function Attrs: nounwind willreturn
declare void @llvm.var.annotation(i8*, i8*, i8*, i32) #4

declare i32 @scanf(i8*, ...) #2

declare i64 @strlen(i8*) #2

attributes #0 = { noinline nounwind optnone ssp uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "frame-pointer"="all" "less-precise-fpmad"="false" "min-legal-vector-width"="0" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="penryn" "target-features"="+cx16,+cx8,+fxsr,+mmx,+sahf,+sse,+sse2,+sse3,+sse4.1,+ssse3,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind readnone speculatable willreturn }
attributes #2 = { "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "frame-pointer"="all" "less-precise-fpmad"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="penryn" "target-features"="+cx16,+cx8,+fxsr,+mmx,+sahf,+sse,+sse2,+sse3,+sse4.1,+ssse3,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #3 = { allocsize(0) "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "frame-pointer"="all" "less-precise-fpmad"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="penryn" "target-features"="+cx16,+cx8,+fxsr,+mmx,+sahf,+sse,+sse2,+sse3,+sse4.1,+ssse3,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #4 = { nounwind willreturn }
attributes #5 = { allocsize(0) }

!llvm.dbg.cu = !{!10}
!llvm.module.flags = !{!21, !22, !23, !24}
!llvm.ident = !{!25}

!0 = !DIGlobalVariableExpression(var: !1, expr: !DIExpression())
!1 = distinct !DIGlobalVariable(name: "sample", scope: !2, file: !3, line: 11, type: !9, isLocal: true, isDefinition: true)
!2 = distinct !DISubprogram(name: "greeter", scope: !3, file: !3, line: 9, type: !4, scopeLine: 9, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !10, retainedNodes: !11)
!3 = !DIFile(filename: "test_encrypt_script.c", directory: "/Users/yongzhehuang/Library/Mobile Documents/com~apple~CloudDocs/Documents/llvm_versions/program-dependence-graph/test/pdg_test")
!4 = !DISubroutineType(types: !5)
!5 = !{null, !6, !8}
!6 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !7, size: 64)
!7 = !DIBasicType(name: "char", size: 8, encoding: DW_ATE_signed_char)
!8 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !9, size: 64)
!9 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!10 = distinct !DICompileUnit(language: DW_LANG_C99, file: !3, producer: "clang version 10.0.0 ", isOptimized: false, runtimeVersion: 0, emissionKind: FullDebug, enums: !11, retainedTypes: !12, globals: !13, nameTableKind: None)
!11 = !{}
!12 = !{!6}
!13 = !{!0, !14, !16, !18}
!14 = !DIGlobalVariableExpression(var: !15, expr: !DIExpression())
!15 = distinct !DIGlobalVariable(name: "key", scope: !10, file: !3, line: 5, type: !6, isLocal: false, isDefinition: true)
!16 = !DIGlobalVariableExpression(var: !17, expr: !DIExpression())
!17 = distinct !DIGlobalVariable(name: "ciphertext", scope: !10, file: !3, line: 6, type: !6, isLocal: false, isDefinition: true)
!18 = !DIGlobalVariableExpression(var: !19, expr: !DIExpression())
!19 = distinct !DIGlobalVariable(name: "i", scope: !10, file: !3, line: 7, type: !20, isLocal: true, isDefinition: true)
!20 = !DIBasicType(name: "unsigned int", size: 32, encoding: DW_ATE_unsigned)
!21 = !{i32 7, !"Dwarf Version", i32 4}
!22 = !{i32 2, !"Debug Info Version", i32 3}
!23 = !{i32 1, !"wchar_size", i32 4}
!24 = !{i32 7, !"PIC Level", i32 2}
!25 = !{!"clang version 10.0.0 "}
!26 = !DILocalVariable(name: "str", arg: 1, scope: !2, file: !3, line: 9, type: !6)
!27 = !DILocation(line: 9, column: 21, scope: !2)
!28 = !DILocalVariable(name: "s", arg: 2, scope: !2, file: !3, line: 9, type: !8)
!29 = !DILocation(line: 9, column: 31, scope: !2)
!30 = !DILocalVariable(name: "p", scope: !2, file: !3, line: 10, type: !6)
!31 = !DILocation(line: 10, column: 11, scope: !2)
!32 = !DILocation(line: 10, column: 15, scope: !2)
!33 = !DILocation(line: 12, column: 20, scope: !2)
!34 = !DILocation(line: 12, column: 5, scope: !2)
!35 = !DILocation(line: 13, column: 5, scope: !2)
!36 = !DILocation(line: 14, column: 6, scope: !2)
!37 = !DILocation(line: 14, column: 8, scope: !2)
!38 = !DILocation(line: 15, column: 1, scope: !2)
!39 = distinct !DISubprogram(name: "initkey", scope: !3, file: !3, line: 17, type: !40, scopeLine: 17, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !10, retainedNodes: !11)
!40 = !DISubroutineType(types: !41)
!41 = !{null, !9}
!42 = !DILocalVariable(name: "sz", arg: 1, scope: !39, file: !3, line: 17, type: !9)
!43 = !DILocation(line: 17, column: 19, scope: !39)
!44 = !DILocation(line: 18, column: 26, scope: !39)
!45 = !DILocation(line: 18, column: 18, scope: !39)
!46 = !DILocation(line: 18, column: 6, scope: !39)
!47 = !DILocation(line: 20, column: 8, scope: !48)
!48 = distinct !DILexicalBlock(scope: !39, file: !3, line: 20, column: 2)
!49 = !DILocation(line: 20, column: 7, scope: !48)
!50 = !DILocation(line: 20, column: 12, scope: !51)
!51 = distinct !DILexicalBlock(scope: !48, file: !3, line: 20, column: 2)
!52 = !DILocation(line: 20, column: 14, scope: !51)
!53 = !DILocation(line: 20, column: 13, scope: !51)
!54 = !DILocation(line: 20, column: 2, scope: !48)
!55 = !DILocation(line: 20, column: 23, scope: !51)
!56 = !DILocation(line: 20, column: 27, scope: !51)
!57 = !DILocation(line: 20, column: 29, scope: !51)
!58 = !DILocation(line: 20, column: 19, scope: !51)
!59 = !DILocation(line: 20, column: 2, scope: !51)
!60 = distinct !{!60, !54, !61}
!61 = !DILocation(line: 20, column: 31, scope: !48)
!62 = !DILocation(line: 21, column: 1, scope: !39)
!63 = distinct !DISubprogram(name: "encrypt", scope: !3, file: !3, line: 23, type: !64, scopeLine: 23, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !10, retainedNodes: !11)
!64 = !DISubroutineType(types: !65)
!65 = !{!9, !6, !9}
!66 = !DILocalVariable(name: "plaintext", arg: 1, scope: !63, file: !3, line: 23, type: !6)
!67 = !DILocation(line: 23, column: 55, scope: !63)
!68 = !DILocalVariable(name: "sz", arg: 2, scope: !63, file: !3, line: 23, type: !9)
!69 = !DILocation(line: 23, column: 70, scope: !63)
!70 = !DILocation(line: 24, column: 33, scope: !63)
!71 = !DILocation(line: 24, column: 25, scope: !63)
!72 = !DILocation(line: 24, column: 13, scope: !63)
!73 = !DILocation(line: 25, column: 8, scope: !74)
!74 = distinct !DILexicalBlock(scope: !63, file: !3, line: 25, column: 2)
!75 = !DILocation(line: 25, column: 7, scope: !74)
!76 = !DILocation(line: 25, column: 12, scope: !77)
!77 = distinct !DILexicalBlock(scope: !74, file: !3, line: 25, column: 2)
!78 = !DILocation(line: 25, column: 14, scope: !77)
!79 = !DILocation(line: 25, column: 13, scope: !77)
!80 = !DILocation(line: 25, column: 2, scope: !74)
!81 = !DILocation(line: 26, column: 17, scope: !77)
!82 = !DILocation(line: 26, column: 27, scope: !77)
!83 = !DILocation(line: 26, column: 32, scope: !77)
!84 = !DILocation(line: 26, column: 36, scope: !77)
!85 = !DILocation(line: 26, column: 30, scope: !77)
!86 = !DILocation(line: 26, column: 3, scope: !77)
!87 = !DILocation(line: 26, column: 14, scope: !77)
!88 = !DILocation(line: 26, column: 16, scope: !77)
!89 = !DILocation(line: 25, column: 19, scope: !77)
!90 = !DILocation(line: 25, column: 2, scope: !77)
!91 = distinct !{!91, !80, !92}
!92 = !DILocation(line: 26, column: 37, scope: !74)
!93 = !DILocation(line: 27, column: 12, scope: !63)
!94 = !DILocation(line: 27, column: 5, scope: !63)
!95 = distinct !DISubprogram(name: "main", scope: !3, file: !3, line: 30, type: !96, scopeLine: 30, spFlags: DISPFlagDefinition, unit: !10, retainedNodes: !11)
!96 = !DISubroutineType(types: !97)
!97 = !{!9}
!98 = !DILocalVariable(name: "age", scope: !95, file: !3, line: 31, type: !9)
!99 = !DILocation(line: 31, column: 9, scope: !95)
!100 = !DILocalVariable(name: "username", scope: !95, file: !3, line: 32, type: !101)
!101 = !DICompositeType(tag: DW_TAG_array_type, baseType: !7, size: 160, elements: !102)
!102 = !{!103}
!103 = !DISubrange(count: 20)
!104 = !DILocation(line: 32, column: 42, scope: !95)
!105 = !DILocation(line: 32, column: 2, scope: !95)
!106 = !DILocalVariable(name: "text", scope: !95, file: !3, line: 33, type: !107)
!107 = !DICompositeType(tag: DW_TAG_array_type, baseType: !7, size: 8192, elements: !108)
!108 = !{!109}
!109 = !DISubrange(count: 1024)
!110 = !DILocation(line: 33, column: 14, scope: !95)
!111 = !DILocation(line: 34, column: 2, scope: !95)
!112 = !DILocation(line: 35, column: 15, scope: !95)
!113 = !DILocation(line: 35, column: 2, scope: !95)
!114 = !DILocation(line: 36, column: 10, scope: !95)
!115 = !DILocation(line: 36, column: 2, scope: !95)
!116 = !DILocation(line: 37, column: 2, scope: !95)
!117 = !DILocation(line: 38, column: 17, scope: !95)
!118 = !DILocation(line: 38, column: 2, scope: !95)
!119 = !DILocation(line: 40, column: 17, scope: !95)
!120 = !DILocation(line: 40, column: 10, scope: !95)
!121 = !DILocation(line: 40, column: 2, scope: !95)
!122 = !DILocalVariable(name: "sz", scope: !95, file: !3, line: 41, type: !9)
!123 = !DILocation(line: 41, column: 6, scope: !95)
!124 = !DILocation(line: 41, column: 19, scope: !95)
!125 = !DILocation(line: 41, column: 32, scope: !95)
!126 = !DILocation(line: 41, column: 25, scope: !95)
!127 = !DILocation(line: 41, column: 11, scope: !95)
!128 = !DILocation(line: 42, column: 2, scope: !95)
!129 = !DILocation(line: 43, column: 8, scope: !130)
!130 = distinct !DILexicalBlock(scope: !95, file: !3, line: 43, column: 2)
!131 = !DILocation(line: 43, column: 7, scope: !130)
!132 = !DILocation(line: 43, column: 12, scope: !133)
!133 = distinct !DILexicalBlock(scope: !130, file: !3, line: 43, column: 2)
!134 = !DILocation(line: 43, column: 21, scope: !133)
!135 = !DILocation(line: 43, column: 14, scope: !133)
!136 = !DILocation(line: 43, column: 13, scope: !133)
!137 = !DILocation(line: 43, column: 2, scope: !130)
!138 = !DILocation(line: 44, column: 16, scope: !133)
!139 = !DILocation(line: 44, column: 27, scope: !133)
!140 = !DILocation(line: 44, column: 3, scope: !133)
!141 = !DILocation(line: 43, column: 29, scope: !133)
!142 = !DILocation(line: 43, column: 2, scope: !133)
!143 = distinct !{!143, !137, !144}
!144 = !DILocation(line: 44, column: 29, scope: !130)
!145 = !DILocation(line: 45, column: 38, scope: !95)
!146 = !DILocation(line: 45, column: 6, scope: !95)
!147 = !DILocation(line: 46, column: 6, scope: !95)
