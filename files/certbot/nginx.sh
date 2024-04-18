#!/bin/bash

echo -n "$CERTBOT_VALIDATION" > /root/nginx/html/.well-known/acme-challenge/$CERTBOT_TOKEN
/opt/ansible/bin/ansible-pull -U ssh://git@github.com/MatteZ02/mpp-ansible --private-key ~/.ssh/id_rsa tasks.yml -t nginx &> /dev/null
