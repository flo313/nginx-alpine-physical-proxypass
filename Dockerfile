FROM nginx:alpine

ENV NGINX_CONF='/etc/nginx/nginx.conf'

RUN apk add --no-cache inotify-tools

ADD ./entrypoint.sh /entrypoint.sh

RUN chmod +x /entrypoint.sh

CMD /entrypoint.sh
