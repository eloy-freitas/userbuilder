#!/bin/sh

echo -n "enter the group name: "
read group

GROUPNAME=`getent group $group`
while test ! -z $GROUPNAME; do
    echo "this group already exist, try another."
    echo -n "enter the group name: "
    read group
    GROUPNAME=`getent group $group`

done
echo "creating group $group..."
groupadd $group

echo "how many users you want add to the group $group?"
echo -n "enter a value: "
read qtd

COUNT=0

while test ! $COUNT -eq $qtd; do
    echo -n "enter the name of the user: "
    read user

    USERNAME=`getent passwd $user`
    while test ! -z $USERNAME; do
        echo "this username already exist, try another."
        echo -n "enter the name of the user: "
        read user
        USERNAME=`getent passwd $user`
    done

    echo "creating user $user..."
    useradd -b /bin/bash -g $group -b /home -m $user

    echo "now set the password for the user $user"
    passwd $user

    echo "setting the  directory's ownerships"
    chmod ug+rwx,o=t /home/$user
    COUNT=$(($COUNT + 1))
done
