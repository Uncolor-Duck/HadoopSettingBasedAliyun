#! /bin/bash
# coding=utf-8
# 输入参数为1
## $1 为节点的名字

echo "正在修改network文件"
modify_network_dir=/etc/sysconfig/network
if [ "$(cat /etc/sysconfig/network | grep NETWORKING | wc -l)" -eq 0 ]; then
	new_line="NETWORKING=yes"
	echo -e "$new_line" >> ${modify_network_dir}
else
	echo "NETWORKING has been set"

fi
if [ "$(cat /etc/sysconfig/network | grep HOSTNAME | wc -l)" -eq 0 ]; then
	new_line="HOSTNAME=$1"
	echo -e "$new_line" >> ${modify_network_dir}
else
	echo "HOSTNAME has been set"

fi

