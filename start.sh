#!/bin/bash

echo "Starting the vm..."
vagrant up

# Check to see if there is a mount that already exists and unmount it
mount |grep 'moddev' >/dev/null
RC=$?
if [[ $RC == 0 ]]; then
  echo "Unmounting existing mount..."
  umount ~/mount/moddev
fi

echo "Creating nfs mount..."
if [[ ! -d ~/mount/moddev ]]; then
  mkdir ~/mount/moddev
fi
mount -t nfs moddev:/export/moddev ~/mount/moddev
