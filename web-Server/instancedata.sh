#!/bin/bash

# create file 
touch "metadata.txt"

# get and store date to metadata.txt
# hostname
curl http://instance-data/latest/meta-data/hostname > metadata.txt
# iam info
curl -w "\n" http://instance-data/latest/meta-data/iam/info >> metadata.txt
# security group
curl -w "\n" http://instance-data/latest/meta-data/security-groups >> metadata.txt
