# Test-Hadoop

## Install Hadoop: Setting up a Single Node Hadoop Cluster
**Step 1)** 
- Install **ssh** : `sudo apt install ssh` <br>
  
**Step 2)**
- Install **rsync** : `sudo apt install rsync`<br>

**Step 3)**

- **ssh** without **passphase** setup : `ssh-keygen -t rsa`<br>

**Step 4)**

- append : `cat ~/.ssh/id_rsa.pub >> ~/.ssh/authorized_keys`<br>

**Step 5)**

- now `ssh localhost` <br>

    - **Issue-1 : `ssh: connect to host localhost port 22: Connection refused` ?**<br>
    
      - Restart ssh :  `service ssh restart` <br>
      - Then run :  `ssh localhost`<br>
  
    - **Issue-2 :  `this could be a permission issue so try`** 
      - `chmod -R 700 ~/.ssh`

<br>

**Step 6)**

  - **Hadoop** download link (stable) :
    [Apache Hadoop](https://archive.apache.org/dist/hadoop/core/)

    **I have installed [Hadoop-3.2.1](https://archive.apache.org/dist/hadoop/core/stable2/hadoop-3.2.1.tar.gz) and i prefer to downlaod this one.**

**Step 7)**

- Extract the file using `tar -xzf Hadoop-3.2.1.tar.gz`

**Step 8)**

- copy the Hadoop-3.2.1 folder to your desired place and rename it hadoop (such as /home/username/hadoop)

**Step 9)**

- edit ``.bashrc`` file [location : ~ (home directory)] and insert (>>) the code given below

    > 
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


    **To get the JAVA_JDK path command : `readlink -f $(which java)`**

**Step 10)**

- Reload by `source ./bashrc`

**Step 11)**

- edit the files in `hadoop/etc/hadoop/` :
    - **core-site.xml** (append the given code below) :
    > 
        <configuration>
            <property>
                <name>fs.defaultFS</name>
                <value>hdfs://localhost:9000</value>
            </property>
        </configuration>

    - **hdfs-site.xml** (append the given code below) :
    >
        <configuration>
            <property>
                 <name>dfs.name.dir</name>
                 <value>file:///home/username/pseudo/dfs/name</value>  <!-- username = use `whoami` command in terminal to know your username in machine  -->
               </property>
               <property>
                 <name>dfs.data.dir</name>
                 <value>file:///home/username/pseudo/dfs/data</value>  <!-- username = use `whoami` command in terminal to know your username in machine  -->
            </property>
            <property>
                <name>dfs.replication</name>
                <value>1</value>
            </property>
        </configuration>

    - **mapred-site.xml** (not necessary for now)
    >


    - ``hadoop-env.sh`` (append the given code below) :
        > 
            export JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64 #JAVA_JDK directory
    
        **To get the JAVA_JDK path run : `readlink -f $(which java)`**

<br>

**After everything done without any error** -> 

<br>

**Step 12)**

- Format Hadoop file system by running the command: `hadoop namenode -format` 

**Step 13)**

- To run hadoop : `$HADOOP_HOME/sbin/start-all.sh`

Now open your browser and go to `http://localhost:50070` you will get your hadoop working ! :D 


Since Hadoop 3.0.0 - Alpha 1 there was a Change in the port configuration:

`http://localhost:50070` was moved to `http://localhost:9870`

- To check the process and port: `jps`

- Stop hadoop : ``$HADOOP_HOME/sbin/stop-all.sh``

- After Machine (PC) started enable hadoop using ``$HADOOP_HOME/sbin/start-all.sh``

