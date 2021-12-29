FROM golang:1.16.5-alpine AS build-env
WORKDIR /root
USER root
RUN apk add openssl ncurses --no-cache libc6-compat
COPY . / /root/imv-ecommerce-autotests/
COPY imversed /usr/bin
RUN chmod -R 777 /root/imv-ecommerce-autotests/
RUN chmod 777 /usr/bin/imversed
RUN ls -l /usr/bin/imversed
RUN ls -l /root/imv-ecommerce-autotests/
CMD tail -f /dev/null