FROM ruby:2.6.0-slim
MAINTAINER Liam Norton <iamliamnorton@gmail.com>

ENV PHANTOM phantomjs-2.1.1-linux-x86_64

RUN echo "install: --no-document" > "$HOME"/.gemrc &&\
    echo "update: --no-document" >> "$HOME"/.gemrc &&\
    apt-get update &&\
    apt-get -y install curl gnupg sudo &&\
    curl -sL https://deb.nodesource.com/setup_8.x | sudo -E bash - &&\
    apt-get -y install build-essential libpq-dev libxml2-dev libxslt1-dev nodejs \
    # Phantom JS for browser tests
    wget libfreetype6 libfontconfig1 &&\
    cd \tmp &&\
    wget http://cdn.bitbucket.org/ariya/phantomjs/downloads/"$PHANTOM".tar.bz2 &&\
    tar xvjf "$PHANTOM".tar.bz2 &&\
    mv "$PHANTOM" /usr/local/share &&\
    ln -sf /usr/local/share/"$PHANTOM"/bin/phantomjs /usr/local/bin

WORKDIR /srv/app

COPY Gemfile* ./

RUN bundle install --jobs 10 || bundle check

COPY . .

VOLUME ["/srv/app/log"]

EXPOSE 3000/tcp

CMD rails s
