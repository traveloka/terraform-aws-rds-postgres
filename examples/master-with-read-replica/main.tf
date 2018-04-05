provider "aws" {
  region = "ap-southeast-1"
}

module "txtbook_postgres_1" {
  source = "../../"

  apply_immediately = true

  product_domain = "txt"
  service_name   = "txtbook"
  environment    = "production"
  description    = "Postgres to store Tesla Extranet booking data"

  instance_class    = "db.t2.small"
  engine_version    = "9.6.6"
  allocated_storage = 20

  # Change to valid security group id
  vpc_security_group_ids = [
    "sg-50036436",
  ]

  # Change to valid db subnet group nam
  db_subnet_group_name = "tvlk-dev-rds-subnet-group"

  # Change to valid parameter group name
  parameter_group_name = "default.postgres9.6"

  maintenance_window      = "Mon:00:00-Mon:03:00"
  backup_window           = "21:00-23:00"
  backup_retention_period = 1

  # Change to valid monitoring role arn
  monitoring_role_arn = "arn:aws:iam::517530806209:role/rds-monitoring-role"
}

module "txtbook_postgres_2" {
  source = "../../"

  apply_immediately = true

  product_domain = "txt"
  service_name   = "txtbook"
  environment    = "production"
  description    = "Read replica of txtbook postgres for analytic purpose"

  # Indicates that this is a read replica
  replicate_source_db = "${module.txtbook_postgres_1.id}"

  instance_class = "db.t2.small"

  # Make sure that this is always identical to the master's
  allocated_storage = 20

  # Set the read replica AZ to be the master's AZ
  availability_zone = "${module.txtbook_postgres_1.availability_zone}"

  # Change to valid security group id
  vpc_security_group_ids = [
    "sg-cb8165ac",
  ]

  # Change to valid parameter group name
  parameter_group_name = "acs-shared-postgres"

  maintenance_window = "Mon:21:00-Mon:23:00"

  # Change to valid monitoring role arn
  monitoring_role_arn = "arn:aws:iam::517530806209:role/rds-monitoring-role"
}
