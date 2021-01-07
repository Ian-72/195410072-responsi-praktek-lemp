#!/bin/bash

service php7.3-fpm start && service mysql start && ./tmp/scriptsql.sh && nginx
