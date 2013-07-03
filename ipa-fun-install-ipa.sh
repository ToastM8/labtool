#! /bin/bash

# If any command here fails, exit the script
set -e

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
source $DIR/config.sh

sudo ipa-server-install -U -r $DOMAIN  -p $PASSWORD  -a $PASSWORD --setup-dns --forwarder=$FORWARDER

# Add forwarder to be double sure
if [[ cat /etc/resolv.conf | grep $FORWARDER == '' ]]
then
  echo "nameserver $FORWARDER" | sudo tee -a /etc/resolv.conf
fi
