![Nginx](https://nginx.org/nginx.png)

# Nginx alpine - Physical redirect

This image based on nginx-alpine images launch nginx and then check for ${NGINX_CONF} changes using inotify. If changes are made, nginx is reloaded ${TIME_TO_UPDATE} seconds after.
# Usage
```
docker run --name PhysicalHost-nginx-Proxypass -d
  -e NGINX_CONF=/etc/nginx/nginx.conf \
  -e TIME_TO_UPDATE=5 \
  -v /path/to/nginx.conf:/etc/nginx/nginx.conf
  flo313/nginx-alpine-physical-proxypass:latest
```
