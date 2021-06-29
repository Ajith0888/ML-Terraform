#!/bin/bash
#This Script will helps to get the Private & Public Subnets CIDR. Need to pass the input as Region,Service ID
source ../aws_env
THISREGION=$1
SERVICEID=$2
# Gets the VPC id in which the DHS service is running
aws ec2 describe-instances --region $THISREGION --filters "Name=tag:marklogic:stack:name,Values=$SERVICEID" --query "Reservations[0].Instances[0].VpcId" | jq -r '.'
VPCID=$(aws ec2 describe-instances --region $THISREGION --filters "Name=tag:marklogic:stack:name,Values=$SERVICEID" --query "Reservations[0].Instances[0].VpcId" | jq -r '.')
#Get Private Subnets Using VPC.
echo -e "Private Subnets CIDR Associated to the VPC: $VPCID"
aws ec2 describe-subnets --filters Name=vpc-id,Values=$VPCID Name=tag:aws:cloudformation:logical-id,Values=PrivateSubnet* --query "Subnets[*].CidrBlock" | jq -r '.[]'
#Get Private Subnets Using VPC.
echo -e "\nPublic Subnets CIDR Associated to the VPC: $VPCID"
aws ec2 describe-subnets --filters Name=vpc-id,Values=$VPCID Name=tag:aws:cloudformation:logical-id,Values=PublicSubnet* --query "Subnets[*].CidrBlock" | jq -r '.[]'
