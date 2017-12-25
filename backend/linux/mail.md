Mail
==

1. 测试系统
--

输入如下指令, 看看mail是否已经安装就绪.
```
mail --help
```

如果没有, 则安装

```
yum -y install mailx
```

2.  安装 sendmail, 可以使系统自己具备邮件发送服务器的能力.
--

```
yum -y install sendmail
systemctl enable sendmail
systemctl start sendmail
```


3.  发送
--

邮件正文有三种方式可以附上,

```
mail -s  "邮件标题"  youname@foxmail.com <application.yml

echo "邮件正文内容" | mail -s "邮件主题"  1968089885@foxmail.com

cat  /data/findyou.txt | mail -s "邮件主题"  1968089885@foxmail.com
 
```

带附件发送

注意附件 -a 选项放在前面,  -s 后面可以跟很多个收件人, 如果遇到不可识别的参数, 都会被当成收件人来处理.

```
mail  -a  ./application.yml    -s  "中文标题"  junboqi@foxmail.com  qijb@sunwayworld.com   <README.md
```



4.用第三方smtp服务器发邮件
---
```
vim /etc/mail.rc
```

> set from=1968089885@qq.com smtp="smtp.qq.com"

> set smtp-auth-user="1968089885@qq.com" smtp-auth-password="123456"

> set smtp-auth=login


