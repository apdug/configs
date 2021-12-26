#!/bin/bash
apt update -y && apt upgrade -y
apt install nginx-full certbot python3-certbot-nginx libssl-dev -y
bash <(curl -f -L -sS https://ngxpagespeed.com/install) --nginx-version 1.18.0 -y -a '--prefix=/etc/nginx --sbin-path=/usr/sbin/nginx --modules-path=/usr/lib/nginx/modules --conf-path=/etc/nginx/nginx.conf --error-log-path=/var/log/nginx/error.log --http-log-path=/var/log/nginx/access.log --pid-path=/var/run/nginx.pid --lock-path=/var/run/nginx.lock --http-client-body-temp-path=/var/lib/nginx/body --http-fastcgi-temp-path=/var/lib/nginx/fastcgi --http-proxy-temp-path=/var/lib/nginx/proxy --http-scgi-temp-path=/var/lib/nginx/scgi --http-uwsgi-temp-path=/var/lib/nginx/uwsgi --with-compat --with-stream=dynamic --with-stream_ssl_module --with-mail=dynamic --with-mail_ssl_module --with-http_ssl_module --with-http_v2_module'
mkdir /var/ngx_pagespeed_cache && chmod 777 /var/ngx_pagespeed_cache
ln -s /usr/lib/nginx/modules /etc/nginx/modules
curl https://raw.githubusercontent.com/apdug/configs/main/nginx.conf -o /etc/nginx/nginx.conf
service nginx restart
