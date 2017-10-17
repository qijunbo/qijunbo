Deploy any shell script as service
==
 
Put all shell script under this folder: ``` /etc/init.d/ ```
```
chkconfig --add servicenam  
chkconfig --list
chkconfig servicenam.sh off / on

```
 
<table>
	<tr>
		<th>Server</th>
		<th>Service in chkconfig list</th>
	</tr>
	<tr  >
		<td> Tomcat </td>
		<td>
		tomcat.sh
		<pre>
#!/bin/sh
# chkconfig: 2345 99 01
# processname: tomcat
# description:tomcat
./opt/apache-tomcat-7.0.62/bin/startup.sh
		</pre></td>
	</tr>
	<tr  >
		<td><b><i>oak</i></b></td>
		<td>
		<pre>
#!/bin/sh 
# chkconfig: 2345 99 01 
# processname: ibmWASMB 
# description:start mb mq was 
mount -t cifs //10.2.66.34/IBM296786-2 -o 
username=IBM296786-2,password=Ay5lukL5 /mnt/storage/ 

su - dasusr1 -c "db2admin start"
su - db2inst1 -c "db2start"

su - wbiadmin -c &quot;strmqm QM_ESB&quot; 
su - wbiadmin -c &quot;mqsistart ESB_BROKER&quot; 
		</pre>
		/opt/IBM/WebSphere/AppServer/profiles/AppSrv01/bin/startServer.sh 
		server1<br>
		<br>
		service httpd start</td>
	</tr>
	
		<tr  >
		<td><b><i>spruce</i></b></td>
		<td>#!/bin/sh<br>
		# chkconfig: 2345 99 01<br>
		# processname: ibmWASMB<br>
		# description:start mb mq was<br>
		mount -t cifs //10.2.66.34/IBM296786-2 -o 
		username=IBM296786-2,password=Ay5lukL5 /mnt/storage/<br>
		su - wbiadmin -c &quot;strmqm QM_ESB&quot;<br>
		su - wbiadmin -c &quot;mqsistart ESB_BROKER&quot;<br>
		<br>
		/opt/IBM/WebSphere/AppServer/profiles/Dmgr01/bin/startManager.sh<br>
		/opt/IBM/WebSphere/AppServer/profiles/AppSrv01/bin/startNode.sh<br>
		/opt/IBM/WebSphere/AppServer/profiles/AppSrv01/bin/startServer.sh 
		server1<br>
		<br>
		service httpd start</td>
	</tr>
	
	<tr  >
		<td><b><i>SugarCRM A</i></b></td>
		<td>#!/bin/sh<br>
		# chkconfig: 2345 99 01<br>
		# processname: ibmWASMB<br>
		# description:start mb mq was<br>
		mount -t cifs //10.2.66.34/IBM296786-2 -o 
		username=IBM296786-2,password=Ay5lukL5 /mnt/storage/<br>
		su - wbiadmin -c &quot;strmqm QM_ESB&quot;<br>
		su - wbiadmin -c &quot;mqsistart ESB_BROKER&quot;<br>
		<br>
		/opt/IBM/WebSphere/AppServer/profiles/Dmgr01/bin/startManager.sh<br>
		/opt/IBM/WebSphere/AppServer/profiles/AppSrv01/bin/startNode.sh<br>
		/opt/IBM/WebSphere/AppServer/profiles/AppSrv01/bin/startServer.sh 
		server1<br>
		<br>
		service httpd start</td>
	</tr>
	<tr  >
		<td><b><i>SugarCRM B</i></b></td>
		<td>#!/bin/sh<br>
		# chkconfig: 2345 99 01<br>
		# processname: ibmWASMB<br>
		# description:start mb mq was<br>
		mount -t cifs //10.2.66.34/IBM296786-2 -o 
		username=IBM296786-2,password=Ay5lukL5 /mnt/storage/<br>
		su - wbiadmin -c &quot;strmqm QM_ESB&quot;<br>
		su - wbiadmin -c &quot;mqsistart ESB_BROKER&quot;<br>
		<br>
		/opt/IBM/WebSphere/AppServer/profiles/Dmgr01/bin/startManager.sh<br>
		/opt/IBM/WebSphere/AppServer/profiles/AppSrv01/bin/startNode.sh<br>
		/opt/IBM/WebSphere/AppServer/profiles/AppSrv01/bin/startServer.sh 
		server1<br>
		<br>
		service httpd start</td>
	</tr>
	<tr  >
		<td><b><font color="#C83030">Driver Portal A</font></b></td>
		<td>#!/bin/sh<br>
		# chkconfig: 2345 99 01<br>
		# processname: ibmWASMB<br>
		# description:start mb mq was<br>
		mount -t cifs //10.2.66.34/IBM296786-2 -o 
		username=IBM296786-2,password=Ay5lukL5 /mnt/storage/<br>
		su - wbiadmin -c &quot;strmqm QM_ESB&quot;<br>
		su - wbiadmin -c &quot;mqsistart ESB_BROKER&quot;<br>
		<br>
		/opt/IBM/WebSphere/AppServer/profiles/Dmgr01/bin/startManager.sh<br>
		/opt/IBM/WebSphere/AppServer/profiles/AppSrv01/bin/startNode.sh<br>
		/opt/IBM/WebSphere/AppServer/profiles/AppSrv01/bin/startServer.sh 
		server1<br>
		<br>
		service httpd start</td>
	</tr>
	<tr  >
		<td><b><font color="#00CC00">CTP A</font></b></td>
		<td>#!/bin/sh<br>
		# chkconfig: 2345 99 01<br>
		# processname: ibmWASMB<br>
		# description:start mb mq was<br>
		mount -t cifs //10.2.66.34/IBM296786-2 -o 
		username=IBM296786-2,password=Ay5lukL5 /mnt/storage/<br>
		su - wbiadmin -c &quot;strmqm QM_ESB&quot;<br>
		su - wbiadmin -c &quot;mqsistart ESB_BROKER&quot;<br>
		<br>
		/opt/IBM/WebSphere/AppServer/profiles/Dmgr01/bin/startManager.sh<br>
		/opt/IBM/WebSphere/AppServer/profiles/AppSrv01/bin/startNode.sh<br>
		/opt/IBM/WebSphere/AppServer/profiles/AppSrv01/bin/startServer.sh 
		server1<br>
		<br>
		service httpd start</td>
	</tr>
	<tr  >
		<td><b>HADR,DB2 A</b></td>
		<td><b><font color="#FF0000">#[root@palm init.d]# cat db2primary.sh<br>
		</font></b><br>
		#!/bin/sh<br>
		# chkconfig: 2345 99 01<br>
		# processname: db2primary<br>
		# description:start db2primary<br>
		mount -t cifs //10.2.66.34/IBM296786-2 -o 
		username=IBM296786-2,password=Ay5lukL5 /mnt/storage/<br>
		# on palm only<br>
		su - db2inst1 -c &quot;db2start&quot;<br>
		su - db2inst1 -c &quot;db2 start hadr on db SUGARCRM as primary&quot;<br>
		su - db2inst2 -c &quot;db2start&quot;<br>
		su - db2inst2 -c &quot;db2 start hadr on db EVECTP as primary&quot;<br>
		<br>
		#on banyanj only<br>
		#su - db2inst1 -c &quot;db2 start hadr on db SUGARCRM as standby&quot;<br>
		#su - db2inst2 -c &quot;db2 start hadr on db EVECTP as standby&quot;</td>
	</tr>
	<tr  >
		<td><b>HADR,DB2 B</b></td>
		<td><b><font color="#FF0000">#[root@banyan init.d]# cat db2standby.sh</font></b><p>
		#!/bin/sh<br>
		# chkconfig: 2345 99 01<br>
		# processname: db2standby<br>
		# description:start db2standby<br>
		mount -t cifs //10.2.66.34/IBM296786-2 -o 
		username=IBM296786-2,password=Ay5lukL5 /mnt/storage/<br>
		# on palm only<br>
		#su - db2inst1 -c &quot;db2 start hadr on db SUGARCRM as primary&quot;<br>
		#su - db2inst2 -c &quot;db2 start hadr on db EVECTP as primary&quot;<br>
		#on banyan only<br>
		su - db2inst1 -c &quot;db2start&quot;<br>
		su - db2inst1 -c &quot;db2 start hadr on db SUGARCRM as standby&quot;<br>
		su - db2inst2 -c &quot;db2start&quot;<br>
		su - db2inst2 -c &quot;db2 start hadr on db EVECTP as standby&quot;</td>
	</tr>
</table>