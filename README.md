![Nginx](https://nginx.org/nginx.png)

Nginx alpine - Physical redirect

This image based on nginx-alpine images launch nginx with a basic proxypass configuration witten on /etc/nginx/nginx.conf container file. it add following directive:
``
	server {
		listen       80;
		server_name  ${SERVER_NAME};
		location / {
			proxy_pass         ${PROXY_PASS}/;
		}
	}
``
# Usage
```
docker run --name PhysicalHost-nginx-Proxypass -d
  -e SERVER_NAME=example.domain.com \
	-e PROXY_PASS=http://X.X.X.X:80 \
  flo313/nginx-alpine-physical-proxypass:latest
```
