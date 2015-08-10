vagrant-hadoop-2.6.0 with Spark 1.4.1 and Hive,Pig clients
==========================================================

Introduction
============

Vagrant project to spin up a cluster of 5 virtual machines with Hadoop v2.6.0, Spark 1.4.1 and apache hive and pig clients in data nodes

1.	node1 : HDFS NameNode + Spark Master
2.	node2 : HDFS Data Node + YARN ResourceManager + JobHistoryServer + ProxyServer + Spark slave
3.	node3 : HDFS DataNode + YARN NodeManager + Spark Slave
4.	node4 : HDFS DataNode + YARN NodeManager + Spark slave
5.	node5 : HDFS DataNode + YARN NodeManager + Spark Slave

Getting Started
===============

1.	[Download and install VirtualBox](https://www.virtualbox.org/wiki/Downloads)
2.	[Download and install Vagrant](http://www.vagrantup.com/downloads.html).
3.	Run `vagrant box add centos65 https://github.com/2creatives/vagrant-centos/releases/download/v6.5.1/centos65-x86_64-20131205.box`
4.	Git clone this project, and change directory (cd) into this project (directory).
5.	Run `vagrant up` to create the VM.
6.	Run `vagrant ssh` to get into your VM.
7.	Run `vagrant destroy` when you want to destroy and get rid of the VM.

Some gotcha's.

1.	Make sure you download Vagrant v1.4.3 or higher.
2.	Make sure when you clone this project, you preserve the Unix/OSX end-of-line (EOL) characters. The scripts will fail with Windows EOL characters.
3.	Make sure you have 10Gb of free memory for the VM. You may change the Vagrantfile to specify smaller memory requirements.
4.	This project has NOT been tested with the VMWare provider for Vagrant.
5.	You may change the script (common.sh) to point to a different location for Hadoop , pig and hive to be downloaded from. Here is a list of mirrors for Hadoop: http://www.apache.org/dyn/closer.cgi/hadoop/common/.

Advanced Stuff
==============

If you have the resources (CPU + Disk Space + Memory), you may modify Vagrantfile to have even more HDFS DataNodes, YARN NodeManagers, and Spark slaves. Just find the line that says "numNodes = 5" in Vagrantfile and increase that number. The scripts should dynamically provision the additional slaves for you.

Make the VMs setup faster
=========================

You can make the VM setup even faster if you pre-download the Hadoop, spark, pig, hive into the /resources directory. Please make sure version matches according to common.sh

The setup script will automatically detect if these files (with precisely the same names) exist and use them instead. If you are using slightly different versions, you will have to modify the script accordingly.

Post Provisioning
=================

You don't need to do any post provisioning. This vagrant setup performs following steps

-	Name node formating
-	Starts name node daemon on node1
-	Starts data nodes from node2
-	Starts yarn daemons(resource manager, node manager, proxy server, history server) on node2
-	Starts spark master and spark salves

### Test YARN

Run the following command to make sure you can run a MapReduce job.

```
yarn jar /usr/local/hadoop/share/hadoop/mapreduce/hadoop-mapreduce-examples-2.6.0.jar pi 2 100
```

### Test Spark

You can test if spark run on YARN by issuing following command

```
$SPARK_HOME/bin/spark-submit --class org.apache.spark.examples.SparkPi \
    --master yarn \
    --num-executors 10 \
    --executor-cores 2 \
    $SPARK_HOME/lib/spark-examples*.jar \
    100
```

Also, you can test code directly on Spark.

```
$SPARK_HOME/bin/spark-submit --class org.apache.spark.examples.SparkPi \
    --master spark://node1:7077 \
    --num-executors 5 \
    --executor-cores 1 \
    $SPARK_HOME/lib/spark-examples*.jar \
    100
```

I have set 'executor-cores' = 1. It is going to occupy total 4 cores one from each executors. You can adjust executor-cores according to your machine configuration. Also, make sure you don't over setup these values. Otherwise, you hit with following issue

```
WARN TaskSchedulerImpl: Initial job has not accepted any resources; check your cluster ui
to ensure that workers are registered and have sufficient memory
```

Here is the quick guide to troubleshoot your spark setup

[http://www.datastax.com/dev/blog/common-spark-troubleshooting](http://www.datastax.com/dev/blog/common-spark-troubleshooting)

### Test Spark using Shell

Start the Spark shell using the following command.

```
$SPARK_HOME/bin/spark-shell --master spark://node1:7077
```

Run following piece of code in the spark shell to make sure everything works as expected.

```
sc.parallelize(1 until 10000).count
sc.parallelize(1 until 10000).map( x => (x%30,x)).groupByKey().count
```

### Test Spark SQL using Shell

This vagrant setup is linked with hive metastore. Vagrant setup takes care of copying hive-site.xml into spark conf dir. It provides an opportunity to work with Spark sql and hive seamlessly. CLASSPATH includes mysql jdbc jar file and classpath is exported via spark/spark.sh.

To test the interoperability between hive and spark sql, first bring up hive prompt and create 'test' table with few inserts

```
create table test (i int);
insert into test values (10);
insert into test values (33);

```

Then, open up spark shell as mentioned above. Spark shell exports sqlContext by default. Just run the following commands in spark-shell to make sure everything works as expected.

```
sqlContext.sql("show databases").collect().foreach(println);
sqlContext.sql("show tables").collect().foreach(println);
sqlContext.sql("select * from test").collect().foreach(println);
```

Apache Pig and Hive
-------------------

Apache pig and hive setup is available in all the data nodes. Basically data nodes start from node2

Web UI
======

You can check the following URLs to monitor the Hadoop daemons.

1.	[NameNode](http://10.211.55.101:50070/dfshealth.html)
2.	[ResourceManager](http://10.211.55.102:8088/cluster)
3.	[JobHistory](http://10.211.55.102:19888/jobhistory)
4.	[Spark](http://10.211.55.101:8080)

Vagrant boxes
=============

A list of available Vagrant boxes is shown at [https://atlas.hashicorp.com/boxes/search](https://atlas.hashicorp.com/boxes/search)

Vagrant box location
====================

The Vagrant box is downloaded to the ~/.vagrant.d/boxes directory. On Windows, this is C:/Users/{your-username}/.vagrant.d/boxes.

References
==========

This project was kludge together with great pointers from all around the internet. All references made inside the files themselves. Special thanks to [vangj](https://github.com/vangj/vagrant-hadoop-2.4.1-spark-1.0.1) from where I cloned this project for further development.

Copyright Stuff
===============

Licensed under the Apache License, Version 2.0 (the "License"); you may not use this file except in compliance with the License. You may obtain a copy of the License at

```
http://www.apache.org/licenses/LICENSE-2.0
```

Unless required by applicable law or agreed to in writing, software distributed under the License is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. See the License for the specific language governing permissions and limitations under the License.
