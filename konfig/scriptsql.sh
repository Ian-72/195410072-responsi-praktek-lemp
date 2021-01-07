#!/bin/sh

mysql -u root -e "use mysql; update user set plugin='' where User='root'; flush privileges;"
mysql -u root -e "create database web_personal;"
mysql -u root web_personal < /tmp/web_personal.sql
