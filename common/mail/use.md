1. 简单的邮件
```
$ mail -s "This is the subject" someone@example.com
Hi someone
How are you
I am fine
Bye
> EOT
```
输入第一行命令, 回车后就可以输入邮件内容, 完成输入后按CTRL+D, mailx就会显示出EOT

2. 从文件中取邮件内容
> mail -s "This is subject" someone@example < /path/to/file <br/>
或者可以用echo <br/>
> echo "This is message body" | mail -s "This is subject" someone@example.com <br/>

3. 多个收件人, 收件地址使用逗号 "," 隔开
> echo "This is message body" | mail -s "This is subject" someone@example.com,someone2@example.com

4. 抄送和密送
-c 表示抄送  -b 表示密送 <br/>
> echo "This is message body" | mail -s "This is Subject" -c ccuser@example.com someone@example.com

5. 定义发件人信息
使用-r定义发件人<br/>
> echo "This is message body" | mail -s "This is Subject" -r "Harry<harry@gmail.com>" someone@example.com

6. 使用特殊的回复地址
<pre>
# 回复地址
$ echo "This is message" | mail -s "Testing replyto" -S replyto="mark@gmail.com" someone@example.com

# 回复地址和名称
$ echo "This is message" | mail -s "Testing replyto" -S replyto="Mark<mark@gmail.com>" someone@example.com
</pre>

7. 发送附件
使用-a加上文件路径
> echo "This is message body" | mail -s "This is Subject" -r "Harry<harry@gmail.com>" -a /path/to/file someone@example.com

8. 使用外部的SMTP服务器
<pre>
$ echo "This is the message body and contains the message" | mailx -v \
-r "someone@example.com" \
-s "This is the subject" \
-S smtp="mail.example.com:587" \
-S smtp-use-starttls \
-S smtp-auth=login \
-S smtp-auth-user="someone@example.com" \
-S smtp-auth-password="abc123" \
-S ssl-verify=ignore \
yourfriend@gmail.com
</pre>

echo "sent from helloworld's account" | mailx -v -A someaccount -s "Command line mail" someone@example.com <br/>
