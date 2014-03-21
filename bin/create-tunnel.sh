#!/bin/bash 

echo "create-tunnel called for " $JEFF_NODE_TYPE

if [ "$JEFF_NODE_TYPE" == "master" ]; then
nohup ssh -o "StrictHostKeyChecking no" -o UserKnownHostsFile=~/app-root/data/known_hosts \
-i ~/app-root/data/pg932_rsa_key \
-N -L \
$OPENSHIFT_PG_HOST:15000:$JEFF_STANDBY_IP:5432 \
$JEFF_STANDBY_USER@$JEFF_STANDBY_DNS &> /dev/null &
fi

if [ "$JEFF_NODE_TYPE" == "standby" ]; then
nohup ssh -o "StrictHostKeyChecking no" -o UserKnownHostsFile=~/app-root/data/known_hosts \
-i ~/app-root/data/pg932_rsa_key \
-N -L \
$OPENSHIFT_PG_HOST:15000:$JEFF_MASTER_IP:5432 \
$JEFF_MASTER_USER@$JEFF_MASTER_DNS &> /dev/null &
fi

