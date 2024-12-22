#!/bin/bash

if [ ! "$BASH_VERSION" ] ; then
    exit 1
fi

echo "
==============================

MatteZ02 - Infra
Install Script

------------------------------
"

stop () {

echo "
==============================
"

exit 1

}

mkdir -p ~/.ssh/keys/matte &> /dev/null
if [[ ! -f ~/.ssh/keys/matte/infra ]]
then
    ssh-keygen -f ~/.ssh/keys/matte/infra -t ed25519 -N '' &> /dev/null
fi

python3 -m venv ~/.venv/ansible &> /dev/null
~/.venv/ansible/bin/pip3 install cryptography dnspython hvac jmespath netaddr pexpect &> /dev/null
~/.venv/ansible/bin/pip3 install ansible &> /dev/null

~/.venv/ansible/bin/ansible-galaxy collection install community.general containers.podman --upgrade &> /dev/null


mkdir -p ~/.ansible &> /dev/null

if [[ ! -f ~/.ansible/vault/matte.yml ]]
then
    echo -n "Vault Password: "
    read PASSWORD
    echo "$PASSWORD" > ~/.ansible/vault/matte.yml
fi

~/.venv/ansible/bin/ansible-pull -U ssh://git@github.com/MatteZ02/infra -d ~/.ansible/pull/matte/infra --accept-host-key --private-key ~/.ssh/keys/matte/infra --vault-password-file ~/.ansible/vault/matte.yml tasks.yml -t installer

echo "
==============================
"
