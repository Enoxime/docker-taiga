#!/bin/sh

cat << __EOD__ > "/opt/taiga-events/config.json"
{
    "url": "amqp://${USERNAME}:${PASSWORD}@${HOSTNAME}:${PORT}/taiga",
    "secret": "${SECRET_KEY}",
    "webSocketServer": {
        "port": 8888
    }
}
__EOD__

eval "${@}"