FROM node:13.0.1-buster

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install -y git && rm -rf /var/lib/apt/lists/*

WORKDIR /opt/taiga-events

RUN git clone --single-branch --depth=1 https://github.com/taigaio/taiga-events.git /opt/taiga-events \
    && npm install \
    && npm install -g coffee-script

ENV USERNAME="taiga"
ENV PASSWORD="taiga"
ENV HOSTNAME="rabbitmq"
ENV PORT="5672"
ENV SECRET_KEY="theveryultratopsecretkey"

COPY ./docker-entrypoint.sh /opt/taiga-events/entrypoint.sh

EXPOSE 8888

ENTRYPOINT [ "/opt/taiga-events/entrypoint.sh" ]