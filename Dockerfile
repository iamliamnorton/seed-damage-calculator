FROM ruby:2.3.6-slim
MAINTAINER Liam Norton <iamliamnorton@gmail.com>

RUN \
  apt-get update &&\
  apt-get -y install \
    build-essential \
    libpq-dev \
    libxml2-dev \
    libxslt1-dev \
    nodejs &&\
  rm -rf /var/lib/apt/lists/*

ENV PHANTOM phantomjs-2.1.1-linux-x86_64

RUN \
  apt-get update &&\
  apt-get -y install \
    wget \
    libfreetype6 \
    libfontconfig1 &&\
  cd \tmp &&\
  wget http://cdn.bitbucket.org/ariya/phantomjs/downloads/"$PHANTOM".tar.bz2 &&\
  tar xvjf "$PHANTOM".tar.bz2 &&\
  mv "$PHANTOM" /usr/local/share &&\
  ln -sf /usr/local/share/"$PHANTOM"/bin/phantomjs /usr/local/bin &&\
  rm -rf /var/lib/apt/lists/*

WORKDIR /srv/app

COPY Gemfile* /srv/app/

RUN bundle install

ADD . .

VOLUME ["/srv/app/log"]

EXPOSE 3000/tcp

CMD rails s
