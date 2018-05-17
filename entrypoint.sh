#! /bin/sh

function ts {
  echo "[`date '+%Y-%m-%d %T'`] `basename "$(test -L "$0" && readlink "$0" || echo "$0")"`:"
}
if [ -e ${NGINX_CONF} ] ; then
	echo "$(ts) Starting nginx server..."
	nginx

	echo "$(ts) Starting inotifywait loocking for changes on ${NGINX_CONF}..."
	while inotifywait -q -r -e close_write,moved_to,create ${NGINX_CONF}; do
	  echo "$(ts) Configuration changes detected. Will send reload signal to nginx in ${TIME_TO_UPDATE} seconds..."
	  sleep ${TIME_TO_UPDATE}
	  nginx -s reload && echo "$(ts) Reload signal send" && echo "$(ts) Loocking for another change on ${NGINX_CONF}"
	done
else
	echo "$(ts) Unable to find ${NGINX_CONF}, starting nginx waiting its closure..."
	nginx -g "daemon off;"
fi
