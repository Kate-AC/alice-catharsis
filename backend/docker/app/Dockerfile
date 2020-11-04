FROM ruby:2.7.1-alpine

ENV PATH /opt/node/bin:/opt/ruby/bin:/opt/python/bin:$PATH
ENV LANG ja_JP.UTF-8
ENV WORK_DIR /projects/alice_catharsis

RUN apk update
RUN apk add --no-cache \
  sqlite-dev \
  curl \
  wget \
  npm \
  yarn \
  libffi-dev \
  make \
  git \
  build-base \
  libxml2-dev \
  libxslt-dev \
  gcc \
  mysql-dev \
  bash \
  tzdata

RUN ln -s /lib/ld-musl-x86_64.so.1 /lib/ld-linux-x86-64.so.2

RUN mkdir -p $WORK_DIR
WORKDIR $WORK_DIR

ADD ./Gemfile ${WORK_DIR}/
ADD ./Gemfile.lock ${WORK_DIR}/
RUN bundle install

COPY . $WORK_DIR

