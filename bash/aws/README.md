# security group awscli

#get security group id from here
sg_id=$(aws ec2 create-security-group --description "allow SSH from my home IP" --group-name "SSHChaksSG" | grep -w "sg-*" | awk {'print $2'})
echo $sg_id

#setup an SSH ingress rule for my home IP. so portrange is from 22 to 22. So only port 22 is allowed
aws ec2 authorize-security-group-ingress --group-id ${sg_id}  --ip-permissions '[{"IpProtocol": "tcp", "FromPort": 22, "ToPort": 22, "IpRanges": [{"CidrIp": "1.2.3.4/16", "Description": "SSH access from my home"}]}]'

#remove default egress rule from newly created security group
aws ec2 revoke-security-group-egress --group-id ${sg_id} --protocol all --port all --cidr 0.0.0.0/0		#we don't need to send all traffic to outside

#setup egress rule
aws ec2 authorize-security-group-egress --group-id ${sg_id}  --ip-permissions '[{"IpProtocol": "tcp", "FromPort": 80, "ToPort": 80, "IpRanges": [{"CidrIp": "1.2.3.4/16", "Description": "HTTP access from ABC office"}]}]'
