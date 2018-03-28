provider "aws" {
  region = "${var.aws_region}"
}

# key pair

resource "aws_key_pair" "auth" {
  key_name  ="${var.key_name}"
  public_key = "${file(var.public_key_path)}"
  #key_file = "${var.key_path}"   # uncomment if you want to use existing ssh key
}


# server

resource "aws_instance" "dev" {
  instance_type = "${var.dev_instance_type}"
  ami = "${var.dev_ami}"
  tags {
    Name = "app-instance"
  }

  key_name = "${aws_key_pair.auth.id}"
  vpc_security_group_ids = ["${aws_security_group.public.id}"]
  subnet_id = "${aws_subnet.public.id}"


  provisioner "local-exec" {
      command = <<EOD
cat <<EOF > hosts
[dev]
${aws_instance.dev.public_ip}
EOF
EOD
  }

  provisioner "local-exec" {
    command = "sleep 6m && ansible-playbook -i hosts app.yml"
  }
}
