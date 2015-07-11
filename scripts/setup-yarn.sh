#!/bin/bash
source "/vagrant/scripts/common.sh"

$HADOOP_YARN_HOME/sbin/yarn-daemon.sh --config $HADOOP_CONF_DIR start resourcemanager
$HADOOP_YARN_HOME/sbin/yarn-daemons.sh --config $HADOOP_CONF_DIR start nodemanager
$HADOOP_YARN_HOME/sbin/yarn-daemon.sh start proxyserver --config $HADOOP_CONF_DIR
$HADOOP_PREFIX/sbin/mr-jobhistory-daemon.sh start historyserver --config $HADOOP_CONF_DIR
