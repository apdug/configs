#!/bin/bash
sed -i~orig -e 's/# deb-src/deb-src/' /etc/apt/sources.list
apt update -y && apt upgrade -y
apt install nginx-full certbot python3-certbot-nginx libssl-dev dpkg-dev build-essential zlib1g-dev libpcre3 git libpcre3-dev unzip -y
bash <(curl -f -L -sS https://ngxpagespeed.com/install) --nginx-version 1.18.0 -y -a '--prefix=/etc/nginx --sbin-path=/usr/sbin/nginx --modules-path=/usr/lib/nginx/modules --conf-path=/etc/nginx/nginx.conf --error-log-path=/var/log/nginx/error.log --http-log-path=/var/log/nginx/access.log --pid-path=/var/run/nginx.pid --lock-path=/var/run/nginx.lock --http-client-body-temp-path=/var/lib/nginx/body --http-fastcgi-temp-path=/var/lib/nginx/fastcgi --http-proxy-temp-path=/var/lib/nginx/proxy --http-scgi-temp-path=/var/lib/nginx/scgi --http-uwsgi-temp-path=/var/lib/nginx/uwsgi --with-compat --with-stream=dynamic --with-stream_ssl_module --with-mail=dynamic --with-mail_ssl_module --with-http_ssl_module --with-http_v2_module'
mkdir /var/ngx_pagespeed_cache && chmod 777 /var/ngx_pagespeed_cache
ln -s /usr/lib/nginx/modules /etc/nginx/modules
curl https://raw.githubusercontent.com/apdug/configs/main/nginx.conf -o /etc/nginx/nginx.conf
service nginx restart
touch /root/.nginxok


# Actualizando metrics de DO
wget https://repos.insights.digitalocean.com/install.sh
chmod +x install.sh
./install.sh

# bash
wget https://raw.githubusercontent.com/apdug/configs/main/bashrc
mv bashrc .bashrc
exec $SHELL
cp /root/.bashrc /webapps/clkec/
chown clkec:webapps /webapps/clkec/.bashrc


# Iniciando usuario
groupadd --system webapps
mkdir -p /webapps/
useradd --system --gid webapps --shell /bin/bash --home /webapps/clkec clkec
gpasswd -a clkec sudo
mkdir -p /webapps/clkec
chown clkec /webapps/clkec
echo clkec:$USRPASSWORD | chpasswd
rm -rf /etc/sudoers.d/clkec
sh -c "echo 'clkec ALL=NOPASSWD: ALL' >> /etc/sudoers"
touch /etc/sudoers.d/clkec
sh -c "echo 'clkec ALL=NOPASSWD: ALL' >> /etc/sudoers.d/clkec"
mkdir -p /webapps/clkec/.ssh/
cp /root/.ssh/authorized_keys /webapps/clkec/.ssh/authorized_keys
chmod 700 /webapps/clkec/.ssh
chmod 600 /webapps/clkec/.ssh/authorized_keys
chown clkec /webapps/clkec/.ssh
chown clkec /webapps/clkec/.ssh/authorized_keys
