#!/bin/bash

# NOTE!
# Before running the command. Expose this data firs in your cli
# export AWS_ACCESS_KEY_ID=`grep aws_access_key_id ~/.aws/credentials|awk '{print $3}'`
# export AWS_SECRET_ACCESS_KEY=`grep aws_secret_access_key ~/.aws/credentials|awk '{print $3}'`
# export NAME=${CLUSTER_NAME}.k8s.local
# export KOPS_STATE_STORE=s3://{BUCKET NAME}
kops create cluster \
--vpc=$(terraform output vpc_id) \
--master-zones=$(terraform output -json networks | jq -r '.[].availability_zone' | paste -sd, -) \
--zones=$(terraform output -json networks | jq -r '.[].availability_zone' | paste -sd, -) \
--subnets=$(terraform output -json subnet_ids | jq -r 'join(",")') \
--node-count=2 \
--master-size=t2.micro \
--node-size=t2.micro \
--name=${NAME} # --dry-run -o yaml

# Then run 
# kops update cluster ${NAME} --yes
# kops validate cluster --wait 10m
# kubectl get nodes --show-labels
