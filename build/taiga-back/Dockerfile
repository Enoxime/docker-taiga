FROM python:3.7.5-buster AS base


FROM base AS builder

ENV DEBIAN_FRONTEND=noninteractive

ARG TAIGA_BACK_VERSION=4.2.14

RUN apt update && apt install -y \
    gcc \
    git \
    libcairo2-dev \
    libev-dev \
    libjpeg-dev \
    libxml2-dev \
    libxslt1-dev \
    postgresql \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /opt/taiga-back

RUN git clone --depth=1 --branch "${TAIGA_BACK_VERSION}" https://github.com/taigaio/taiga-back.git /opt/taiga-back

RUN pip install -r requirements.txt && pip install bjoern


FROM base

ENV DEBIAN_FRONTEND=noninteractive

RUN apt update && apt install -y \
    gettext \
    libev-dev \
    libjpeg-dev \
    libxslt-dev \
    nginx \
    postgresql

ENV MEDIA_URL="http://lvh.me/media/"
ENV STATIC_URL="http://lvh.me/static/"
ENV SITES_FRONT_SCHEME="http"
ENV SITES_FRONT_DOMAIN="lvh.me"
ENV SECRET_KEY="theveryultratopsecretkey"
ENV DEBUG="True"
ENV PUBLIC_REGISTER_ENABLED="True"
ENV DEFAULT_FROM_EMAIL="no-reply@localhost"
ENV SERVER_EMAIL="$DEFAULT_FROM_EMAIL"
ENV CELERY_ENABLED="True"
ENV EVENTS_PUSH_BACKEND="taiga.events.backends.rabbitmq.EventsPushBackend"
ENV EVENTS_PUSH_BACKEND_OPTIONS='{"url": "amqp://taiga:taiga@rabbitmq:5672/taiga"}'
ENV EMAIL_BACKEND=''
ENV EMAIL_USE_TLS=''
ENV EMAIL_HOST=''
ENV EMAIL_HOST_USER=''
ENV EMAIL_HOST_PASSWORD=''
ENV EMAIL_PORT=''
ENV GITHUB_API_CLIENT_ID=''
ENV GITHUB_API_CLIENT_SECRET=''
ENV DB_ENGINE="django.db.backends.postgresql"
ENV DB_NAME="taigadb"
ENV DB_HOST="postgres"
ENV DB_USER="taiga"
ENV DB_PASSWORD="taiga"

COPY --from=builder /usr/local /usr/local
COPY --from=builder /opt/taiga-back /opt/taiga-back
COPY ./docker-entrypoint.sh /opt/taiga-back/entrypoint.sh
COPY ./docker-local.py /opt/taiga-back/settings/docker-local.py
COPY ./docker.py /opt/taiga-back/settings/docker.py

WORKDIR /opt/taiga-back

EXPOSE 80

ENTRYPOINT [ "/opt/taiga-back/entrypoint.sh" ]