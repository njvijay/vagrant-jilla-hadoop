#!/bin/bash
source "/vagrant/scripts/common.sh"

$HADOOP_PREFIX/bin/hdfs namenode -format myhadoop
$HADOOP_PREFIX/sbin/hadoop-daemon.sh --config $HADOOP_CONF_DIR --script hdfs start namenode
$HADOOP_PREFIX/sbin/hadoop-daemons.sh --config $HADOOP_CONF_DIR --script hdfs start datanode
#Run yarn daemons in node2
ssh node2 bash /vagrant/scripts/setup-yarn.sh
