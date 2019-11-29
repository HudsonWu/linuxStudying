FROM node:10.16

RUN mkdir /app

COPY echo.js gor /app/

WORKDIR /app

RUN npm config set registry https://registry.npm.taobao.org -g

RUN npm install goreplay_middleware

ENTRYPOINT [ "/app/gor", "--input-raw", ":80", "--middleware", "/app/echo.js", "--output-http-track-response", "--input-raw-track-response", "--http-set-header", "User-Agent: Replayed by Gor", "--output-http" ]
