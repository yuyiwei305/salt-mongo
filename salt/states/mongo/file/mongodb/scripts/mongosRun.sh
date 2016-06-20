#!/bin/bash
ps -aux|grep "mongos -f /etc/mongodb/mongos.conf" |grep -v grep
if [ $? -ne 0 ]
then
mongos -f /etc/mongodb/mongos.conf &> /dev/null
echo "start process ...."
else
echo "running"
fi
