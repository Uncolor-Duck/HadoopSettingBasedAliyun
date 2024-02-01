#! /bin/bash

# 格式化namenode
## 检测该节点是否是namenode
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

echo $node_name

if [ $node_name = "namenode" ]; then
	./hadoop/bin/hdfs namenode -format
	echo "This is namenode"
else
	echo "This is datanode"
fi


