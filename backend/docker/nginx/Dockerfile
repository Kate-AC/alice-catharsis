FROM alpine:3.9
MAINTAINER Kate-AC

ENV LANG ja_JP.UTF-8
ENV WORK_DIR /projects/alice_catharsis

RUN apk --update add \
  nginx \
  && rm -rf /var/cache/apk/*

RUN mkdir -p $WORK_DIR
WORKDIR $WORK_DIR

ADD ./docker/nginx/config/default.conf /etc/nginx/conf.d/default.conf

RUN mkdir -p /run/nginx

