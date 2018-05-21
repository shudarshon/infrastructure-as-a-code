resource "random_id" "GoldenAmiID" {
  byte_length = 8
}

resource "aws_ami_from_instance" "GoldenAMI" {
  name               = "wp_ami-${random_id.GoldenAmiID.b64}"
  source_instance_id = "${aws_instance.DevInstanceAWS.id}"
}

resource "null_resource" "CreateAmiUserData" {
  provisioner "local-exec" {
    command = "echo #!/bin/bash > userdata"
  }
  provisioner "local-exec" {
    command = "echo '/usr/bin/aws s3 sync s3://${aws_s3_bucket.code.bucket} /var/www/html/' >> userdata"
  }
  provisioner "local-exec" {
    command = "echo /bin/touch /var/spool/cron/root >> usedata"
  }
  provisioner "local-exec" {
    command = "echo sudo /bin/echo '*/5 * * * * aws s3 sync s3://${aws_s3_bucket.code.bucket} /var/www/html/ >> /var/spool/cron/root' >> userdata"
  }
}
