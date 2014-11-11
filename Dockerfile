from   wtool/php:latest

run add-apt-repository -y ppa:nginx/stable; \
    apt-get --yes update; \
    apt-get --yes upgrade --force-yes; \
    apt-get -y --force-yes install nginx; \
    sed -i -e"s/user www-data;/user root;/" /etc/nginx/nginx.conf; \
    sed -i -e"s/keepalive_timeout\s*65/keepalive_timeout 2/" /etc/nginx/nginx.conf; \
    sed -i -e"s/keepalive_timeout 2/keepalive_timeout 2;\n\tclient_max_body_size 2000m/" /etc/nginx/nginx.conf; \
    echo "daemon off;" >> /etc/nginx/nginx.conf
    apt-get autoclean;

add   ./default.conf /etc/nginx/sites-available/default
add   ./php-fpm.conf /opt/php/5.6/etc/php-fpm.conf
add   ./php-fpm.conf /opt/php/5.5/etc/php-fpm.conf
add   ./php-fpm.conf /opt/php/5.4/etc/php-fpm.conf
add   ./php-fpm.conf /opt/php/5.3/etc/php-fpm.conf
run    sed -i -e"s/pm = ondemand/pm = dynamic/" /opt/php/5.3/etc/php-fpm.conf; \
    sed -i -e "s/varPHP/5\.3/" /opt/php/5.3/etc/php-fpm.conf; \
    sed -i -e "s/varPHP/5\.4/" /opt/php/5.4/etc/php-fpm.conf; \
    sed -i -e "s/varPHP/5\.5/" /opt/php/5.5/etc/php-fpm.conf; \
    sed -i -e "s/varPHP/5\.6/" /opt/php/5.6/etc/php-fpm.conf;

add   ./php-start /opt/php-start 
add   ./Procfile /Procfile

expose 80
volume ["/srv"]

cmd ["forego", "start"]
