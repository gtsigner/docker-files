FROM node:10-alpine



RUN sed -i 's/dl-cdn.alpinelinux.org/mirrors.aliyun.com/g' /etc/apk/repositories && \
    echo @edge http://mirrors.aliyun.com/alpine/edge/community >> /etc/apk/repositories && \
    echo @edge http://mirrors.aliyun.com/alpine/edge/main >> /etc/apk/repositories && \
    apk add --no-cache \
      chromium@edge \
      nss@edge \
      harfbuzz@edge

#跳过chrome的安装
#ENV PUPPETEER_SKIP_CHROMIUM_DOWNLOAD true
# Puppeteer v1.4.0 works with Chromium 68.

#puppeteer_download_host=https://npm.taobao.org/mirrors
WORKDIR /app

RUN yarn config set puppeteer_download_host https://npm.taobao.org/mirrors && yarn add puppeteer@1.8.0