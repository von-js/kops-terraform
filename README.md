# Using Terraform to privision AWS Resources(VPC, S3 etc) and Kops to provision the Kubernetes Cluster
# This will create a Kubernetes Highly Available cluster all in free tier

## AWS/KOPS Envirnment setup 

export AWS_ACCESS_KEY_ID=`grep aws_access_key_id ~/.aws/credentials|awk '{print $3}'`

export AWS_SECRET_ACCESS_KEY=`grep aws_secret_access_key ~/.aws/credentials|awk '{print $3}'`

export CLUSTER_NAME={name of your cluster}

export NAME=${CLUSTER_NAME}.k8s.local

export KOPS_STATE_STORE=s3://{create a bucket and copy the name here}

## Create AWS resources
Modify the variable.tf if necessary
 run: terraform init
      terraform plan
      terraform apply
      
 ## Change the access permission of kops.sh 
 Read first the instruction in kops.sh
 run: chmod +x kops.sh
      ./kops.sh
 
 ## Then the cluster will be automatically provisioned
