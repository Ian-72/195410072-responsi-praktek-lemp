#Pull image debian versi terbaru dari docker hub
FROM debian:latest

#Install paket nginx, php-fpm, mariadb
RUN apt-get update && \
    apt-get install nginx \
    php-fpm \
    php-mysql \
    mariadb-server -y 

#Konfigurasi nginx
RUN rm /etc/nginx/sites-available/default /etc/nginx/sites-enabled/default && \ 
    echo "\ndaemon off;" >> /etc/nginx/nginx.conf
ADD konfig/default /etc/nginx/sites-available/default
RUN ln -s /etc/nginx/sites-available/default /etc/nginx/sites-enabled/default

#Bangun direktori halaman web
RUN mkdir /var/www/html/app/

#Copy seluruh file yang ada di dalam folder app ke direktori halaman web image
COPY /app /var/www/html/app/

#Copy seluruh file yang ada di dalam folder konfig ke direktori temporary image
COPY db/web_personal.sql /tmp/web_personal.sql
COPY konfig/scriptsql.sh /tmp/scriptsql.sh
COPY konfig/run.sh /tmp/run.sh

#File scipt di beri akses 755 agar bisa berjalan 
RUN chmod +x /tmp/run.sh 

#Buka port http dan mysql
EXPOSE 80 3306

#Jalankan script untuk memulai 
CMD ./tmp/run.sh
