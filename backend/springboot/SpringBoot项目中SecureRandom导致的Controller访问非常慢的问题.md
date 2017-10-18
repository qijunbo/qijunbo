Reference:
--
http://note.youdao.com/share/?id=7d252c7b3d3a446d2bab99b1c9905209&type=note#/

#### 引子
使用springboot开发一个部署在阿里云上的项目的时候，用controller+freemarker实现了一个伪js，用于静态页面同步获取服务器上下文、当前登录用户等信息使用，结果发现因为这个伪js导致页面第一次加载十分缓慢。

跟踪后发现不仅是该伪js，是对所有的controller的第一次访问会非常的慢，之后的短时间内又会很正常，仔细跟踪日志发现访问慢的那一次请求中会出现类似如下这样的一段或多段日志：

```
2017-10-17 14:12:03.971 [http-nio-8086-exec-2] INFO  o.a.c.u.SessionIdGeneratorBase.log<179>:
Creation of SecureRandom instance for session ID generation using [SHA1PRNG] took [61,115] milliseconds.
```
重点就在这个时间，重复测试发现这个时间甚至可以长至5~6分钟，最短也要1分多钟，

以“SecureRandom”等关键字求助搜索引擎，终于找到了巨慢的罪魁祸首。

#### 原因：
StackOverflow上[Dan Dyer](https://stackoverflow.com/users/5171/dan-dyer)的回答原文：
> On Linux, the default implementation for `SecureRandom` is `NativePRNG` (source code [here](http://www.java2s.com/Open-Source/Java/6.0-JDK-Platform/solaris/sun/security/provider/NativePRNG.java.htm)), which tends to be very slow. On Windows, the default is `SHA1PRNG`, which as others pointed out you can also use on Linux if you specify it explicitly.
> 
> `NativePRNG` differs from `SHA1PRNG` and Uncommons Maths' [AESCounterRNG](http://maths.uncommons.org/api/org/uncommons/maths/random/AESCounterRNG.html) in that it continuously receives entropy from the operating system (by reading from `/dev/urandom`). The other PRNGs do not acquire any additional entropy after seeding.
> 
> `AESCounterRNG` is about 10x faster than `SHA1PRNG`, which IIRC is itself two or three times faster than `NativePRNG`.
> 
> If you need a faster PRNG that acquires entropy after initialization, see if you can find a Java implementation of Fortuna. The core PRNG of a Fortuna implementation is identical to that used by AESCounterRNG, but there is also a sophisticated system of entropy pooling and automatic reseeding.

大意如下：
> linux默认的`SecureRandom`实现方式是非常慢的`NativePRNG`，而在Windows上的默认实现是`SHA1PRNG`，正如其他人所说，你也可以在Linux上指定使用该方式。
> 
> ……`NativePRNG`会不断从操作系统获取熵（从`/dev/urandom`读取），其它PRNG则不会获取这些额外的熵。
> 
> `AESCounterRNG`差不多比`SHA1PRNG`快的十倍，而如果我没记错，`SHA1PRNG`比`NativePRNG`快两到三倍

结合其它资料，终于弄明白了，SecureRandom是java用来获取高级随机数的实现，++而巨慢则是由在linux上默认使用的实现方式导致的++。

#### 解决：

Linux上Jre中默认SecureRandom读取熵时会从`/dev/urandom`中读取，而从这里读取熵是**阻塞**的，下面是已知的两种解决方式。

**方法一**，修改jre配置文件（该方式本人实测成功）：
> 以linux用yum安装的jre为例，打开`/usr/lib/jvm/jre/lib/security/java.security`，
> 
> 找到`securerandom.source=file:/dev/random`这一行，
> 
> 将`file:/dev/random`（阻塞熵源）修改为`file:/dev/./urandom`（非阻塞熵源）

**方法二**，为JVM增加如下启动参数（该方式本人未亲自测试）：
```
-Djava.security.egd=file:/dev/./urandom
```

##### Thanks To: [How to solve slow Java `SecureRandom`? - StackOverflow](https://stackoverflow.com/questions/137212/how-to-solve-slow-java-securerandom)

---
另附本项目环境如下：
```
Linux version 3.10.0-514.26.2.el7.x86_64 (builder@kbuilder.dev.centos.org) (gcc version 4.8.5 20150623 (Red Hat 4.8.5-11) (GCC) ) #1 SMP Tue Jul 4 15:04:05 UTC 201

java-1.8.0-openjdk-1.8.0.141-1.b16.el7_3.x86_64  jre  jre-1.8.0  jre-1.8.0-openjdk  jre-1.8.0-openjdk-1.8.0.141-1.b16.el7_3.x86_64  jre-openjdk

springboot-1.5.4.RELEASE
```

据同事测试，同样的jre、springboot在他的centos虚拟机上并未出现该问题，所以推测有可能是linux版本差异，或是安全策略配置问题，亦或是linux存在这么一个可以配置默认随机数获取算法的方式，有待深究。
