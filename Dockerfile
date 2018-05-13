FROM nginx:alpine

ENV SERVER_NAME=default
ENV PROXY_PASS_ADDRESS=default

ADD ./start_nginx.sh /start_nginx.sh

RUN chmod +x /start_nginx.sh

CMD /start_nginx.sh