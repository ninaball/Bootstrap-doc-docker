FROM cloudgear/ruby:2.2
MAINTAINER Nina Ball <nina.ball@gmail.com>

RUN apt-get update
RUN apt-get upgrade -y
RUN apt-get -y install git  ruby-dev build-essential locales zip 
RUN git clone https://github.com/twbs/bootstrap.git /bootstrap
RUN gem install bundler

RUN locale-gen en_US.UTF-8
ENV LANG en_US.UTF-8
ENV LC_ALL en_US.UTF-8
ENV LANGUAGE en_US.UTF-8
ENV LC_CTYPE en_US.UTF-8

WORKDIR /bootstrap
 
RUN bundle install
RUN bundle exec jekyll build

RUN set -ex \ 
    && apt-get clean \
    && apt-get autoclean \
    && apt-get autoremove -y \
    && rm -rf /var/lib/apt/lists/*

 
EXPOSE 9001
#CMD rackup -o 0.0.0.0
CMD bundle exec jekyll -w serve --trace
