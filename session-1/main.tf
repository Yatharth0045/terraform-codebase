//resource "aws_vpc" "vpc" {
//  cidr_block = var.vpc_cidr
//  enable_dns_hostnames = true
//  tags = {
//    Name = "demo-vpc"
//  }
//}


data "aws_availability_zones" "available" {
  state = "available"
}

output "azs" {
  value = data.aws_availability_zones.available.names
}
//
//resource "aws_subnet" "public-subnet" {
//  vpc_id     = aws_vpc.vpc.id
//  availability_zone = data.aws_availability_zones.available.names[0]
//  cidr_block = "10.0.0.0/17"
//  map_public_ip_on_launch = true
//
//  tags = {
//    Name = "public-subnet"
//  }
//}
//
//resource "aws_subnet" "private-subnet" {
//  vpc_id     = aws_vpc.vpc.id
//  availability_zone = data.aws_availability_zones.available.names[1]
//  cidr_block = "10.0.128.0/17"
//
//  tags = {
//    Name = "private-subnet"
//  }
//}
//
//resource "aws_internet_gateway" "gw" {
//  vpc_id = aws_vpc.vpc.id
//
//  tags = {
//    Name = "demo-igw"
//  }
//}
//
//resource "aws_eip" "nat-eip" {
//  tags = {
//    Name = "demo-eip"
//  }
//}
//
//resource "aws_nat_gateway" "nat-gw" {
//  allocation_id = aws_eip.nat-eip.id
//  subnet_id     = aws_subnet.public-subnet.id
//
//  tags = {
//    Name = "demo-nat-gw"
//  }
//}
//
//resource "aws_route_table" "public-rt" {
//  vpc_id = aws_vpc.vpc.id
//
//  route {
//    cidr_block = "0.0.0.0/0"
//    gateway_id = aws_internet_gateway.gw.id
//  }
//
//  tags = {
//    Name = "public-route-table"
//  }
//}
//
//resource "aws_route_table" "private-rt" {
//  vpc_id = aws_vpc.vpc.id
//
//  route {
//    cidr_block = "0.0.0.0/0"
//    nat_gateway_id = aws_nat_gateway.nat-gw.id
//  }
//
//  tags = {
//    Name = "private-route-table"
//  }
//}
//
//resource "aws_route_table_association" "public-rta" {
//  subnet_id      = aws_subnet.public-subnet.id
//  route_table_id = aws_route_table.public-rt.id
//}
//
//resource "aws_route_table_association" "private-rta" {
//  subnet_id      = aws_subnet.private-subnet.id
//  route_table_id = aws_route_table.private-rt.id
//}
//
//data "aws_ami" "ubuntu" {
//  most_recent = true
//
//  filter {
//    name   = "name"
//    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
//  }
//
//  filter {
//    name   = "virtualization-type"
//    values = ["hvm"]
//  }
//
//  owners = ["099720109477"] # Canonical
//}
//
//resource "aws_security_group" "public_instance" {
//  name        = "allow_ssh_http"
//  description = "Allow Http and SSh"
//  vpc_id      = aws_vpc.vpc.id
//
//  ingress {
//    from_port   = 80
//    to_port     = 80
//    protocol    = "tcp"
//    cidr_blocks = ["0.0.0.0/0"]
//  }
//
//  ingress {
//    from_port   = 22
//    to_port     = 22
//    protocol    = "tcp"
//    cidr_blocks = ["0.0.0.0/0"]
//  }
//
//  egress {
//    from_port   = 0
//    to_port     = 0
//    protocol    = "-1"
//    cidr_blocks = ["0.0.0.0/0"]
//  }
//
//  tags = {
//    Name = "demo-public-sg"
//  }
//}
//
//resource "aws_instance" "web" {
//  ami           = data.aws_ami.ubuntu.id
//  instance_type = "t3.micro"
//  key_name = "demo-key"
//  subnet_id = aws_subnet.public-subnet.id
//  security_groups = [aws_security_group.public_instance.id]
//  disable_api_termination      = false
//  ebs_optimized                = false
//  hibernation                  = false
//  monitoring                   = false
//  user_data = file("script.sh")
//  tags = {
//    Name = "public-instance"
//  }
//}
//
//resource "aws_security_group" "private_instance" {
//  name        = "allow_ssh"
//  description = "Allow SSh"
//  vpc_id      = aws_vpc.vpc.id
//
//  ingress {
//    from_port   = 22
//    to_port     = 22
//    protocol    = "tcp"
//    cidr_blocks = [aws_vpc.vpc.cidr_block]
//  }
//
//  egress {
//    from_port   = 0
//    to_port     = 0
//    protocol    = "-1"
//    cidr_blocks = ["0.0.0.0/0"]
//  }
//
//  tags = {
//    Name = "demo-private-sg"
//  }
//}
//
//resource "aws_instance" "private_instance" {
//  ami           = data.aws_ami.ubuntu.id
//  instance_type = "t3.micro"
//  key_name = "demo-key"
//  subnet_id = aws_subnet.private-subnet.id
//  disable_api_termination      = false
//  ebs_optimized                = false
//  hibernation                  = false
//  monitoring                   = false
//  security_groups = [aws_security_group.private_instance.id]
//
//  tags = {
//    Name = "private-instance"
//  }
//}