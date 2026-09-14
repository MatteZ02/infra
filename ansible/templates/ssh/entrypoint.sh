#!/bin/bash

if [[ ! -f /etc/ssh/keys/ssh_host_rsa_key ]]
then
  ssh-keygen -b 4096 -f /etc/ssh/keys/ssh_host_rsa_key -t rsa -N ""
fi
if [[ ! -f /etc/ssh/keys/ssh_host_ed25519_key ]]
then
  ssh-keygen -b 4096 -f /etc/ssh/keys/ssh_host_ed25519_key -t ed25519 -N ""
fi
if [[ ! -f /etc/ssh/keys/authorized_keys ]]
then
  touch /etc/ssh/keys/authorized_keys
fi

cat /etc/ssh/keys/authorized_keys > ~/.ssh/authorized_keys

/usr/sbin/sshd -D
