#!/bin/sh

/usr/sbin/php-fpm83

sleep 5

nginx -g 'daemon off;'