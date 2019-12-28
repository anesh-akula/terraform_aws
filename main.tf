resource "aws_instance" "testing_terraform" {
  ami           = "ami-0080e4c5bc078760e"
  instance_type = "t2.micro"
  key_name      = "useast1"

  root_block_device = {
    delete_on_termination = true
    volume_type           = "gp2"
    volume_size           = 9
  }

  ebs_block_device = [{
    device_name           = "/dev/xvdb"
    volume_type           = "gp2"
    volume_size           = 1
    delete_on_termination = false
    encrypted             = false
  }]

  depends_on             = ["aws_vpc.terraform_vpc"]
  vpc_security_group_ids = "${aws_vpc.terraform_vpc.id}"
  subnet_id              = "${aws_vpc.terraform_vpc.id}"

  #iam_instance_profile = # iam role    
  instance_initiated_shutdown_behavior = "stop"
  disable_api_termination              = false
  monitoring                           = false
  tenancy                              = "default" # default,host,dedicated ,

  # network_interface                    = "${aws_network_interface.network.id}"


  #credit_specification = {
  # cpu_credits = "default" #unlimited or standard
  #}

  tags = {
    "Name" = "instance-tag1"
  }
}
