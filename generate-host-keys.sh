#!/bin/bash


HOSTVAR=host_vars/$1.yml
PRIVKEY=$(wg genkey)
PUBKEY=$(echo $PRIVKEY | wg pubkey)


if [ ! -d host_vars ]; then
    mkdir -p host_vars
fi

ansible-vault encrypt_string "$PRIVKEY" --name "wireguard_private_key" >> $HOSTVAR
echo "wireguard_public_key: '$PUBKEY'" >> $HOSTVAR
