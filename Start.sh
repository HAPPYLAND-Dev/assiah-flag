#!/bin/bash
MEMORY="8G"
JAVA_HOME="../Runtime/bin/java"

$JAVA_HOME --version

jars=($(ls *.jar 2>/dev/null))
[ ${#jars[@]} -eq 0 ] && echo "No JARs found." && exit 1

echo "Choose a JAR to run:"
for i in "${!jars[@]}"; do echo "$i: ${jars[$i]}"; done

read -p "> " choice
[[ "$choice" =~ ^[0-9]+$ && "$choice" -lt "${#jars[@]}" ]] || { echo "Invalid choice."; exit 1; }

jar="${jars[$choice]}"
echo "Running: $jar"

while true
do
  $JAVA_HOME -Xms$MEMORY -Xmx$MEMORY -Xss512k \
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
  
  echo "----------------------"
  sleep 3
done