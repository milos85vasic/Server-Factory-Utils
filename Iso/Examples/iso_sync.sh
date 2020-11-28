#!/bin/sh

source=$1
where=$2
user="my_user"
password="my_password"
remote="my-server.com:some/root/path/$where"

echo "Synchronizing: $source -> $remote"
sshpass -p "$password" rsync -azP -e 'ssh -p 5522' --delete "$source" "$user@$remote"