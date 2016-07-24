#!/bin/sh

# Replace address
sed -i.bak -e "s/REPLACE_ADDRESS/${ADDRESS:-localhost:80}/" /etc/nginx/conf.d/default.conf

# Generate password
htpasswd -bc /etc/nginx/.htpasswd ${USERNAME:-supersecure} ${PASSWORD:-itsnot}

exec nginx -g 'daemon off;'
