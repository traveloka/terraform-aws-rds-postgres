data "aws_security_group" "bastion" {
  filter {
    name   = "group-name"
    values = ["${var.product_domain}bstn-postgres"]
  }

  vpc_id = "vpc-32b41f57"
}
