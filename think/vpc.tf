resource "aws_vpc" "terraform_vpc" {
  cidr_block           = "40.1.0.0/16"
  enable_dns_hostnames = true
  enable_dns_support   = true
  instance_tenancy     = "default"

  tags = {
    Name = "terraform_tag"
  }
}

# create Internet Gateway and attached to project_vpc
resource "aws_internet_gateway" "project_igw" {
  vpc_id = "${aws_vpc.terraform_vpc.id}"

  tags {
    Name = "tag_igw"
  }
}

# Create a Subnet

resource "aws_subnet" "terraform_subnet" {
  vpc_id                  = "${aws_vpc.terraform_vpc.id}"
  cidr_block              = "40.1.1.0/16"
  availability_zone       = "us-east-1c"
  map_public_ip_on_launch = true

  tags = {
    Name = "terraform_subnet_tag"
  }
}

# create Network Interface

resource "aws_network_interface" "network" {
  subnet_id   = "${aws_subnet.terraform_subnet.id}"
  private_ips = ["40.1.1.86"]

  tags = {
    Name = "terraform_network_tag"
  }
}

# Create Network Acess control list
resource "aws_network_acl" "network_acl" {
  subnet_ids = ["${aws_subnet.terraform_subnet.id}"]
  vpc_id     = "${aws_vpc.terraform_vpc.id}"
}

# creating rule  for Network Acess control list
resource "aws_network_acl_rule" "acl1" {
  network_acl_id = "${aws_network_acl.network_acl.id}"
  rule_number    = 200
  egress         = true
  protocol       = "-1"
  rule_action    = "allow"
  cidr_block     = "0.0.0.0/0"
}

# creating rule 2  for Network Acess control list
resource "aws_network_acl_rule" "acl2" {
  network_acl_id = "${aws_network_acl.network_acl.id}"
  rule_number    = 200
  protocol       = "-1"
  rule_action    = "allow"
  cidr_block     = "0.0.0.0/0"
}

# Create Route table,  attach it internet Gateway and associate with public subnets

resource "aws_route_table" "terraform_route_table" {
  vpc_id = "${aws_vpc.terraform_vpc.id}"

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.project_igw.id}"
  }

  tags {
    Name = "route_igw_create"
  }
}

# Attach route table with subnets # create Route Table Association  --- subnet,route table id
resource "aws_route_table_association" "association" {
  subnet_id      = "${aws_subnet.terraform_subnet.id}"
  route_table_id = "${aws_route_table.terraform_route_table.id}"

  tags {
    Name = "route_association"
  }
}

# Create Security Group 

resource "aws_security_group" "terraform_security_group" {
  vpc_id = "${aws_vpc.terraform_vpc.id}"

  ingress {
    protocol    = "tcp"
    from_port   = 22
    to_port     = 22
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    protocol    = "tcp"
    from_port   = 80
    to_port     = 80
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    protocol         = "tcp"
    from_port        = 443
    to_port          = 443
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  egress {
    protocol    = -1
    from_port   = 0
    to_port     = 0
    cidr_blocks = ["0.0.0.0/0"]
  }
}
