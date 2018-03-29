terraform-aws-rds-postgres
==========================
Terraform module which creates an AWS RDS Postgres Read Replica instance and Route 53 record set.

Requirements
------------

- An existing VPC
- An existing DB subnet group
- An existing Postgres parameter group
- An existing Enhanced Monitoring role
- An existing Route 53 hosted zone
- Existing DB security groups

Usage
-----

```hcl
module "read_replica" {
  source  = "github.com/traveloka/terraform-aws-rds-postgres//modules/read-replica"
  version = "0.1.0"

  product_domain = "bei"
  service_name   = "beitest"
  environment    = "special"
  description    = "Read replica"

  replicate_source_db = "${module.master.id}"

  instance_class = "db.t2.small"

  # Change to valid security group id
  vpc_security_group_ids = [
    "sg-50036436"
  ]

  availability_zone = "${aws_db_instance.master.availability_zone}"

  # Change to valid db subnet group nam
  db_subnet_group_name = "tvlk-dev-rds-subnet-group"

  # Change to valid parameter group name
  parameter_group_name = "default.postgres9.6"

  maintenance_window = "Mon:00:00-Mon:03:00"

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
