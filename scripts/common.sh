#!/bin/bash

#java
JAVA_ARCHIVE=jdk-8u45-linux-x64.tar.gz
#hadoop
HADOOP_PREFIX=/usr/local/hadoop
HADOOP_CONF=$HADOOP_PREFIX/etc/hadoop
HADOOP_VERSION=hadoop-2.6.0
HADOOP_ARCHIVE=$HADOOP_VERSION.tar.gz
HADOOP_MIRROR_DOWNLOAD=http://apache.claz.org/hadoop/common/hadoop-2.6.0/hadoop-2.6.0.tar.gz
HADOOP_RES_DIR=/vagrant/resources/hadoop
#spark
SPARK_VERSION=spark-1.4.0
SPARK_ARCHIVE=$SPARK_VERSION-bin-hadoop2.tgz
SPARK_MIRROR_DOWNLOAD=http://d3kbcqa49mib13.cloudfront.net/spark-1.4.0-bin-hadoop2.6.tgz
SPARK_RES_DIR=/vagrant/resources/spark
SPARK_CONF_DIR=/usr/local/spark/conf

#Pig
PIG_VERSION=pig-0.15.0
PIG_ARCHIVE=$PIG_VERSION.tar.gz
PIG_MIRROR_DOWNLOAD=http://mirror.olnevhost.net/pub/apache/pig/pig-0.15.0/pig-0.15.0.tar.gz
PIG_RES_DIR=/vagrant/resources/pig
PIG_CONF_DIR=/usr/local/pig/conf

#HIVE
HIVE_VERSION=apache-hive-1.2.1-bin
HIVE_ARCHIVE=$HIVE_VERSION.tar.gz
HIVE_MIRROR_DOWNLOAD=http://mirror.tcpdiag.net/apache/hive/stable/apache-hive-1.2.1-bin.tar.gz
HIVE_RES_DIR=/vagrant/resources/hive
HIVE_CONF_DIR=/usr/local/hive/conf

#ssh
SSH_RES_DIR=/vagrant/resources/ssh
RES_SSH_COPYID_ORIGINAL=$SSH_RES_DIR/ssh-copy-id.original
RES_SSH_COPYID_MODIFIED=$SSH_RES_DIR/ssh-copy-id.modified
RES_SSH_CONFIG=$SSH_RES_DIR/config

function resourceExists {
	FILE=/vagrant/resources/$1
	if [ -e $FILE ]
	then
		return 0
	else
		return 1
	fi
}

function fileExists {
	FILE=$1
	if [ -e $FILE ]
	then
		return 0
	else
		return 1
	fi
}

#echo "common loaded"
