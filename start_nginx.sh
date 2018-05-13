#!/bin/sh
NGINX_CONF='/etc/nginx/nginx.conf'
echo "---------------------------------------------------------------------------------------------------------"
echo "Start script!"
# echo "*** $NGINX_CONF initial content ***"
# cat $NGINX_CONF
# echo "***"
echo ""
echo "Check for $SERVER_NAME and $PROXY_PASS var..."
echo "  \$SERVER_NAME=$SERVER_NAME"
echo "  \$PROXY_PASS=$PROXY_PASS"
echo ""
if ! [ $SERVER_NAME = 'default' ] || ! [ $PROXY_PASS = 'default' ]; then
	echo " \$SERVER_NAME or \$PROXY_PASS different than 'default' value."
	echo " Backuping $NGINX_CONF..."
	cp $NGINX_CONF $NGINX_CONF.bak
	echo " Recreating $NGINX_CONF without last '}' character..."
	head -n -1 $NGINX_CONF.bak > $NGINX_CONF
	# echo " *** $NGINX_CONF without '}' character ***"
	# cat $NGINX_CONF
	# echo " ***"
	echo " Adding server directive..."
	{
		echo "	server {"
		echo "		listen       80;"
		echo "		server_name  ${SERVER_NAME};"
		echo "		location / {"
		echo "			proxy_pass         ${PROXY_PASS}/;"
		echo "		}"
		echo "	}"
		echo "}"
	} >> $NGINX_CONF
	# echo " *** $NGINX_CONF new content ***"
	# cat $NGINX_CONF
	# echo " ***"
fi
nginx -g 'daemon off;'