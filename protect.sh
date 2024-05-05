#!/bin/bash

underline=`tput smul`
nounderline=`tput rmul`
bold=$(tput bold)
normal=$(tput sgr0)

echo "${bold}MKJ / Infra / Protect${normal}"
action=$1

encrypt() {
    echo "${underline}Encrypting...${nounderline}"
    execute "ansible-vault encrypt --vault-id default@vault/mkj"
}

decrypt() {
    echo "${underline}Decrypting...${nounderline}"
    execute "ansible-vault decrypt --vault-id default@vault/mkj"
}

list() {
    echo "${underline}Listing...${nounderline}"
    i=0
    for file in inventories/*/group_vars/* inventories/*/host_vars/*;
    do
        i=$((i + 1))
        echo $i")"$file
    done
}

execute() {
for file in inventories/*/group_vars/* inventories/*/host_vars/*;
    do
        i=$((i + 1))
        echo $i")"$file
        $1 $file
    done
}


case $action in
    encrypt)
        encrypt
        ;;
    decrypt)
        decrypt
        ;;
    list)
        list
        ;;
    help)
        echo "encrypt, decrypt, list"
        ;;
    *)
        echo "..."
        ;;
esac
