#!/bin/bash

# Replace address
while IFS=';' read -ra PROXY_LIST; do
  for PROXY_ITEM in "${PROXY_LIST[@]}"; do
    IFS=',' read -a URL_PORT <<< "${PROXY_ITEM}"
    echo "Listening on PORT: ${URL_PORT[1]} and proxy_pass to URL:${URL_PORT[0]}"
    URL=${URL_PORT[0]}
    cp /etc/nginx/conf.d/default.conf /etc/nginx/conf.d/${URL}.conf
    sed -i -e "s/REPLACE_ADDRESS/${URL}/" /etc/nginx/conf.d/${URL}.conf
    sed -i -e "s/LISTEN_PORT/${URL_PORT[1]}/" /etc/nginx/conf.d/${URL}.conf
  done
done <<< "$PROXY"
rm /etc/nginx/conf.d/default.conf

# Generate password
htpasswd -bc /etc/nginx/.htpasswd ${USERNAME:-admin} ${PASSWORD:-admin}

exec nginx -g 'daemon off;'
