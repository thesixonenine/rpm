#!/bin/bash
groupadd mysql
useradd -r -g mysql -s /bin/false mysql
yum install -y net-tools
yum install -y libaio
yum install -y numactl
yum install -y perl
cd /usr/local
# wget https://dev.mysql.com/get/Downloads/MySQL-5.7/mysql-community-common-5.7.24-1.el7.x86_64.rpm
# wget https://dev.mysql.com/get/Downloads/MySQL-5.7/mysql-community-libs-5.7.24-1.el7.x86_64.rpm
# wget https://dev.mysql.com/get/Downloads/MySQL-5.7/mysql-community-client-5.7.24-1.el7.x86_64.rpm

wget https://github.com/thesixonenine/rpm/raw/master/mysql-community-common-5.7.24-1.el7.x86_64.rpm
wget https://github.com/thesixonenine/rpm/raw/master/mysql-community-libs-5.7.24-1.el7.x86_64.rpm
wget https://github.com/thesixonenine/rpm/raw/master/mysql-community-client-5.7.24-1.el7.x86_64.rpm

wget https://dev.mysql.com/get/Downloads/MySQL-5.7/mysql-community-server-5.7.24-1.el7.x86_64.rpm

yum remove -y mariadb-*

rpm -ivh mysql-community-common-5.7.24-1.el7.x86_64.rpm
rpm -ivh mysql-community-libs-5.7.24-1.el7.x86_64.rpm
rpm -ivh mysql-community-client-5.7.24-1.el7.x86_64.rpm
rpm -ivh mysql-community-server-5.7.24-1.el7.x86_64.rpm

mysqld --initialize --user=mysql
mysql_ssl_rsa_setup
systemctl start mysqld
# mysqld_safe --user=mysql &
echo "下面试MySQL的临时密码, 请在登录MySQL登录后使用如下语句修改MySQL的密码"
grep 'temporary password' /var/log/mysqld.log
echo "修改root密码的SQL:"
echo "ALTER USER 'root'@'localhost' IDENTIFIED BY '123456';"
echo "修改root权限的SQL:"
echo "GRANT ALL PRIVILEGES ON *.* TO 'root'@'%' IDENTIFIED BY '123456';"
echo "刷新权限的SQL:"
echo "FLUSH PRIVILEGES;"
mysql -uroot -p
