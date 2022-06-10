FROM ubuntu:latest AS build-env
WORKDIR /root
USER root
#install golang, npm, ncurses, BATS etc
RUN apt update
RUN yes | apt install golang-go bash openssl libncurses5-dev libncursesw5-dev wget curl
RUN yes | apt-get install jq
RUN curl -fsSL https://deb.nodesource.com/setup_18.x | bash -
RUN apt-get install -y nodejs
RUN npm i -g xunit-viewer
RUN npm i -g bats

#move important keys, files to test directory in root
COPY /src / /root/imv-ecommerce-autotests/

#download unpack and move binary to usr/bin
RUN wget https://s.imversed.com/test-net/imversed_linux_amd64_2.tar.gz
RUN tar -xf imversed_linux_amd64_2.tar.gz
RUN mv imversedd /usr/bin/imversed

#setup access to tests and binary
RUN chmod -R 777 /root/imv-ecommerce-autotests/
RUN chmod -R 777 /usr/bin/imversed
RUN ls -l /usr/bin/imversed /root/imv-ecommerce-autotests/

#setup workdir
WORKDIR /root/imv-ecommerce-autotests/
