FROM golang:1.16.5-alpine AS build-env
WORKDIR /root
USER root
RUN apk add openssl ncurses --no-cache libc6-compat
COPY /src envnft.profile pub.key / /root/imv-ecommerce-autotests/
COPY imversed /usr/bin
COPY client.toml /root/.imversed/config/
RUN chmod -R 777 /root/imv-ecommerce-autotests/
RUN chmod -R 777 /usr/bin/imversed
RUN ls -l /usr/bin/imversed /root/imv-ecommerce-autotests/
RUN yes mouse public panel speak educate domain course object eternal sheriff angry stove blanket fence notice banner whale orbit ring census arctic suffer purity crisp | imversed keys add niko-test --recover
RUN yes coffee rail summer tenant film marble airport clown govern trap reform tip armed nation deny route lock seek delay ribbon hub kingdom shift plate | imversed keys add niko-test-wallet --recover
WORKDIR /root/imv-ecommerce-autotests/
CMD tail -f /dev/null
