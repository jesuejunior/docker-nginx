FROM ubuntu:14.04.2
MAINTAINER Jesue Junior <jesuesousa@gmail.com>

ENV DEBIAN_FRONTEND noninteractive

ADD files/nginx_signing.key /nginx_signing.key

RUN apt-key add /nginx_signing.key \
    && echo "deb http://nginx.org/packages/ubuntu/ trusty nginx" >> /etc/apt/sources.list \
    && echo "deb-src http://nginx.org/packages/ubuntu/ trusty nginx" >> /etc/apt/sources.list \
    && apt-get update \
    && apt-get install nginx --force-yes \
    && rm -rf /etc/nginx/conf.d/default.conf \
    && apt-get clean -y

# Adding settings of nginx and app
ADD files/nginx.conf /etc/nginx/nginx.conf
ADD files/nginx.app.conf /etc/nginx/conf.d/app.conf

VOLUME /opt/nginx

EXPOSE 80 443

CMD service nginx start
