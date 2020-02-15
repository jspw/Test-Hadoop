# Test-Hadoop-

install ssh `sudo apt install ssh` <br>
install rsync `apt install rsync`<br>
ssh without passphase setup : `ssh-keygen -t rsa`<br>
append : `cat ~/.ssh/id_rsa.pub >> ~/.ssh/authorized_keys`<br>
now `ssh localhost` <br>

**if yet any error says "ssh: connect to host localhost port 22: Connection refused" ?**
restart ssh and again try to open localhost `service ssh restart` then `ssh localhost`
or use this could be a permission issue so try `chmod -R 700 ~/.ssh`
hadoop download link (stabl) :`https://archive.apache.org/dist/hadoop/core/stable2/hadoop-3.2.1.tar.gz`
