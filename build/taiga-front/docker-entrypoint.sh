#!/bin/sh

cat << "__EOD__" > "/etc/nginx/conf.d/taiga.conf"
server {
    listen 80 default_server;
    server_name _;

    large_client_header_buffers 4 32k;
    client_max_body_size 50M;
    charset utf-8;

    # access_log /var/log/nginx.access.log;
    # error_log /var/log/nginx.error.log;

    # Frontend
    location / {
        root /usr/share/nginx/html/;
        try_files $uri $uri/ /index.html;
    }
}
__EOD__

cat << __EOD__ > "/usr/share/nginx/html/conf.json"
{
    "api": "${API_HOSTNAME}/api/v1/",
    "eventsUrl": "",
    "eventsMaxMissedHeartbeats": 5,
    "eventsHeartbeatIntervalTime": 60000,
    "eventsReconnectTryInterval": 10000,
    "debug": true,
    "debugInfo": false,
    "defaultLanguage": "en",
    "themes": ["taiga"],
    "defaultTheme": "taiga",
    "publicRegisterEnabled": false,
    "feedbackEnabled": true,
    "supportUrl": "https://tree.taiga.io/support/",
    "privacyPolicyUrl": null,
    "termsOfServiceUrl": null,
    "GDPRUrl": null,
    "maxUploadFileSize": null,
    "contribPlugins": [],
    "tribeHost": null,
    "importers": [],
    "gravatar": true,
    "rtlLanguages": ["fa"]
}
__EOD__

exec "$@"