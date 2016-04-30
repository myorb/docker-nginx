FROM debian:jessie

MAINTAINER "Alex MyOrb" <itdep@gmail.com>

WORKDIR /tmp

RUN apt-get update -y && \
    apt-get install -y nginx

ADD bootstrap/nginx.conf /opt/etc/nginx.conf
RUN rm /etc/nginx/sites-enabled/default
ADD bootstrap/default /etc/nginx/sites-available/default
RUN ln -s /etc/nginx/sites-available/default /etc/nginx/sites-enabled/default

ADD bootstrap/nginx-start.sh /opt/bin/nginx-start.sh
RUN chmod u=rwx /opt/bin/nginx-start.sh

RUN mkdir -p /data
VOLUME ["/data"]

EXPOSE 80
EXPOSE 443

WORKDIR /opt/bin
ENTRYPOINT ["/opt/bin/nginx-start.sh"]
