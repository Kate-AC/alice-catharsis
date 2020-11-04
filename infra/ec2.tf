module "step_sg" {
  source      = "./security_group"
  name        = "step_sg"
  vpc_id      = aws_vpc.current.id
  port        = 5022
  cidr_blocks = ["0.0.0.0/0"]
}

data "aws_ami" "step" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "architecture"
    values = ["x86_64"]
  }

  filter {
    name   = "root-device-type"
    values = ["ebs"]
  }

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  filter {
    name   = "block-device-mapping.volume-type"
    values = ["gp2"]
  }

  filter {
    name   = "state"
    values = ["available"]
  }
}

resource "aws_instance" "step" {
  ami            = data.aws_ami.step.image_id
  subnet_id      = aws_subnet.public_a.id
  key_name       = aws_key_pair.step.id
  instance_type  = "t3.nano"

  vpc_security_group_ids = [
    module.step_sg.security_group_id
  ]

  user_data = <<EOF
    #!/bin/sh -ex
    /bin/sed -i -e 's/^#Port 22$/Port 5022/' /etc/ssh/sshd_config
    service sshd restart
EOF

  tags = {
    Name = "${var.env}"
  }
}

resource "aws_eip" "step" {
  instance = aws_instance.step.id
  vpc      = true
}

resource "aws_key_pair" "step" {
  key_name   = "step_key"
  public_key = file("~/.ssh/id_rsa.pub")
}

output "public_ip" {
  value = aws_eip.step.public_ip
}

