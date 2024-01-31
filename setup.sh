#! /bin/bash

# 输入参数
## $1 指定当前节点的名字 
# 修改/etc/sysconfig/network
bash ./tools/modify_network.sh $1

# 安装jdk并符合版本
bash ./tools/java_set.sh

# 配置/etc/hosts
bash ./tools/modify_hosts.sh

# 生成对应的密钥并分发到其他节点
bash ./tools/keygen.sh

# JAVA与Hadoop环境变量的配置
bash ./tools/path_env.sh

# Hadoop安装
bash ./tools/HadoopDownLoad.sh
