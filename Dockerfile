from   dz0ny/docker-php:latest

run    add-apt-repository -y ppa:nginx/stable
run    apt-get --yes update
run    apt-get --yes upgrade --force-yes

run    apt-get -y --force-yes install nginx 
run    sed -i -e"s/user www-data;/user root;/" /etc/nginx/nginx.conf
run    sed -i -e"s/keepalive_timeout\s*65/keepalive_timeout 2/" /etc/nginx/nginx.conf
run    sed -i -e"s/keepalive_timeout 2/keepalive_timeout 2;\n\tclient_max_body_size 3m/" /etc/nginx/nginx.conf
run    echo "daemon off;" >> /etc/nginx/nginx.conf
run    sudo apt-get -y --force-yes install graphviz #xhprof.io
run    apt-get autoclean

add   ./xhprof /opt/xhprof
add   ./xhprof.php /opt/xhprof/xhprof/includes/config.inc.php
add   ./default.conf /etc/nginx/sites-available/default
add   ./php-fpm.conf /opt/php/5.5/etc/php-fpm.conf
add   ./php-fpm.conf /opt/php/5.4/etc/php-fpm.conf
add   ./php-fpm.conf /opt/php/5.3/etc/php-fpm.conf
run    sed -i -e"s/pm = ondemand/pm = dynamic/" /opt/php/5.3/etc/php-fpm.conf; \
    sed -i -e "s/varPHP/5\.3/" /opt/php/5.3/etc/php-fpm.conf; \
    sed -i -e "s/varPHP/5\.4/" /opt/php/5.4/etc/php-fpm.conf; \
    sed -i -e "s/varPHP/5\.5/" /opt/php/5.5/etc/php-fpm.conf;

add   ./php-start /opt/php-start 
add   ./Procfile /Procfile

expose 80
volume ["/srv"]

cmd ["forego", "start"]