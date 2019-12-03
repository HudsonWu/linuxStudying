# nginx正则说明

+ ^~  匹配后停止进行正则表达式的匹配
+ =   精确地查找地址
+ @   为location进行命名，即自定义location
  + 这个location不能被外界访问，只能用于Nginx产生的子请求
  + 主要为error_page和try_files
+ ~   区分大小写的匹配
+ ~*  不区分大小写的匹配
+ !~  不匹配的
+ !~* 不匹配的
