1. Establishing an FTP connection
```
ftp domain.com
ftp 192.168.0.1 2121
ftp user@ftpdomain.com
```

2. Downloading files with FTP
```
1) Before downloading a file, set the local FTP file download directory
lcd /home/hudson/dirname
2) Download a file
get filename
3) Download several files
mget *.xls
```

3. Uploading Files with FTP
```
1) Upload a file(current directory)
put filename
2) Upload a file(absolute path)
put /path/filename1 ./filename2
3) Upload several files
mput *.xls
```

4. Closing the FTP connection
```
bye
exit
quit
```
