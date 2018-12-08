## CMD, ENTRYPOINT

一般会用ENTRYPOINT的中括号形式来定义docker容器启动以后的执行命令 <br/>
里面放的是不变的部分, 可变的部分比如命令行参数可以使用CMD的形式提供默认版本 <br/>
如果想用默认参数, 直接run, 如果想用其他参数, 在run后添加参数 <br/>

### CMD, 一个容器的默认可执行体

```
The main purpose of a CMD is to provide defaults for an executing container. 
These defaults can include an executable, or they can omit the executable, in which case you must specify an ENTRYPOINT instruction as well.
```

CMD命令的主要作用是默认的容器启动执行命令, <br/>
意味着, 如果docker run没有指定任何的执行命令或者dockerfile里面也没有entrypoint, 那么, 就会使用cmd指定的默认执行命令 <br/>
一个dockerfile至多只能有一个CMD, 如果有多个, 只有最后一个生效<br/>

#### 三种用法
1. exec form, this is the preferred form

```
CMD ["executable", "param1", "param2"]
```
带有中括号的形式, 这时, 命令没有在任何shell终端环境下, <br/>
第一个参数必须是命令的全路径 <br/>
如果在run时指定了命令或者有entrypoint, 那么CMD会被覆盖<br/>

2. as default parameters to ENTRYPOINT

```
CMD ["param1", "param2"]
```

3. shell form

```
CMD command param1 param2
```
没有中括号的形式, 命令默认在"/bin/sh -c"下执行<br/>

### ENTRYPOINT, 定义容器启动以后的执行体

```
An ENTRYPOINT allows you to configure a container that will run as an executable
```

#### 两种用法

1. exec form, preferred

命令行模式 (带中括号)

```
ENTRYPOINT ["executable", "param1", "param2"]
```
在shell环境下执行, 如果run后面有内容, 将都会作为entrypoint的参数, <br/>
如果run后面没有额外的内容, 但是cmd有, 那么cmd的内容会作为entrypoint的参数, 即CMD的第二种用法 <br/>

2. shell form

shell模式

```
ENTRYPOINT command param1 param2
```
在这种模式下, 任何run和cmd的参数都无法被传入到entrypoint
