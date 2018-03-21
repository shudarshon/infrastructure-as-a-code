aws_profile		     = "myprofile"    #aws profiling can make it easy to use terraform on specific aws account from aws profile environment variable
aws_region 		     = "us-east-1"
db_instance_class  = "db.t2.micro"  #rds type instances
dbname 			       = "testdb"
dbuser 			       = "test"
dbpassword 		     = "testpass"

dev_instance_type  = "t2.micro"
dev_ami 		       = "ami-26ebbc5c"
localip            = "103.216.59.40/32"
key_name 		       = "id_rsa"
public_key_path 	 = "/home/ubuntu/.ssh/id_rsa.pub"
key_path           = "/home/ubuntu/keyfile/secret.pem"  #use this variable only when you want to use existing keys in aws
