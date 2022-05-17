FROM ubuntu:latest AS build-env
WORKDIR /root
USER root
#install golang, npm, ncurses, BATS etc
RUN apt update
RUN yes | apt install golang-go bash openssl libncurses5-dev libncursesw5-dev wget curl
RUN curl -fsSL https://deb.nodesource.com/setup_18.x | bash -
RUN apt-get install -y nodejs
RUN npm i -g xunit-viewer
RUN npm i -g bats

#expose ports Disabled for now, will return later.
#COPY listentoports /usr/bin
#EXPOSE 8080 26657 26656
#ENTRYPOINT ["listentoports"]

#move important keys, files to test directory in root
COPY /src envnft.profile pub.key / /root/imv-ecommerce-autotests/

#download unpack and move binary to usr/bin
RUN wget https://s.imversed.com/test-net/imversed_linux_amd64_2.tar.gz
RUN tar -xf imversed_linux_amd64_2.tar.gz
RUN mv imversedd /usr/bin/imversed
#COPY imversed /usr/bin

#move test toml config to container config directory
#COPY client.toml /root/.imversed/config/

#setup access to tests and binary
RUN chmod -R 777 /root/imv-ecommerce-autotests/
RUN chmod -R 777 /usr/bin/imversed
RUN ls -l /usr/bin/imversed /root/imv-ecommerce-autotests/

#setup workdir
WORKDIR /root/imv-ecommerce-autotests/
#run a Local Blockchain
#CMD /root/imv-ecommerce-autotests/runChain
