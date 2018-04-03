terraform-aws-rds-postgres
==========================
Terraform module which creates an AWS RDS Postgres.

Requirements
------------

- An existing VPC
- An existing DB subnet group
- An existing Postgres parameter group
- An existing RDS Enhanced Monitoring role
- Existing DB security groups

Usage
-----

```hcl
module "postgres" {
  source  = "github.com/traveloka/terraform-aws-rds-postgres"
  version = "0.1.0"

  product_domain = "txt"
  service_name   = "txtinv"
  environment    = "production"
  description    = "Postgres to store Transport Extranet (txt) inventory data"

  instance_class = "db.t2.small"
  engine_version = "9.6.6"

  allocated_storage = 1024

  multi_az = true

  # Change to valid security group id
  vpc_security_group_ids = [
    "sg-50036436"
  ]

  # Change to valid db subnet group name
  db_subnet_group_name = "tvlk-dev-rds-subnet-group"

  # Change to valid parameter group name
  parameter_group_name = "default.postgres9.6"

  maintenance_window      = "Mon:00:00-Mon:03:00"
  backup_retention_period = 0

  skip_final_snapshot = true

  # Change to valid monitoring role arn
  monitoring_role_arn = "arn:aws:iam::517530806209:role/rds-monitoring-role"

  # Change to valid route 53 zone id
  route53_zone_id = "Z32OEBZ2VZHSJZ"
}
```

Authors
-------

- [Andy Saputra](https://github.com/andysaputra)

License
-------

Apache 2 Licensed. See LICENSE for full details.
