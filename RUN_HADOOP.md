I hope you have installed hadoop in Docker.
See my docker containers :

```
(base)  ✘ jspw@brainFuck  ~/Downloads  docker ps
CONTAINER ID   IMAGE                                                    COMMAND                  CREATED      STATUS                 PORTS                                                                                  NAMES
0a1ead5ce73e   bde2020/hadoop-namenode:2.0.0-hadoop3.2.1-java8          "/entrypoint.sh /run…"   5 days ago   Up 3 hours (healthy)   0.0.0.0:9000->9000/tcp, :::9000->9000/tcp, 0.0.0.0:9870->9870/tcp, :::9870->9870/tcp   namenode
575d36a7db5e   bde2020/hadoop-nodemanager:2.0.0-hadoop3.2.1-java8       "/entrypoint.sh /run…"   5 days ago   Up 3 hours (healthy)   8042/tcp                                                                               nodemanager
be26a557b4c8   bde2020/hadoop-historyserver:2.0.0-hadoop3.2.1-java8     "/entrypoint.sh /run…"   5 days ago   Up 3 hours (healthy)   8188/tcp                                                                               historyserver
6a1309316ac0   bde2020/hadoop-resourcemanager:2.0.0-hadoop3.2.1-java8   "/entrypoint.sh /run…"   5 days ago   Up 3 hours (healthy)   8088/tcp                                                                               resourcemanager
13023c262650   bde2020/hadoop-datanode:2.0.0-hadoop3.2.1-java8          "/entrypoint.sh /run…"   5 days ago   Up 3 hours (healthy)   9864/tcp                                                                               datanode
```

Lets say you have a program that .....

> SalesMapper.java

```java
package SalesCountry;

import java.io.IOException;

import org.apache.hadoop.io.IntWritable;
import org.apache.hadoop.io.LongWritable;
import org.apache.hadoop.io.Text;
import org.apache.hadoop.mapred.*;

public class SalesMapper extends MapReduceBase implements Mapper <LongWritable, Text, Text, IntWritable> {
	private final static IntWritable one = new IntWritable(1);

	public void map(LongWritable key, Text value, OutputCollector <Text, IntWritable> output, Reporter reporter) throws IOException {

		String valueString = value.toString();
		String[] SingleCountryData = valueString.split(",");
		output.collect(new Text(SingleCountryData[7]), one);
	}
}
```

> SalesCountryReducer.java

```java
package SalesCountry;

import java.io.IOException;
import java.util.*;

import org.apache.hadoop.io.IntWritable;
import org.apache.hadoop.io.Text;
import org.apache.hadoop.mapred.*;

public class SalesCountryReducer extends MapReduceBase implements Reducer<Text, IntWritable, Text, IntWritable> {

	public void reduce(Text t_key, Iterator<IntWritable> values, OutputCollector<Text,IntWritable> output, Reporter reporter) throws IOException {
		Text key = t_key;
		int frequencyForCountry = 0;
		while (values.hasNext()) {
			// replace type of value with the actual type of our value
			IntWritable value = (IntWritable) values.next();
			frequencyForCountry += value.get();

		}
		output.collect(key, new IntWritable(frequencyForCountry));
	}
}
```

> SalesCountryDriver.java

```java
package SalesCountry;

import org.apache.hadoop.fs.Path;
import org.apache.hadoop.io.*;
import org.apache.hadoop.mapred.*;

public class SalesCountryDriver {
    public static void main(String[] args) {
        JobClient my_client = new JobClient();
        // Create a configuration object for the job
        JobConf job_conf = new JobConf(SalesCountryDriver.class);

        // Set a name of the Job
        job_conf.setJobName("SalePerCountry");

        // Specify data type of output key and value
        job_conf.setOutputKeyClass(Text.class);
        job_conf.setOutputValueClass(IntWritable.class);

        // Specify names of Mapper and Reducer Class
        job_conf.setMapperClass(SalesCountry.SalesMapper.class);
        job_conf.setReducerClass(SalesCountry.SalesCountryReducer.class);

        // Specify formats of the data type of Input and output
        job_conf.setInputFormat(TextInputFormat.class);
        job_conf.setOutputFormat(TextOutputFormat.class);

        // Set input and output directories using command line arguments,
        //arg[0] = name of input directory on HDFS, and arg[1] =  name of output directory to be created to store the output file.

        FileInputFormat.setInputPaths(job_conf, new Path(args[0]));
        FileOutputFormat.setOutputPath(job_conf, new Path(args[1]));

        my_client.setConf(job_conf);
        try {
            // Run the job
            JobClient.runJob(job_conf);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
```

Make a jar file from these java files :

> Use An IDE (Intelijj ? )

If you are using windows use manual command to make jar file.

Docker container Info : `docker ps`

Open container bash : `docker exec -it container_name/id bash`

add paath :

```
export CLASSPATH="$HADOOP_HOME/share/hadoop/mapreduce/hadoop-mapreduce-client-core-3.2.1.jar:$HADOOP_HOME/share/hadoop/mapreduce/hadoop-mapreduce-client-common-3.2.1.jar:$HADOOP_HOME/share/hadoop/common/hadoop-common-3.2.1.jar:~/MapReduceTutorial/SalesCountry/*:$HADOOP_HOME/lib/*"
```

make class : `javac -d . SalesMapper.java SalesCountryReducer.java SalesCountryDriver.java`

> A Directory `SalesCountry` will be created

Create a `Manifest.txt` file and add text `Main-Class: SalesCountry.SalesCountryDriver`

Build Jar : `jar cfm ProductSalePerCountry.jar Manifest.txt SalesCountry/*.class`

We now have a jar file : `ProductSalePerCountry.jar`

We need to download and copy the `input file` (CSV file) into the docker container : So Open your local machine terminal and run command : `docker cp  localFileLocation containerId:directoryName`

Create a folder named input inside hadoop hdfs (in container terminal) : `hdfs dfs -mkdir input`

    if any error occurred then create `user` and `user/root` before ..
    - `hdfs dfs -mkdir user`
    - `hdfs dfs -mkdir root`

copy input file inside hadoop hdfs : `hdfs dfs -put SalesJan2009.csv ./input `

Run Program : `hadoop jar hadoop.jar input output`

**Note :** Check if input folder has any other files then the csv file and check if output folder already exists.

    - delete folder in hdfs : `hdfs dfs -rm -r output`
    - delete file : `hdfs dfs -rm input/otherfilename`

Check Output : `hdfs dfs -cat output/* `
