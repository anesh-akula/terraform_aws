provider "aws" {
  region = "us-east-2"
}

resource "aws_vpc" "terraformvpc" {
  cidr_block           = "192.168.0.0/16"
  instance_tenancy     = "default"
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags {
    Name = "main"
  }
}

resource "aws_subnet" "terraformsubnet" {
  vpc_id     = "$ {aws_vpc.terraformvpc.id}" # interpolation
  cidr_block = "192.168.1.0/24"

  tags {
    Name = "tagsubnet"
  }
}
