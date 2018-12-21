1. Dockerfile
```
FROM ubuntu:latest

RUN apt-get update && apt-get install python-software-properties software-properties-common -y
RUN apt-get install apache2 mysql-server -y
RUN add-apt-repository ppa:ondrej/php
RUN apt-get update && apt-get install php5.6 php5.6-mbstring \
php5.6-mcrypt php5.6-mysql php5.6-xml php5.6-gd -y

EXPOSE 80
```

2. docker build -t="dvwa" .

3. run that image and attach to it:
```
docker run -i -t dvwa
//or to run it in the background
docker run -d dvwa
```
