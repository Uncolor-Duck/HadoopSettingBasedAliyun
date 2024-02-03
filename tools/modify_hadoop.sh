#! /bin/bash

root_dir=/root/Hadoop/hadoop/etc/hadoop/hadoop-env.sh

if ! tail $root_dir | grep -q "export YARN_NODEMANAGER_USER"; then
	echo "export HDFS_NAMENODE_USER=root
export HDFS_DATANODE_USER=root
export HDFS_SECONDARYNAMENODE_USER=root
export YARN_RESOURCEMANAGER_USER=root
export YARN_NODEMANAGER_USER=root" >> "$root_dir"
	echo "hadoop-env.sh has been set"
fi
