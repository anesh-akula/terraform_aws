variable "ami" {
  type = "map"

  default = {
    us-west-1 = "image-1234"
    us-east-2 = "iamge-1234"
  }
}
