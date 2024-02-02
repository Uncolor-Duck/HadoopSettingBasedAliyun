#! /bin/bash

# 此文件用于生成密钥并将密钥分发给其他节点
# 读取Source中的所有节点并将自身节点替换为localhost

source_dir=~/source/config

echo "正在生成密钥"

# 生成本机密钥
ssh-keygen

# 将生成的密钥传输给自己
ssh-copy-id localhost

# 先同步给namenode
ssh-copy-id namenode

# 从source中获取到当前的节点数量
node_num=$( cat $source_dir | grep "datanum-")
node_num=${node_num//datanum-/}
for(( i=1;i<${node_num}+1;i++ ))
do
	node_name=datanode$i
	ssh-copy-id $node_name
done


