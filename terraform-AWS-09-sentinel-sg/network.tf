resource "aws_vpc" "hdcard-vpc" {
  cidr_block = "172.16.0.0/16"

  tags = {
    Name = "hdcard-poc"
  }
}

resource "aws_subnet" "hdcard-subnet" {
  vpc_id            = aws_vpc.hdcard-vpc.id
  cidr_block        = "172.16.1.0/24"

  tags = {
    Name = "hdcard-poc"
  }
}

resource "aws_security_group" "hdcard-sg" {
  name        = "hdcard-sg"
  vpc_id      = aws_vpc.hdcard-vpc.id

  ingress {
    description      = "ssh"
    from_port        = 0
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = [aws_vpc.hdcard-vpc.cidr_block]
    # cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "hdcard-poc"
  }
}