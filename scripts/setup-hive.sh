#!/bin/bash
source "/vagrant/scripts/common.sh"

function installLocalHive {
	echo "install hive from local file"
	FILE=/vagrant/resources/$HIVE_ARCHIVE
	tar -xzf $FILE -C /usr/local
}

function installRemoteHive {
	echo "install hive from remote file"
	curl -o /vagrant/resources/$HIVE_ARCHIVE -O -L $HIVE_MIRROR_DOWNLOAD
	tar -xzf /vagrant/resources/$HIVE_ARCHIVE -C /usr/local
}

function setupHive {
	echo "setup hive"
	cp -f /vagrant/resources/hive/mysql-connector-java-5.1.26-bin.jar /usr/local/hive/lib
	cp -f /vagrant/resources/hive/hive-site.xml /usr/local/hive/conf
}

function setupEnvVars {
	echo "creating hive environment variables"
	cp -f $HIVE_RES_DIR/hive.sh /etc/profile.d/hive.sh
}

function installHive {
	if resourceExists $HIVE_ARCHIVE; then
		installLocalHive
	else
		installRemoteHive
	fi
	ln -s /usr/local/$HIVE_VERSION /usr/local/hive
}

echo "setup hive"

installHive
setupHive
setupEnvVars
