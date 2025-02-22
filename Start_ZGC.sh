#!/bin/bash
MEMORY="8G"

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
  ../Runtime/bin/java \
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

  echo "----------------------"
  sleep 3
done
