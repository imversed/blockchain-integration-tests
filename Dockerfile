FROM golang:1.16.5-alpine AS build-env
WORKDIR /root
USER root
#install npm ncurses, BATS and libc6
RUN apk add bash openssl ncurses --no-cache libc6-compat --update npm
RUN npm i -g xunit-viewer
RUN npm i -g bats

#expose ports Disabled for now, will return later.
#COPY listentoports /usr/bin
#EXPOSE 8080 26657 26656
#ENTRYPOINT ["listentoports"]

#move important keys, files to test directory in root
COPY /src envnft.profile pub.key / /root/imv-ecommerce-autotests/

#move binary to bin
COPY imversed /usr/bin

#move test toml config to container config directory
COPY client.toml /root/.imversed/config/

#setup access to tests and binary
RUN chmod -R 777 /root/imv-ecommerce-autotests/
RUN chmod -R 777 /usr/bin/imversed
RUN ls -l /usr/bin/imversed /root/imv-ecommerce-autotests/

#restore mnemonic keys
RUN yes mouse public panel speak educate domain course object eternal sheriff angry stove blanket fence notice banner whale orbit ring census arctic suffer purity crisp | imversed keys add niko-test --recover
RUN yes coffee rail summer tenant film marble airport clown govern trap reform tip armed nation deny route lock seek delay ribbon hub kingdom shift plate | imversed keys add niko-test-wallet --recover
RUN yes whip turkey van truth consider grape grace mammal return wait fiction case great cradle around measure rack dry home adjust street mercy own report | imversed keys add lowFundsWallet --recover

#setup workdir
WORKDIR /root/imv-ecommerce-autotests/
#run a Local Blockchain
CMD /root/imv-ecommerce-autotests/runChain
