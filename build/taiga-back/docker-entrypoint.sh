#!/bin/sh

__taiga_back_path="/opt/taiga-back"

# Setting up configurtions
mv "${__taiga_back_path}/settings/docker-local.py" "${__taiga_back_path}/settings/local.py"
sed 's/guest:guest@localhost:5672\/\//taiga:taiga@rabbitmq:5672\/taiga/;
    s/localhost:6379/redis:6379/' -i "${__taiga_back_path}/settings/celery.py"

# Add bjoern
{
    echo "import bjoern"
    echo "from taiga.wsgi import application as app"
    echo 'bjoern.run(app, "0.0.0.0", 8000)'
} >> "${__taiga_back_path}/app.wsgi"

# if [ ! -f "${__taiga_back_path}/settings/local.py" ]; then
if [ ! -f "/etc/nginx/conf.d/taiga.conf" ]; then
    # Populate the database
    python manage.py migrate --noinput
    python manage.py loaddata initial_user
    python manage.py loaddata initial_project_templates
    python manage.py compilemessages
    python manage.py collectstatic --noinput

    # nginx settup
    rm /etc/nginx/sites-enabled/default
    # mkdir -p /var/log/taiga
    cat << "__EOD__" > "/etc/nginx/conf.d/taiga.conf"
server {
    listen 80 default_server;
    server_name _;

    large_client_header_buffers 4 32k;
    client_max_body_size 50M;
    charset utf-8;

    # access_log /var/log/taiga/nginx.access.log;
    # error_log /var/log/taiga/nginx.error.log;

    # Backend
    location /api {
        proxy_set_header Host $http_host;
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header X-Scheme $scheme;
        proxy_set_header X-Forwarded-Proto $scheme;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
        proxy_pass http://0.0.0.0:8000/api;
        proxy_redirect off;
    }

    # Admin access (/admin/)
    location /admin {
        proxy_set_header Host $http_host;
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header X-Scheme $scheme;
        proxy_set_header X-Forwarded-Proto $scheme;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
        proxy_pass http://0.0.0.0:8000$request_uri;
        proxy_redirect off;
    }

    # Static files
    location /static {
        alias /opt/taiga-back/static;
    }

    # Media files
    location /media {
        alias /opt/taiga-back/media;
    }
}
__EOD__
fi

python "${__taiga_back_path}/app.wsgi" &
nginx -g "daemon off;"
