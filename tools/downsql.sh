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
		tar_subroot=$(ls ${tarsql_root} | grep "mysql")
	        tar -xvf ${tarsql_root}${tar_subroot} -C ${sql_root}
	else
		echo "sql_root没有被创建"
		if ! [ -d ${sql_root%mysql}  ]; then
			mkdir ${sql_root%mysql}
			mkdir $sql_root
		else
			mkdir $sql_root
		fi
		tar_subroot=$(ls ${tarsql_root} | grep "mysql")
                tar -xvf ${tarsql_root}${tar_subroot} -C ${sql_root}
	fi
fi
