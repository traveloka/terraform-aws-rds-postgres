data "aws_security_group" "bastion" {
  filter {
    name   = "group-name"
    values = ["${var.product_domain}bstn-mongod"]
  }

  vpc_id = "vpc-32b41f57"
}
