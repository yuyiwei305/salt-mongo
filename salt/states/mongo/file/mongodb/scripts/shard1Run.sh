#!/bin/bash
ps -aux|grep "mongod -f /etc/mongodb/shard1.conf" |grep -v grep
if [ $? -ne 0 ]
then
mongod -f /etc/mongodb/shard1.conf &> /dev/null
echo "start process ...."
else
echo "running"
fi
