#!/bin/bash

if [ ! "$BASH_VERSION" ] ; then
    exit 1
fi

echo "
==============================

Multi Platform Project - Ansible
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

apt-get install -y python3-pip python3-venv jq git curl &> /dev/null
python3 -m venv /opt/ansible &> /dev/null
/opt/ansible/bin/pip3 install ansible hvac netaddr jmespath pexpect &> /dev/null

/opt/ansible/bin/ansible-galaxy collection install -r requirements.yml --upgrade &> /dev/null

/opt/ansible/bin/ansible-pull -U ssh://git@github.com/MatteZ02/mpp-ansible --private-key ~/.ssh/id_rsa tasks.yml -t installer


echo "
==============================
"
