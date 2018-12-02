## Dockerfile文件

<https://docs.docker.com/engine/reference/builder/#parser-directives> <br/>
<https://blog.devzeng.com/blog/build-docker-image-with-dockerfile.html> <br/>

镜像的定制实际上就是定制每一层所添加的配置、文件 <br/>
如果我们可以把每一层修改、安装、构建、操作的命令都写入一个脚本, 用这个脚本来构建、定制镜像, <br/>
那么之前提及的无法重复的问题、镜像构建透明性的问题、体积的问题就都会解决。这个脚本就是 Dockerfile <br/>
Dockerfile是一个文本文件, 其包含了一条条的指令(Instruction), 每一条指令构建一层 <br/>

The "docker build" command builds an image from a Dockerfile and a context <br/>
(the build's context is the set of files at a specified location PATH or URL,  <br/>
the PATH is a directory on your local filesystem, the URL is a Git repository location) <br/>

The build is run by the Docker daemon, not by the CLI,  <br/>
the first thing is a build process is send the entire context(recursively) to the daemon <br/>
(in most cases, it's best to start with an empty directory as context and keep your Dockerfile in that directory) <br/>

.dockerignore <br/>

```
docker build -f /path/to/a/Dockerfile .
docker build -t shykes/myapp .
docker build -t shykes/myapp:1.0.2 -t shykes/myapp:latest .
```

The Docker daemon runs the instructions in the Dockerfile one-by-one,  <br/>
committing the result of each instruction to a new image if necessary,  <br/>
before finally outputting the ID of your new image,  <br/>
the Docker daemon will automatically clean up the context you sent <br/>

Format <br/>
  # Comment <br/>
  INSTRUCTION arguments <br/>
Docker runs instructions in a Dockfile in order,  <br/>
A Dockerfile must start with a 'FROM' instruction which specifies the base image <br/>

Parser directives <br/>
Parser directives are optional, and affect the way in which subsequent lines in a Dockfile are handled,  <br/>
Parser directives do not add layers to the build, and will not be shown as a build step, <br/>
Parser directives are written as a special type of comment in the form " # directive=value ",  <br/>
a single directive may only be used once <br/>

escape <br/>
# escape=\ (backslash) <br/>
or <br/>
# escape=` (backtick) <br/>
The escape directive sets the character used to escape characters in a Dockerfile. <br/>
If not specified, the default escape character is \ <br/>

