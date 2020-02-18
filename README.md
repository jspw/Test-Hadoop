# Test-Hadoop

The **Apache Hadoop** software library is a framework that allows for the distributed processing of large data sets across clusters of computers using simple programming models. It is designed to scale up from single servers to thousands of machines, each offering local computation and storage. Rather than rely on hardware to deliver high-availability, the library itself is designed to detect and handle failures at the application layer, so delivering a highly-available service on top of a cluster of computers, each of which may be prone to failures.



There are two ways to install **Hadoop**, i.e. **Single node** and **Multi node**.

**Single node cluster** means only one DataNode running and setting up all the NameNode, DataNode, ResourceManager and NodeManager on a single machine. This is used for studying and testing purposes. For example, let us consider a sample data set inside a healthcare industry. So, for testing whether the Oozie jobs have scheduled all the processes like collecting, aggregating, storing and processing the data in a proper sequence, we use single node cluster. It can easily and efficiently test the sequential workflow in a smaller environment as compared to large environments which contains terabytes of data distributed across hundreds of machines. 

While in a **Multi node cluster**, there are more than one DataNode running and each DataNode is running on different machines. The multi node cluster is practically used in organizations for analyzing Big Data. Considering the above example, in real time when we deal with petabytes of data, it needs to be distributed across hundreds of machines to be processed. Thus, here we use multi node cluster.

## Install Hadoop: Setting up a Single Node Hadoop Cluster

### Prerequirments :

**Step 0)** 

 - Install java open-jdk-8 :
   - Add repository :  `sudo add-apt-repository ppa:openjdk-r/ppa` 
   - Update : `Sudo apt update`
   - `sudo apt install openjdk-8-jdk` (incase of kali-linux just install jdk)

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

### Main Install Process :

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

    - **mapred-site.xml** (append the given code below) :
    > 
         <configuration>
            <property>
            <name>mapred.job.tracker</name>
            <value>localhost:8021</value>
            </property>
        </configuration>

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

