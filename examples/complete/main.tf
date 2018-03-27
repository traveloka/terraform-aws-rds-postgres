provider "aws" {
  region = "ap-southeast-1"
}

module "postgres" {
  source = "../../"

  product_domain = "bei"
  service_name   = "beitest"
  environment    = "special"
  description    = "Testing purpose"

  instance_class = "db.t2.small"
  engine_version = "9.6.6"

  allocated_storage = 1024

  multi_az = false

  # Change to valid security group id
  vpc_security_group_ids = [
    "sg-50036436"
  ]

  # Change to valid db subnet group nam
  db_subnet_group_name = "tvlk-dev-rds-subnet-group"

  # Change to valid parameter group name
  parameter_group_name = "default.postgres9.6"

  maintenance_window      = "Mon:00:00-Mon:03:00"
  backup_retention_period = 0

  skip_final_snapshot = true

  # Change to valid monitoring role arn
  monitoring_role_arn = "arn:aws:iam::517530806209:role/rds-monitoring-role"
}
