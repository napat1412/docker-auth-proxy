#!/bin/sh

# Replace address
while IFS=';' read -ra PROXY_LIST; do
  for PROXY in "${PROXY_LIST[@]}"; do
    IFS=',' read -a URL_PORT <<< "${PROXY}"
    #echo "URL:${URL_PORT[0]} , PORT:${URL_PORT[1]}"
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
