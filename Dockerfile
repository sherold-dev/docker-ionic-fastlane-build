FROM lovato/docker-android:latest

ENV NODEJS_VERSION=8.12.0 \
    PATH=$PATH:/opt/node/bin

ENV LC_ALL=en_US.UTF-8 \
    LANG=en_US.UTF-8

WORKDIR "/opt/node"

RUN apt-get update && apt-get install -y curl git ca-certificates ruby-full less build-essential --no-install-recommends && \
    curl -sL https://nodejs.org/dist/v${NODEJS_VERSION}/node-v${NODEJS_VERSION}-linux-x64.tar.gz | tar xz --strip-components=1 && \
    rm -rf /var/lib/apt/lists/* && \
    apt-get clean

RUN gem install fastlane -NV
RUN gem install bundler:2.0.1

ENV CORDOVA_VERSION 8.1.2
ENV CORDOVA_RES_VERSION 0.3.0
ENV IONIC_VERSION 4.12.0

WORKDIR "/tmp"

RUN npm i -g --unsafe-perm cordova@${CORDOVA_VERSION}
RUN npm i -g --unsafe-perm cordova-res@${CORDOVA_RES_VERSION}
RUN npm i -g --unsafe-perm ionic@${IONIC_VERSION}

