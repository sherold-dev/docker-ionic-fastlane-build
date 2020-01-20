FROM lovato/docker-android:latest

ENV NODEJS_VERSION=12.14.1 \
    RUBY_VERSION=2.7 \
    CORDOVA_VERSION=9.0.0 \
    CORDOVA_RES_VERSION=0.8.1 \
    IONIC_VERSION=5.4.15 \
    PATH=$PATH:/opt/node/bin

ENV LC_ALL=en_US.UTF-8 \
    LANG=en_US.UTF-8

WORKDIR "/opt/node"

RUN apt-get install -y curl && curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - && \
	echo "deb http://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list && \
	apt-get update && apt-get install -y curl git ca-certificates ruby-full less zlib1g-dev build-essential libssl-dev libreadline-dev libyaml-dev \
    libsqlite3-dev sqlite3 libxml2-dev libxslt1-dev libcurl4-openssl-dev software-properties-common libffi-dev yarn --no-install-recommends && \
    curl -sL https://nodejs.org/dist/v${NODEJS_VERSION}/node-v${NODEJS_VERSION}-linux-x64.tar.gz | tar xz --strip-components=1 && \
    rm -rf /var/lib/apt/lists/* && \
    apt-get clean


RUN wget http://ftp.ruby-lang.org/pub/ruby/${RUBY_VERSION}/ruby-${RUBY_VERSION}.0.tar.gz && \
    tar -xzvf ruby-${RUBY_VERSION}.0.tar.gz && cd ruby-${RUBY_VERSION}.0/ && ./configure && \
    make && make install && ruby -v

RUN gem install fastlane:2.140
RUN gem install bundler:2.1.4



WORKDIR "/tmp"

RUN npm i -g --unsafe-perm cordova@${CORDOVA_VERSION}
RUN npm i -g --unsafe-perm cordova-res@${CORDOVA_RES_VERSION}
RUN npm i -g --unsafe-perm ionic@${IONIC_VERSION}

