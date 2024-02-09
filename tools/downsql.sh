#! /bin/bash

#初始化默认环境地址
tarsql_root=/root/source/Package/
sql_root=/root/platform/mysql

#检查tar文件是否下载，如果没有，则报错
if ! ls $tarsql_root | grep -q "mysql"; then
	echo "你没有下载tar文件，安装失败"
	exit 1
else
	## Check the sql_root whether is existed
	if [ -d ${sql_root} ]; then
		if ! ls $sql_root | grep ""; then
			tar_subroot=$(ls ${tarsql_root} | grep "mysql")
	        	tar -xvf ${tarsql_root}${tar_subroot} -C ${sql_root}
		fi
	else
		echo "sql_root没有被创建"
		if ! [ -d ${sql_root%mysql}  ]; then
			mkdir ${sql_root%mysql}
			mkdir $sql_root
		else
			mkdir $sql_root
		fi
		if ! ls $sql_root | grep ""; then
			tar_subroot=$(ls ${tarsql_root} | grep "mysql")
                	tar -xvf ${tarsql_root}${tar_subroot} -C ${sql_root}
		fi
	fi
fi

#安装必要的依赖
yum -y install libaio
yum -y install libncurses*
yum -y install perl perl-devel

#安装必要的yum包
rpm -ivh ${sql_root}/mysql-community-common-8.3.0-1.el8.x86_64.rpm
rpm -ivh ${sql_root}/mysql-community-client-plugins-8.3.0-1.el8.x86_64.rpm
rpm -ivh ${sql_root}/mysql-community-libs-8.3.0-1.el8.x86_64.rpm
rpm -ivh ${sql_root}/mysql-community-client-8.3.0-1.el8.x86_64.rpm
rpm -ivh ${sql_root}/mysql-community-icu-data-files-8.3.0-1.el8.x86_64.rpm
rpm -ivh ${sql_root}/mysql-community-server-8.3.0-1.el8.x86_64.rpm


#启动mysql
systemctl start mysqld.service

#寻找初始密码
password_init=$(cat /var/log/mysqld.log | grep password | awk -F': ' '{print $2}')

#启动sql
systemctl start mysqld

#设置开机自启并检查
systemctl enable mysqld
systemctl list-unit-files | grep mysqld
