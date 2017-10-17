Deploy any shell script as service
==
 
Put all shell script under this folder: ``` /etc/init.d/ ```
```
chkconfig --add servicenam  
chkconfig --list
chkconfig servicenam.sh off / on

```


Samples
--

- tomcat.sh

```
#!/bin/sh
# chkconfig: 2345 99 01
# processname: tomcat
# description:tomcat
./opt/apache-tomcat-7.0.62/bin/startup.sh
        
```

- Multi Service with order

```
#!/bin/sh 
# chkconfig: 2345 99 01 
# processname: ibmWASMB 
# description:start mb mq was 
mount -t cifs //10.2.66.34/IBM296786-2 -o 
username=IBM296786-2,password=Ay5lukL5 /mnt/storage/ 

su - dasusr1 -c "db2admin start"
su - db2inst1 -c "db2start"

su - wbiadmin -c "strmqm QM_ESB" 
su - wbiadmin -c "mqsistart ESB_BROKER" 

/opt/IBM/WebSphere/AppServer/profiles/AppSrv01/bin/startServer.sh server1

service httpd start


```

- Sample

```
#!/bin/sh
# chkconfig: 2345 99 01
# processname: ibmWASMB
# description:start mb mq was
mount -t cifs //10.2.66.34/IBM296786-2 -o username=IBM296786-2,password=Ay5lukL5 /mnt/storage/
su - wbiadmin -c "strmqm QM_ESB"
su - wbiadmin -c "mqsistart ESB_BROKER"

/opt/IBM/WebSphere/AppServer/profiles/Dmgr01/bin/startManager.sh
/opt/IBM/WebSphere/AppServer/profiles/AppSrv01/bin/startNode.sh
/opt/IBM/WebSphere/AppServer/profiles/AppSrv01/bin/startServer.sh server1

service httpd start

```

- DB2 db2primary

```
#!/bin/sh
# chkconfig: 2345 99 01
# processname: db2primary
# description:start db2primary
mount -t cifs //10.2.66.34/IBM296786-2 -o username=IBM296786-2,password=Ay5lukL5 /mnt/storage/
# on palm only
su - db2inst1 -c "db2start"
su - db2inst1 -c "db2 start hadr on db SUGARCRM as primary"
su - db2inst2 -c "db2start"
su - db2inst2 -c "db2 start hadr on db EVECTP as primary"

#on banyanj only
#su - db2inst1 -c "db2 start hadr on db SUGARCRM as standby"
#su - db2inst2 -c "db2 start hadr on db EVECTP as standby"

```

- DB2 db2standby

```
#[root@banyan init.d]# cat db2standby.sh
#!/bin/sh
# chkconfig: 2345 99 01
# processname: db2standby
# description:start db2standby
mount -t cifs //10.2.66.34/IBM296786-2 -o username=IBM296786-2,password=Ay5lukL5 /mnt/storage/
# on palm only
#su - db2inst1 -c "db2 start hadr on db SUGARCRM as primary"
#su - db2inst2 -c "db2 start hadr on db EVECTP as primary"
#on banyan only
su - db2inst1 -c "db2start"
su - db2inst1 -c "db2 start hadr on db SUGARCRM as standby"
su - db2inst2 -c "db2start"
su - db2inst2 -c "db2 start hadr on db EVECTP as standby"

```
  