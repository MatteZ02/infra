#!/bin/bash

if [ ! "$BASH_VERSION" ] ; then
    exit 1
fi

echo "
==============================

MPP - Infra
Install Script

------------------------------
"

stop () {

echo "
==============================
"

exit 1

}

mkdir -p ~/.ssh &> /dev/null

apt-get update &> /dev/null
apt-get install -y python3-pip python3-venv jq git curl &> /dev/null
python3 -m venv /opt/ansible &> /dev/null
/opt/ansible/bin/pip3 install ansible hvac netaddr jmespath pexpect &> /dev/null

/opt/ansible/bin/ansible-galaxy collection install -r requirements.yml --upgrade &> /dev/null

mkdir -p ~/.ansible &> /dev/null

if [[ ! -f ~/.ansible/vault.yml ]]
then
    echo -n "Vault Password: "
    read PASSWORD
    echo "$PASSWORD" > ~/.ansible/vault.yml
fi

ssh-keyscan github.com 1> ~/.ssh/known_hosts 2> /dev/null

/opt/ansible/bin/ansible-pull -U ssh://git@github.com/MatteZ02/mpp-ansible --accept-host-key --private-key ~/.ssh/id_rsa --vault-password-file ~/.ansible/vault.yml tasks.yml -t installer

echo "
==============================
"
