FROM alpine:latest as Test

RUN apk update && \
    apk upgrade && \
    apk add nginx php83 php83-fpm php83-mysqli

RUN mkdir /nginx_php

COPY nginx.conf /etc/nginx/nginx.conf

COPY index.php /nginx_php

COPY start.sh start.sh

RUN chmod u+x start.sh

CMD ./start.sh

FROM alpine:latest as Prod

RUN apk update && \
    apk upgrade && \
    apk add nginx php83 php83-fpm php83-mysqli

RUN mkdir /nginx_php

COPY nginx.conf /etc/nginx/nginx.conf

COPY index.php /nginx_php

COPY start.sh start.sh

RUN chmod u+x start.sh

CMD ./start.sh