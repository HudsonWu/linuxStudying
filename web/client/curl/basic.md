## curl

cURL is very useful command line tool to transfer data from or to a server

cURL supports various protocols like: <br/>
FILE,HTTP,HTTPS,IMAP,IMAPS,LDAP,DICT,LDAPS,TELNET,FTP,FTPS,GOPHER,RTMP,RTSP,SCP,SFTP,POP3,POP3S,SMBS,SMTP,SMTPS,and TFTP

## Download a Single File

```
curl http://www.centos.org
curl http://www.centos.org > centos-org.html
```

## Save the cURL Output to a file

We can save the result of the curl command to a file by using -o/-O options

+ > -o(lowercase), the result will be saved in the filename provided in the command line
    > curl -o mygettext.html http://www.gnu.org/software/getext/manual/gettext.html
+ > -O(uppercase), the filename in the URL will be taken and it will be used as the filename to store the result
    > curl -O http://www.gnu.org/software/gettext/manual/gettext.html

## Fetch Multiple Files at a time

```
curl -O URL1 -O URL2
```

## Follow HTTP Location Headers with -L option

When a requested web page is moved to another place, then an HTTP Location header will be sent as a Response and it will have where the actual web page is located. We can insists curl to follow the redirection using -L option
```
curl -L http://www.google.com
```

## Continue/Resume a Previous Download

Using "curl -C -", we can continue the download from where it left off earlier(if the download was stopped at ##1%, now the download continues from ##1%)
```
curl -C - -O http://www.gnu.org/software/gettext/manual/gettext.html
```

## Limit the Rate of Data Transfer

```
curl --limit-rate 1000B -O http://www.gnu.org/software/manual/gettext.html
```
The above command is limiting the data transfer to 1000 Bytes/second

## Download a file only if it is modified before/after the given time

We can get the files that are modified after a particular time using -z option in curl, This will work for both FTP & HTTP
```
curl -z 21-Dec-11 http://www.example.com/yy.html
```
The above command will download the yy.html only if it is modified later than the given data and time
```
curl -z -21-Dec-11 http://www.example.com/yy.html
```
Tht above command will download the yy.html, if it is modified before than the given date and time

Refer `man curl_getdate` for the various syntax supported for the date expression

## Pass HTTP Authentication in cURL

Sometimes, websites will require a username and password to view the content(can be done with .htaccess file), we can pass those credentials from cURL to the web server as shown below
```
curl -u username:password URL
```
Note: By default curl uses Basic HTTP Authentication. We can specify other authentication method using -ntlm | -digest

## Download Files from FTP server

```
curl -u ftpuser:ftppass -O ftp://ftp_server/public_html/xss.php
```
The above command will download the xss.php file from the ftp server and save it in the local directory
```
curl -u ftpuser:ftppass -O ftp://ftp_server/public_html/
```
Here, the given URL refers to a directory, So cURL will list all the files and directories under the given URL

## List/Download using Ranges

```
curl ftp://ftp.uk.debian.org/debian/pool/main/[a-z]/
```
The above command will list out all the packages from a-z ranges in the terminal

## Upload Files to FTP Server

```
curl -u ftpuser:ftppass -T myfile.txt ftp://ftp.testserver.com
curl -u ftpuser:ftppass -T "{file1,file2)" ftp://ftp.testserver.com
curl -u ftpuser:ftppass -T - ftp://ftp.testserver.com/myfile.txt
```
The last command will get the input from the user from standard input and save the contents in the ftp server under the name 'myfile.txt'

## More Information using Verbose and Trace Option

You can get to know what is happening using the -v option. -v option enable the verbose mode and it will print the details
```
curl -v http://google.co.in
```
If you need more detailed information then you can use the --trace option. The trace option will enable a full trace dump of all incoming/outgoing data to the given file

## Get Definition of a Word using DICT Protocol

```
curl dict://dict.org/d:bash
```

## Use Proxy to Download a File

```
curl -x proxyserver.test.com:3128 http://google.co.in
```

## Send Mail using SMTP Protocol

```
curl --mail-from blah@test.com --mail-rcpt foo@test.com smtp://mailserver.com
```
Once the above command is enterd, it will wait for the user to provide the data to mail. Once you've composed your message, type .(period) as the last line, which will send the email immediately

## Get HTTP header information from a website

```
curl -I http://domain.com
```
