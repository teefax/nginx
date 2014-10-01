# Nginx instance

Example:

```
web:
  image: wtool/nginx
  ports:
    - 80
  volumes:
    - ./web:/srv
  links:
    - mysql
  environment:
    PHP: 5.6
    TIMEZONE: Europe/Ljubljana
    XDEBUG: 172.17.42.1
    XDEBUG_PORT: 9001
    XDEBUG_IDEKEY: PHPSTORM

mysql:
  image: orchardup/mysql
  ports:
    - 3306
  environment:
    MYSQL_DATABASE: wordpress
    MYSQL_ROOT_PASSWORD: wordpress

selenium:
  image: robcherry/docker-selenium
  ports:
   - 4444
   - 5900
```