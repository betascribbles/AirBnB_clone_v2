#!/usr/bin/env bash
# sets up my web servers for the deployment of web_static

echo -e "\e[1;32m START\e[0m"

#--Updating the packages
sudo apt-get -y update
sudo apt-get -y install nginx
echo -e "\e[1;32m Packages updated\e[0m"
echo

#--configure firewall
sudo ufw allow 'Nginx HTTP'
echo -e "\e[1;32m NGINX firewall configured\e[0m"
echo

#--created the dir
sudo mkdir -p /data/web_static/releases/test /data/web_static/shared
echo -e "\e[1;32m directories created"
echo

#--adds test string
echo "<h1>Welcome to www.beta-scribbles.tech</h1>" > /data/web_static/releases/test/index.html
echo -e "\e[1;32m Test string added\e[0m"
echo

#--prevent overwrite
if [ -d "/data/web_static/current" ];
then
    echo "path /data/web_static/current exists"
    sudo rm -rf /data/web_static/current;
fi;
echo -e "\e[1;32m prevent overwrite\e[0m"
echo

#--create symbolic link
sudo ln -sf /data/web_static/releases/test/ /data/web_static/current
sudo chown -hR ubuntu:ubuntu /data

printf %s "server {
    listen 80 default_server;
    listen [::]:80 default_server;
    add_header X-Served-By $HOSTNAME;
    root   /var/www/html;
    index  index.html index.htm;
    location /web_static {
        alias /data/web_static/current;
        index index.html index.htm;
    }
    location /redirect_me {
        return 301 http://youtube.com/;
    }
    error_page 404 /404.html;
    location /404 {
      root /var/www/html;
      internal;
    }
}" > /etc/nginx/sites-available/default

sudo ln -sf '/etc/nginx/sites-available/default' '/etc/nginx/sites-enabled/default'
echo -e "\e[1;32m Symbolic link created\e[0m"
echo

#--restart NGINX
sudo service nginx restart
echo -e "\e[1;32m restart NGINX\e[0m"
