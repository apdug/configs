#!/bin/bash
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

mkdir -p /webapps/clkec/production
mkdir -p /webapps/clkec/production/logs
mkdir -p /webapps/clkec/production/socks
cd /webapps/clkec/production
git clone $REPO project
