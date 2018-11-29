## 分卷

### zip分卷

分卷压缩的话, 需要先将文件打包成一个zip包
> zip origin.zip google1.doc google2.doc  //压缩文件
> zip -s SIZE origin.zip --out new.zip  //分卷
SIZE为分卷的大小, 4m, 4g, 4t等

解压的时候, 需要先合并再解压
> zip -s 0 new.zip --out single.zip  //合卷方式1
> cat new.z* > single.zip  //合卷方式2
> unzip single.zip  //解压

### split分卷

可以使用split给tar归档文件分卷
> tar cvzf google.tar.gz google1.doc google2.doc  //创建归档
> split -d -b 4m google.tar.gz  //分卷, 输出文件的文件名以x开头
> split -d -b 4m google.tar.gz google.tar.gz.  //这样可以指定输出文件的前缀
> cat x* > new.tar.gz  //合卷
> tar zxvf new.tar.gz  //解出文件

### rar分卷

> rar a -v5m google.rar google1.doc google2.doc  //-v和5m之间不要有空格
> unrar x google.part1.rar  //合并并解压
