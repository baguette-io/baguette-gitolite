#!/bin/bash
set -e

#1. Generate SSH Host keys if not exist
for algo in rsa dsa ecdsa ed25519; do
  keypath=/etc/ssh/ssh_host_${algo}_key
  if [ ! -f $keypath ]; then
    ssh-keygen -N '' -t $algo -f $keypath
  fi
done

#2. Setup gitolite
if [ ! -f /home/baguette/.ssh/authorized_keys ]; then
    if [ ! -n "$SSH_PUB_KEY" ]; then
        echo "SSH_PUB_KEY is required when setup gitolite for the first time."
        exit 1
    fi
    echo $SSH_PUB_KEY > /tmp/admin.pub
    su baguette -c "gitolite setup -pk /tmp/admin.pub"
    rm /tmp/admin.pub
else
    su baguette -c "gitolite setup";
fi

#3. Move the hooks
if [ -d /tmp/hooks ]; then
    mv /tmp/hooks/* /home/baguette/.gitolite/hooks/common/
fi

#4. Fix gitolite home permission
chown -Rf baguette:baguette /home/baguette

echo "Executing ${@} ..."
exec "$@"
