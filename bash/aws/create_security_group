#!/bin/bash
#

#Goal of this script is to create security group in the AWS in an automated way

# Fail
function fail(){
	tput setaf 1; echo "Failure: $*" && tput sgr0
	exit 1
}

#check if awsclis is installed or not
function check_aws(){
	if ! type aws >/dev/null; then
		fail "AWS cli is not installed. Please run \"pip install awscli\"."
	fi
}

# check if AWS CLI credentials are setup
function check_aws_config(){
	if ! grep -q aws_access_key_id ~/.aws/config ; then
  		if ! grep -q aws_access_key_id ~/.aws/credentials ; then
    		fail "AWS config not found or CLI not installed. Please run \"aws configure\"."
  		fi
	fi
}


#remove default egress rule from the security group
function remove_default_egress_rule(){
	aws ec2 revoke-security-group-egress --group-id $1 --protocol all --port all --cidr 0.0.0.0/0		#we don't need to send all traffic to outside
	printf "\n####################Default egress rule was deleted#####################\n"
}

#add webserver egress rule in the security group
function add_web_server_ingress_egress_rule(){
	sg_id=$1
	#read -p "Enter IP address for web server traffic (0.0.0.0/0 or sgLoadBalancer): " ip
	ip="0.0.0.0/0"
	description="webserver-traffic"	#write description as the same way i have
	ws_port="80 443"
	printf "\n ###########################Creating Web Server Security Group#############################"
	for port in $ws_port
	do
		aws ec2 authorize-security-group-egress --group-id ${sg_id} --ip-permissions '[{"IpProtocol": "tcp", "FromPort": '${port}', "ToPort": '${port}', "IpRanges": [{"CidrIp": '\"${ip}\"', "Description": '\"${description}\"'}]}]'
		aws ec2 authorize-security-group-ingress --group-id ${sg_id} --ip-permissions '[{"IpProtocol": "tcp", "FromPort": '${port}', "ToPort": '${port}', "IpRanges": [{"CidrIp": '\"${ip}\"', "Description": '\"${description}\"'}]}]'
	done
	printf "\n ###############################web server security group created###########################\n"
}

#setup an SSH ingress rule for a particular source. so portrange is from 22 to 22. So only port 22 is allowed
function add_ssh_ingress_rule(){
	read -p "Enter source IP address for SSH(eg. 192.168.1.0/32): " ip
	read -p "Enter description for above IP address(eg. office-ip): " description
	aws ec2 authorize-security-group-ingress --group-id $1 --ip-permissions '[{"IpProtocol": "tcp", "FromPort": 22, "ToPort": 22, "IpRanges": [{"CidrIp": '\"${ip}\"', "Description": '\"${description}\"'}]}]'
}

#create security group
function create_security_group(){
	read -p "Enter security group description: " description
	read -p "Enter security group name(WebServerSG): " sg_name
	sg_id=$(aws ec2 create-security-group --description "${description}" --group-name "${sg_name}" | grep -w "sg-*" | awk {'print $2'})
	sg_id=${sg_id:1:-1}	#removing double quotation from the value
	printf "\n#########################Removing defualt egress rule from ${sg_id} security group###########################\n"
	remove_default_egress_rule ${sg_id}
	add_web_server_ingress_egress_rule ${sg_id}
	add_ssh_ingress_rule ${sg_id}
}

check_aws
check_aws_config
create_security_group
