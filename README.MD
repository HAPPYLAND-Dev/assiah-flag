# Assiah Flag

## 描述
HAPPYLAND 服务端通用启动参数

## 特性
- 支持自选目录下的多个服务端
- 使用 `ZGC` 取代 `G1GC`
- 神秘特调启动参数
- 自动重启
- 方便修改内存

## 安装
直接取代你原本的启动脚本然后 `./Start.sh` 选择服务端文件并回车

## 参考项目
- https://github.com/etil2jz/etil-minecraft-flags
- https://aikar.co/2018/07/02/tuning-the-jvm-g1gc-garbage-collector-flags-for-minecraft/

## G1GC 版本参数

```bash
$JAVA_HOME \
    -Xms$MEMORY -Xmx$MEMORY -Xss512k \
    -XX:+UseG1GC -XX:+ParallelRefProcEnabled -XX:MaxGCPauseMillis=200 \
    -XX:+UnlockExperimentalVMOptions -XX:+UnlockDiagnosticVMOptions \
    -XX:+DisableExplicitGC -XX:+AlwaysPreTouch \
    -XX:G1NewSizePercent=30 -XX:G1MaxNewSizePercent=40 -XX:G1HeapRegionSize=8M \
    -XX:G1ReservePercent=20 -XX:G1HeapWastePercent=5 -XX:G1MixedGCCountTarget=4 \
    -XX:InitiatingHeapOccupancyPercent=15 -XX:G1MixedGCLiveThresholdPercent=90 \
    -XX:G1RSetUpdatingPauseTimePercent=5 \
    -XX:SurvivorRatio=32 -XX:+PerfDisableSharedMem -XX:MaxTenuringThreshold=1 \
    -XX:UseAVX=3 -XX:+UseStringDeduplication -XX:+UseFastUnorderedTimeStamps \
    -XX:+UseAES -XX:+UseAESIntrinsics -XX:UseSSE=4 -XX:+UseFMA \
    -XX:AllocatePrefetchStyle=1 -XX:+UseLoopPredicate -XX:+RangeCheckElimination \
    -XX:+EliminateLocks -XX:+DoEscapeAnalysis \
    -XX:+TieredCompilation -XX:CompileThreshold=1000 -XX:MaxInlineLevel=15 \
    -XX:+UseCodeCacheFlushing -XX:+SegmentedCodeCache -XX:+UseFastJNIAccessors \
    -XX:+OptimizeStringConcat -XX:+UseCompressedOops -XX:+UseCompressedClassPointers -XX:+UseThreadPriorities \
    -XX:+OmitStackTraceInFastThrow -XX:+TrustFinalNonStaticFields \
    -XX:ThreadPriorityPolicy=1 -XX:+UseInlineCaches -XX:+RewriteBytecodes \
    -XX:+RewriteFrequentPairs -XX:+UseNUMA -XX:-DontCompileHugeMethods \
    -XX:+UseFPUForSpilling -XX:+UseFastStosb -XX:+UseNewLongLShift \
    -XX:+UseVectorCmov -XX:+UseXMMForArrayCopy -XX:+UseXmmI2D \
    -XX:+UseXmmI2F -XX:+UseXmmLoadAndClearUpper -XX:+UseXmmRegToRegMoveAll \
    -Xlog:async \
    -Dfile.encoding=UTF-8 -Djava.security.egd=file:/dev/urandom -Duser.timezone=GMT+8 \
    --add-modules jdk.incubator.vector \
    -jar "$jar" nogui
```

## ZGC 版本参数
实际使用过程中内存占用大于 ```G1GC``` , 内存小还是别用了

```bash
$JAVA_HOME \
    -Xms$MEMORY \
    -Xmx$MEMORY \
    -XX:+UseZGC \
    -XX:+ParallelRefProcEnabled \
    -XX:MaxGCPauseMillis=200 \
    -XX:+UnlockExperimentalVMOptions \
    -XX:+UnlockDiagnosticVMOptions \
    -XX:+DisableExplicitGC \
    -XX:+AlwaysPreTouch \
    -XX:ZCollectionInterval=100 \
    -XX:+PerfDisableSharedMem \
    -XX:MaxTenuringThreshold=1 \
    -Dusing.aikars.flags=https://mcflags.emc.gs \
    -Daikars.new.flags=true \
    -XX:MaxTenuringThreshold=1 \
    -XX:UseAVX=3 \
    -XX:+UseStringDeduplication \
    -XX:+UseFastUnorderedTimeStamps \
    -XX:+UseAES \
    -XX:+UseAESIntrinsics \
    -XX:UseSSE=4 \
    -XX:+UseFMA \
    -XX:AllocatePrefetchStyle=1 \
    -XX:+UseLoopPredicate \
    -XX:+RangeCheckElimination \
    -XX:+EliminateLocks \
    -XX:+DoEscapeAnalysis \
    -XX:+UseCodeCacheFlushing \
    -XX:+SegmentedCodeCache \
    -XX:+UseFastJNIAccessors \
    -XX:+OptimizeStringConcat \
    -XX:+UseCompressedOops \
    -XX:+UseThreadPriorities \
    -XX:+OmitStackTraceInFastThrow \
    -XX:+TrustFinalNonStaticFields \
    -XX:ThreadPriorityPolicy=1 \
    -XX:+UseInlineCaches \
    -XX:+RewriteBytecodes \
    -XX:+RewriteFrequentPairs \
    -XX:+UseNUMA \
    -XX:-DontCompileHugeMethods \
    -XX:+UseFPUForSpilling \
    -XX:+UseFastStosb \
    -XX:+UseNewLongLShift \
    -XX:+UseVectorCmov \
    -XX:+UseXMMForArrayCopy \
    -XX:+UseXmmI2D \
    -XX:+UseXmmI2F \
    -XX:+UseXmmLoadAndClearUpper \
    -XX:+UseXmmRegToRegMoveAll \
    -Dfile.encoding=UTF-8 \
    -Djava.security.egd=file:/dev/urandom \
    -Duser.timezone=GMT+8 \
    --add-modules jdk.incubator.vector \
    -jar "$jar" --nogui
```

## 克隆仓库
```bash
git clone https://github.com/HAPPYLAND-Dev/assiah-flag
```
