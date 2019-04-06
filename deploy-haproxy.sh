#!/bin/bash

# Author: Shi-Ken Don <shiken.don@gmail.com>
# Source: https://git.io/deploy-haproxy.sh
# License: MIT

EXPOSED_PORT=${EXPOSED_PORT:-34197}
BACKEND_HOST=${BACKEND_HOST:-1.2.3.4:34197}

apt -y install haproxy

cat <<END | tee -a /etc/haproxy/haproxy.cfg

listen Factorio
	bind :${EXPOSED_PORT}
	mode tcp
	balance leastconn
	option tcp-check
	server Factorio1 ${BACKEND_HOST} send-proxy
END

systemctl enable haproxy
systemctl restart haproxy