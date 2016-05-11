#! /usr/bin/bash


systemctl stop firewalld
systemctl disable firewalld
setenforce 0

yum -y install epel*
yum -y install salt-master salt-minion
sleep 5
cp -a ./salt /srv
cp -a ./config/* /etc/salt/
sleep 1
service salt-master start
service salt-minion start 

