#!/bin/bash

nginx_conf() {

if [[ -e $PWD/nginx/nginx.conf ]];
then
    sudo rm -rf $PWD/nginx/nginx.conf
fi
cat >> $PWD/nginx/nginx.conf << EOF    
server {
    listen $port;
    listen [::]:$port;
    server_name $hostname;

    root $root_dir;
   
    index index.php index.html;
    location ~ /.well-known/acme-challenge {
                allow all;
                root $root_dir;
    }

    location / {
        try_files \$uri \$uri/ /index.php\$is_args\$args;

    }
    location ~ \.php$ {
        try_files \$uri =404;
        fastcgi_split_path_info ^(.+\.php)(/.+);
        fastcgi_pass php:9000;
        fastcgi_index index.php;
        include fastcgi_params;
        fastcgi_param SCRIPT_FILENAME \$document_root\$fastcgi_script_name;
        fastcgi_param PATH_INFO \$fastcgi_path_info;

    }

    location ~ /\.ht {
        deny all;
    }
}
EOF
}

nginx_conf

wp_conf()
{
cd $PWD/wordpress/

if [[ -e wp-config.php ]]
then
    rm -rf wp-config.php
fi

cp wp-config-sample.php wp-config.php

sed -i "s/define( 'DB_NAME', 'database_name_here' )/define('DB_NAME', '$db_name' )/g" wp-config.php
sed -i "s/define( 'DB_USER', 'username_here' )/define( 'DB_USER', '$user_name' )/g" wp-config.php
sed -i "s/define( 'DB_PASSWORD', 'password_here' )/define( 'DB_PASSWORD', '$pw' )/g" wp-config.php
sed -i "s/define( 'DB_HOST', 'localhost' )/define( 'DB_PASSWORD', '$host' )/g" wp-config.php
}

wp_conf
