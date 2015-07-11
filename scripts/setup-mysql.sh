#!/bin/bash
source "/vagrant/scripts/common.sh"

set -x
echo I am provisioning mysql...
yum install mysql-server -y

/sbin/service mysqld start
mysql -e "create user 'hiveuser'@'%' identified by 'hive'"
mysql -e "GRANT ALL ON *.* TO 'hiveuser'@'%' identified by 'hive'"
echo "bind-address=0.0.0.0" >> /etc/my.cnf
