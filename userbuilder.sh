#!/bin/bash

echo -n "enter the group name: "
read group

GROUPNAME=`getent group $group`
while test ! -z $GROUPNAME; do
    echo "this group already exist, try another."
    echo -n "enter the group name: "
    read group
    GROUPNAME=`getent group $group`

done

groupadd $group

echo -n "enter the name of the user: "
read user

USERNAME=`getent passwd $user`
while test ! -z $USERNAME; do
    echo "this username already exist, try another."
    echo -n "enter the name of the user: "
    read user
    USERNAME=`getent passwd $user`
done

useradd -b /bin/bash -g $group -b /home -d $user -m $user

echo "now set the password for the user $user"
passwd $user

echo "setting the  directory's ownerships"
chmod ug+rwx,o+t /home/$user
