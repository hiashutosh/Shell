#!/bin/bash

# these first five commands are generally required for those system which are completely fresh 
# if docker is not installed on system then you can uncomment these commands
#sudo apt-get update -y
#sudo apt-get upgrade -y
#sudo apt-get install docker.io -y
#sudo usermod -aG root ubuntu
#sudo usermod -aG docker ubuntu

#making directories for data persistency
mkdir database nginx

# download the nginx config file from git repo
url=https://raw.githubusercontent.com/hiashutosh/Shell/main/nginx/nginx.conf
cd nginx/
curl $url > nginx.conf
cd ../

wget https://wordpress.org/latest.tar.gz
tar -xvf latest.tar.gz

url2=https://raw.githubusercontent.com/hiashutosh/Shell/main/wp-config.php
curl $url2 > wordpress/wp-config.php

# creating a new network in docker
sudo docker network create my-net

# running the docker container for Database
sudo docker run -td --name db \
-e MYSQL_ROOT_PASSWORD=pass1234 \
-e MYSQL_DATABASE=wordpressdb \
-e MYSQL_USER=ashutosh \
-e MYSQL_PASSWORD=password \
-v /home/ubuntu/database:/var/lib/mysql \
--net my-net mariadb

# running the docker container for Wordpress

sudo docker run -id --name php \
-v /home/ubuntu/wordpress:/var/www/html \
--net my-net php:8.0-fpm

sudo docker exec -it php \
/bin/sh \
-c "docker-php-ext-install mysqli gd sockets;php-fpm"

sudo docker stop php
sudo docker start php

# running the docker container for Nginx 
sudo docker run -td --name nginx-web \
-p 8080:80 \
-v /home/ubuntu/wordpress:/var/www/html \
-v /home/ubuntu/nginx:/etc/nginx/conf.d \
--net my-net nginx:1.20.0-alpine

# allow traffic on port 8080
sudo ufw allow 8080/tcp
sudo ufw enable
sudo ufw reload