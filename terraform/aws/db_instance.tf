# RDS

resource "aws_db_instance" "db" {
  identifier = "tf-test-db"
  multi_az = "false"
  allocated_storage = 10
  engine    = "mysql"
  engine_version  = "5.6.27"
  instance_class  = "${var.db_instance_class}"
  name      = "${var.dbname}"
  username    = "${var.dbuser}"
  password    = "${var.dbpassword}"
  storage_type = "gp2"
  skip_final_snapshot = true    #without this option terraform destroy command throws some error
  db_subnet_group_name  = "${aws_db_subnet_group.rds_subnetgroup.name}"
  vpc_security_group_ids = ["${aws_security_group.RDS.id}"]
}
