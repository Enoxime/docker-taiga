FROM nginx:1.17.5

ENV DEBIAN_FRONTEND=noninteractive

ARG TAIGA_FRONT_VERSION="5.0.1-stable"

RUN apt-get update && apt-get install -y git && rm -rf /var/lib/apt/lists/* \
    && git clone --single-branch --depth=1 --branch "${TAIGA_FRONT_VERSION}" https://github.com/taigaio/taiga-front-dist.git /tmp/taiga-front \
    && cp -r /tmp/taiga-front/dist/* /usr/share/nginx/html/. \
    && rm -rf /tmp/taiga-front

ENV API_HOSTNAME="lvh.me"

COPY ./docker-entrypoint.sh /entrypoint.sh

EXPOSE 80

ENTRYPOINT [ "/entrypoint.sh" ]

CMD [ "nginx", "-g", "daemon off;" ]
