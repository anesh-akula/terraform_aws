variable "region" {
  default = "us-east-2"
}

variable "vpc_cidr" {
  default = "192.168.0.0/16"
}

variable "subnet" {
  default = "192.168.1.0/24"
}

variable "avalibility_zone" {
  type    = "list"
  default = ["us-east-2a", "us-east-2b", "us-east-2c"]
}
