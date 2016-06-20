#!/bin/bash
ps -aux|grep "mongod -f /etc/mongodb/config.conf" |grep -v grep
if [ $? -ne 0 ]
then
mongod -f /etc/mongodb/config.conf &> /dev/null
echo "start process ...."
else
echo "running"
fi
