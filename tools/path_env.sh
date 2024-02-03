#! /bin/bash

#对/etc/profile进行修改
## 先获取JAVA的地址
jre_dir=$( ls "/usr/lib/jvm" | grep "jre-[0-9]\+\(\.[0-9]\+\)*-openjdk-[0-9]\+\(\.[0-9]\+\)*" )

## 写入jre地址
if ! grep -q "JAVA_HOME=" "/etc/profile"; then
	echo "export JAVA_HOME=/usr/lib/jvm/${jre_dir}" >> "/etc/profile"
	echo "export PATH=\$PATH:\$JAVA_HOME/bin" >> "/etc/profile"
	echo "export CLASSPATH=.:\$JAVA_HOME/lib/dt.jar:\$JAVA_HOME/lib/tools.jar" >> "/etc/profile"
fi
## 获取Hadoop地址，默认安装在./hadoop
hadoop_dir="/root/Hadoop/hadoop"
if ! grep -q "HADOOP_HOME=" "/etc/profile"; then
	echo "export HADOOP_HOME=${hadoop_dir}" >> "/etc/profile"
	echo "export PATH=\$HADOOP_HOME/bin:\$HADOOP_HOME/sbin:\$PATH"
fi

# 激活环境变量的改变
source /etc/profile

