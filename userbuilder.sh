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
echo "$group"

echo -n "enter the name of the user: "
read user

USERNAME=`getent passwd $user`
while test ! -z $USERNAME; do
    echo "this username already exist, try another."
    echo -n "enter the name of the user: "
    read user
    USERNAME=`getent passwd $user`
done

useradd -b /bin/bash -g $group -b / -d $user $user


#groupadd $group