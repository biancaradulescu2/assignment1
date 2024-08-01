FROM alpine:latest as Test

RUN apk update && \
    apk upgrade && \
    apk add nginx php83 php83-fpm php83-mysqli curl
RUN apk add strace bind-tools

RUN apk add strace bind-tools

RUN mkdir /nginx_php/

COPY nginx.conf /etc/nginx/nginx.conf
COPY index.php /nginx_php
COPY www.conf /etc/php83/php-fpm.d/www.conf

HEALTHCHECK CMD curl --fail http://localhost:80 || exit 1

COPY start.sh start.sh

RUN chmod u+x start.sh

RUN rm /etc/nginx/http.d/*.conf

CMD ./start.sh

FROM alpine:latest as Prod

RUN apk update && \
    apk upgrade && \
    apk add nginx php83 php83-fpm php83-mysqli curl

RUN mkdir /nginx_php/

COPY nginx.conf /etc/nginx/nginx.conf
COPY index.php /nginx_php
COPY www.conf /etc/php83/php-fpm.d/www.conf

HEALTHCHECK CMD curl --fail http://localhost:80 || exit 1

COPY start.sh start.sh

RUN chmod u+x start.sh

RUN rm /etc/nginx/http.d/*.conf

CMD ./start.sh