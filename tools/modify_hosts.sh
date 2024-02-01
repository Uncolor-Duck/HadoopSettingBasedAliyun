#! /bin/bash

# 负责按照要求，从source文件中读取信息，并修改/etc/hosts的内容

hosts_dir=/etc/hosts

# 读取source的信息
# 读取namenode的hosts
namenode_hosts=$( cat ~/source/config | grep namenode- )
namenode_hosts=${namenode_hosts//namenode-/}

# 读取一共有几个datanode
data_nums=$( cat ~/source/config | grep datanum- )
data_nums=${data_nums//datanum-/}

echo "开始写入/etc/hosts"
# 先写入namenode
if [ $(cat $hosts_dir | grep namenode | wc -l) -eq 0 ]; then
	echo -e "$namenode_hosts\tnamenode" >> ${hosts_dir}
else
	echo "namenode_hosts has been set"
fi

# 根据data_nums来分别读取每个的host
lens=$(grep -n 'TagForDataNode'  ~/source/config)
lens=${lens//:*/}
echo "开始修改datanode"
for (( i=1;i<=$data_nums;i++ ))
do
	contents=$(awk "NR==$((i+${lens}))" ~/source/config)
	if [ $(grep datanode$i /etc/hosts | wc -l) -gt 0 ]; then
		echo "datanode$i has been set in hosts"
		continue
	fi
	echo -e "$contents\tdatanode$i" >> ${hosts_dir}
done


