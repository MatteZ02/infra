#!/bin/bash

echo -n "$CERTBOT_VALIDATION" > /root/nginx/html/.well-known/acme-challenge/$CERTBOT_TOKEN
mkdir -p /root/nginx/html/.well-known/acme-challenge
/opt/ansible/bin/ansible-pull -U ssh://git@github.com/MatteZ02/mpp-infra --accept-host-key --private-key ~/.ssh/id_rsa --vault-password-file ~/.ansible/vault.yml tasks.yml -t nginx &> /dev/null
