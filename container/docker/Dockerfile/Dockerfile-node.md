FROM node:6.11.1

# 设置相应的时区
RUN cp /usr/share/zoneinfo/Asia/Shanghai /etc/localtime && echo "Asia/Shanghai" > /etc/timezone

RUN mkdir /portal0

COPY . /portal0

WORKDIR /portal0

RUN npm install --production && npm install pm2 -g

EXPOSE 1338

CMD ["npm", "start"]
