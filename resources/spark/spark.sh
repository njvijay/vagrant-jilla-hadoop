export SPARK_HOME=/usr/local/spark
export PATH=${SPARK_HOME}/bin:${SPARK_HOME}/sbin:${PATH}
export CLASSPATH="$CLASSPATH:/usr/local/hive/lib/mysql-connector-java-5.1.26-bin.jar"
export SPARK_CLASSPATH=$CLASSPATH
export SPARK_SUBMIT_CLASSPATH=$CLASSPATH
