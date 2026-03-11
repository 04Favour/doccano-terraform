data "aws_ami" "ubuntu" {
    most_recent = true

    filter {
        name = "name"
        values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
    }

    filter {
        name = "virtualization-type"
        values = ["hvm"]
    }

    owners = ["099720109477"]
}

resource "aws_instance" "doccano_server" {
  ami = data.aws_ami.ubuntu.id
  instance_type = "t2.small"
  subnet_id = aws_subnet.public_subnet.id
  key_name = aws_key_pair.generated_key.key_name
  vpc_security_group_ids = [aws_security_group.doccano_sg.id]

  tags = {Name = "doccano-app-server"}
}

resource "aws_key_pair" "generated_key" {
  key_name = "doccano-key"
  public_key = tls_private_key.rsa_key.public_key_openssh
}

resource "tls_private_key" "rsa_key" {
  algorithm = "RSA"
  rsa_bits = 4096
}