#! /bin/bash
# 设定config根目录
config_root=./hadoop/etc/hadoop

# 配置mapred-site.xml
if ! tail ${config_root}/mapred-site.xml | grep -q "mapreduce.reduce.env"; then
	echo "<configuration>
    <property>
        <name>mapreduce.framework.name</name>
        <value>yarn</value>
</property>
<property>
  <name>yarn.app.mapreduce.am.env</name>
  <value>HADOOP_MAPRED_HOME=/root/hadoop</value>
</property>
<property>
  <name>mapreduce.map.env</name>
  <value>HADOOP_MAPRED_HOME=/root/hadoop</value>
</property>
<property>
  <name>mapreduce.reduce.env</name>
  <value>HADOOP_MAPRED_HOME=/root/hadoop</value>
</property>
</configuration>" >> ${config_root}/mapred-site.xml
	echo "mapred-site.xml配置完毕"
fi

# 配置yarn-site.xml文件
if ! tail ${config_root}/yarn-site.xml | grep -q "yarn.nodemanager.resource.memory-mb"; then
	echo "<configuration>

<!-- Site specific YARN configuration properties -->
<property>
        <name>yarn.resourcemanager.hostname</name>
        <value>namenode</value>
    </property>
    <property>
        <name>yarn.nodemanager.aux-services</name>
        <value>mapreduce_shuffle</value>
    </property>
<property>
        <name>yarn.nodemanager.resource.cpu-vcores</name>
        <value>2</value>
</property>
<property>
    <name>yarn.nodemanager.resource.memory-mb</name>
    <value>2048</value>
    <discription>内存,单位MB</discription>
</property>
</configuration>" >> ${config_root}/yarn-site.xml
	echo "yarn-site.xml 配置成功"
fi
