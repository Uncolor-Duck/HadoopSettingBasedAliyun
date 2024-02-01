#! /bin/bash

#指定根目录
root_dir=./hadoop/etc/hadoop

# 首先安装需要版本的hadoop
if [ ! -d "./hadoop" ]; then 
	wget https://dlcdn.apache.org/hadoop/common/hadoop-3.3.6/hadoop-3.3.6.tar.gz

# 解压压缩包
	hadoop_tar_dir=$( ls | grep "hadoop-3.3.6.tar.gz" )
	tar -zxvf $hadoop_tar_dir

	# 更改名字为需要的名字
	mv "hadoop-3.3.6" "hadoop"
fi
# 修改hadoop_env.sh文件
## 首先获取环境变量，由于新开了bash，所以不能直接访问
java_=$( cat /etc/profile | grep "export JAVA_HOME=" )
java_=${java_//export JAVA_HOME=/}
if ! tail "${root_dir}/hadoop-env.sh" | grep -q "JAVA_HOME"; then
	echo "export JAVA_HOME=$java_" >> "$root_dir/hadoop-env.sh"
	echo "配置hadoop-env成功"
fi

if [ ! -d "/var/hadoop" ]; then
	mkdir -p /var/hadoop
fi

if ! tail "${root_dir}/core-site.xml" | grep -q "fs.defauseFS"; then
	### 这里还需要查询当前节点的名字
	readarray -t all_nodes < <(grep -v "^$" /etc/hosts)
	for(( i=0;i<${#all_nodes[@]}-1;i++ ))
	do
        	i_node=${all_nodes[$i]}
        	read -r i_node_host i_node_name <<< $i_node
        	for(( j=$i;j<${#all_nodes[@]};j++))
        	do
                	j_node=${all_nodes[$j]}
                	read -r j_node_host j_node_name <<< $j_node
                	if [ $i_node_host == $j_node_host ]; then
                        	node_name=$j_node_name
                        	break
               		else
                        	continue
                	fi
        	done
	done



	echo "<configuration>
    <property>
        <name>fs.defaultFS</name>
        <value>hdfs://namenode:9000</value>
    </property>
    <property>
        <name>hadoop.tmp.dir</name>
        <value>/var/hadoop</value>
    </property>
</configuration>" >> "${root_dir}/core-site.xml"
	echo "set core-site success"
fi


if ! tail ${root_dir}/hdfs-site.xml | grep -q "dfs.client.use.datanode.hostname"; then
	echo "<configuration>
<property>
        <name>dfs.namenode.http-address</name>
        <value>namenode:50070</value>
    </property>
    <property>
        <name>dfs.namenode.secondary.http-address</name>
        <value>namenode:50090</value>
    </property>
    <property>
        <name>dfs.replication</name>
        <value>2</value>
    </property>
    <property>
 <name>dfs.client.use.datanode.hostname</name>
 <value>true</value>
 <description>only cofig in clients</description>
</property>
</configuration>" >> "${root_dir}/hdfs-site.xml"
	echo "已经配置hdfs-site"
fi


