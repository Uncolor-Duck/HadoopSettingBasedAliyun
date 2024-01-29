#! /bin/bash

jdk_version=java-1.8.0-openjdk-1.8.0.312.b07-2.el8_5.x86_64
echo "正在安装${jdk_version}版本的jre"

yum install ${jdk_version}
