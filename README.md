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

Password for Master DB
----------------------

- The module will generate a random 16 characters long password.
- The module will output this password.
- Make sure that you change the password after the provisioning is successfully completed.

Read Replica
------------

If `replicate_source_db` parameter is defined, it indicates that the instance is meant to be a read replica.

These parameters will be inherited from the master's in the first creation stage:
1. allocated_storage
2. maintenance_window
3. parameter_group_name 
4. vpc_security_group_ids

To apply different values for the parameters above, you have to re-apply the configuration after the first creation is finished.

Some default values are changed for read replica instance:
- `backup_retention_period = 0`
  Postgres read replica does not support automated backup.

- `skip_final_snapshot = true`
  When deleting a read replica, a final snapshot cannot be created.

- `copy_tags_to_snapshot = false`
  When deleting a read replica, a final snapshot is not created.

### How to promote a read replica?

These steps need to be done in sequence:
1. Remove parameter `replicate_source_db`
   This is to indicate that the instance is meant to be a master instance.

2. Add parameter `backup_retention_period = 0`
   We need to explicitly disable automated backup for now, otherwise Terraform will complain that a read replica does not support automated backup.

3. Apply the configuration and wait for db instance to be successfully promoted to master

4. Modify parameter `multi_az`
   This is to enable multi AZ. Either set it explicitly or leave as default.

5. Modify parameter `backup_retention_period`
   This is to enable automated backup. Either set it explicitly or leave as default.

6. Add parameter `backup_window`
   Either set it explicitly or leave as default.

7. Modify other parameters as you would to a master instance

8. Apply the configuration again

Usage
-----

```hcl
module "postgres" {
  source  = "github.com/traveloka/terraform-aws-rds-postgres?ref=v0.2.0"

  product_domain = "txt"
  service_name   = "txtinv"
  environment    = "production"
  description    = "Postgres to store Transport Extranet (txt) inventory data"

  instance_class = "db.t2.small"
  engine_version = "9.6.6"

  allocated_storage = 100

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
