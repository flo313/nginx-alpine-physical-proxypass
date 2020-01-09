#! /bin/sh

function ts {
  echo "[`date '+%Y-%m-%d %T'`] `basename "$(test -L "$0" && readlink "$0" || echo "$0")"`:"
}
echo "$(ts) Starting nginx server..."
NGINX_CONF="${NGINX_CONF_PATH}/${NGINX_CONF_FILE}"
NGINX_CONF_ENVSUBST="${NGINX_CONF_PATH}/_${NGINX_CONF_FILE}"
if [ -e ${NGINX_CONF} ] ; then
	envsubst < ${NGINX_CONF} > ${NGINX_CONF_ENVSUBST} && nginx -c ${NGINX_CONF_ENVSUBST}
	echo "$(ts) Starting inotifywait loocking for changes on ${NGINX_CONF}..."
	while inotifywait -q -r -e close_write,moved_to,create ${NGINX_CONF}; do
	  echo "$(ts) Configuration changes detected. Will send reload signal to nginx in ${TIME_TO_UPDATE} seconds..."
	  sleep ${TIME_TO_UPDATE}
	  envsubst < ${NGINX_CONF} > ${NGINX_CONF_ENVSUBST} && nginx -s reload && echo "$(ts) Reload signal send" && echo "$(ts) Loocking for another change on ${NGINX_CONF}"
	done
else
	nginx -g "daemon off;"
fi
