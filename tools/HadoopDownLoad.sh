#! /bin/bash

#指定根目录
root_dir=./hadoop/etc/config

# 首先安装需要版本的hadoop
if ! grep -q "hadoop" "./"; then 
	wget https://dlcdn.apache.org/hadoop/common/hadoop-3.3.6/hadoop-3.3.6.tar.gz

# 解压压缩包
	hadoop_tar_dir=$( ls | grep "hadoop-3.3.6.tar.gz" )
	tar -zxvf $hadoop_tar_dir

	# 更改名字为需要的名字
	mv "hadoop-3.3.6" "hadoop"
fi
# 修改hadoop_env.sh文件


