#for hadoop

        export JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64 #JAVA_JDK directory
        
        export HADOOP_HOME=/home/username/hadoop #location of your hadoop file directory

        export HADOOP_MAPRED_HOME=$HADOOP_HOME
        export HADOOP_CONF_DIR=$HADOOP_HOME/etc/hadoop
        export HADOOP_COMMON_HOME=$HADOOP_HOME
        export HADOOP_HDFS=$HADOOP_HOME
        export YARN_HOME=$HADOOP_HOME
        export HADOOP_USER_CLASSPATH_FIRST=true

        alias hadoop=$HADOOP_HOME/bin/./hadoop #for convenience
        alias hdfs=$HADOOP_HOME/bin/./hdfs #for convenience

        #done
