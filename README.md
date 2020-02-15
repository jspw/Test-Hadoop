# Test-Hadoop-

- Install **ssh** `sudo apt install ssh` <br>

- Install **rsync** `apt install rsync`<br>

- **ssh** without **passphase** setup : `ssh-keygen -t rsa`<br>

- append : `cat ~/.ssh/id_rsa.pub >> ~/.ssh/authorized_keys`<br>

- now `ssh localhost` <br>

    **if yet any error says "ssh: connect to host localhost port 22: Connection refused" ?**<br>
    restart ssh and again try to open localhost <br>
    - `service ssh restart`
    - `ssh localhost`
    **or use this could be a permission issue so try** 
    - `chmod -R 700 ~/.ssh`

<br><br>

hadoop download link (stabl) :`https://archive.apache.org/dist/hadoop/core/stable2/hadoop-3.2.1.tar.gz` <br>

- extract the file using `tar -xzf filename.tar.gz`
- copy the hadoopx.x.x folder to your desired place
- edit .bashrc file (copy paste the code below) which is located in your home directory

> 
    #for hadoop

    export JAVA_HOME=/usr/lib/jvm/java-11-openjdk-amd64
    
    export HADOOP_HOME=/media/jspw/EA70D14D70D1215D/Users/JackSparrow/Documents/Big-Data/hadoop #location where you extract the tar.gz file
    
    export HADOOP_PREFIX=$HADOOP_HOME
    
    export HADOOP_MAPRED_HOME=$HADOOP_HOME
    export HADOOP_CONF_DIR=$HADOOP_HOME/etc/hadoop
    export HADOOP_COMMON_HOME=$HADOOP_HOME
    export HADOOP_HDFS=$HADOOP_HOME
    export YARN_HOME=$HADOOP_HOME
    export HADOOP_USER_CLASSPATH_FIRST=true

    alias hadoop=$HADOOP_HOME/bin/./hadoop #for convenience
    alias hdfs=$HADOOP_HOME/bin/./hdfs #for convenience

    #done

- Reload by `source ./bashrc`

- edit the xml files in `/etc/hadoop/` :
    - core-site.xml
    > 
        <configuration>
            <property>
                <name>fs.defaultFS</name>
                <value>hdfs://localhost:9000</value>
            </property>
        </configuration>

    - hdfs-site.xml
    >
        <configuration>
            <property>
                <name>dfs.replication</name>
                <value>1</value>
            </property>
        </configuration>

    - mapred-site.xml (not necessary)
    >


- edit hadoop-env.sh file :
    > 
        export JAVA_HOME= java-jdk folder
    
    to get the JAVA_HOME path `readlink -f $(which java)`

After everything done without any error ,
<br>
- Format Hadoop file system by running the command: `hadoop namenode -format` 

- To run hadoop : `$HADOOP_HOME/sbin/start-all.sh`

Now open your browser and go to `http://localhost:50070` you will get your hadoop working ! :D 


Since Hadoop 3.0.0 - Alpha 1 there was a Change in the port configuration:

`http://localhost:50070` was moved to `http://localhost:9870`

- To check the process and port: `jps`

