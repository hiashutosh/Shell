#!/bin/bash

# these first five commands are generally required for those system which are completely fresh 
# if docker is installed on system then you can delete these commands
sudo apt-get update -y
sudo apt-get upgrade -y
sudo apt-get install docker.io -y
sudo usermod -aG root ubuntu
sudo usermod -aG docker ubuntu

#making directories for data persistency
mkdir wordpress database nginx

# download the nginx config file from git repo
url=https://raw.githubusercontent.com/hiashutosh/Docker/master/nginx/nginx.conf 
cd nginx/
curl $url > nginx.conf
cd ../

# creatig docker secret for mysql password
echo "root-password" | docker secret create mysql_root_password -

echo "password" | docker secret create mysql_password -

# Mariadb service with 1 replica
docker service create \
--name mysql \
--replicas 1 \
--network mysql_private \
--mount type=volume,source=mydata,destination=/var/lib/mysql \
--secret source=mysql_root_password \
--secret source=mysql_password \
-e MYSQL_ROOT_PASSWORD_FILE="/run/secrets/mysql_root_password" \
-e MYSQL_PASSWORD_FILE="/run/secrets/mysql_password" \
-e MYSQL_USER="wordpress" \
-e MYSQL_DATABASE="wordpress" \
mariadb:latest

# wordpress service with 2 replicas 
docker service create \
--name wordpress \
--replicas 2 \
--network mysql_private \
--mount type=volume,source=wpdata,destination=/var/www/html \
--secret source=mysql_password \
-e WORDPRESS_DB_USER="wordpress" \
-e WORDPRESS_DB_PASSWORD_FILE="/run/secrets/mysql_password" \
-e WORDPRESS_DB_HOST="mysql:3306" \
-e WORDPRESS_DB_NAME="wordpress" \
wordpress:5.7.1-fpm-alpine

# for nginx the conf directory will be of type bind
# wordpress directory can be volume or bind according to above wp service
docker service create \
--name nginx-web \
--publish published=8080,target=80 \
--mount type=volume,source=wpdata,destination=/var/www/html \
--mount type=bind,source=/home/ubuntu/nginx,target=/etc/nginx/conf.d \
--net my-net nginx:1.20.0-alpine

# allow traffic on port 8080
sudo ufw allow 8080/tcp
sudo ufw enable
sudo ufw reload