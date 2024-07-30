#!/bin/sh

/usr/sbin/php-fpm83

# Wait a few seconds to ensure PHP-FPM has started
sleep 5

nginx -g 'daemon off;'