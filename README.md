# terraform-aws-rds-postgres

[![Release](https://img.shields.io/github/release/traveloka/terraform-aws-rds-postgres.svg)](https://github.com/traveloka/terraform-aws-rds-postgres/releases)
[![Last Commit](https://img.shields.io/github/last-commit/traveloka/terraform-aws-rds-postgres.svg)](https://github.com/traveloka/terraform-aws-rds-postgres/commits/master)
![Open Source Love](https://badges.frapsoft.com/os/v1/open-source.png?v=103)

## Description

Terraform module which creates an AWS RDS Postgres.


## Prerequisites

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


## Dependencies

This Terraform module have no dependencies to another modules


## Getting Started

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

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| aws | n/a |
| random | n/a |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| additional\_tags | The additional aws\_db\_instance tags that will be merged over the default tags | `map` | `{}` | no |
| allocated\_storage | The allocated storage in gigabytes. For read replica, set the same value as master's | `string` | n/a | yes |
| allow\_major\_version\_upgrade | Indicates that major version upgrades are allowed | `string` | `"false"` | no |
| apply\_immediately | Specifies whether any database modifications are applied immediately, or during the next maintenance window | `string` | `"false"` | no |
| auto\_minor\_version\_upgrade | Indicates that minor engine upgrades will be applied automatically to the DB instance during the maintenance window | `string` | `"false"` | no |
| availability\_zone | The AZ for the RDS instance. It is recommended to only use this when creating a read replica instance | `string` | `""` | no |
| backup\_retention\_period | The days to retain backups for | `string` | `7` | no |
| backup\_window | The daily time range (in UTC) during which automated backups are created if they are enabled. Before and not overlap with maintenance\_window | `string` | `""` | no |
| bastion\_security\_group\_id | bastion security groups to associate | `string` | n/a | yes |
| ca\_cert\_identifier | Specifies the identifier of the CA certificate for the DB instance | `string` | `"rds-ca-2019"` | no |
| copy\_tags\_to\_snapshot | On delete, copy all Instance tags to the final snapshot (if final\_snapshot\_identifier is specified) | `string` | `"true"` | no |
| db\_subnet\_group\_name | Name of DB subnet group | `string` | `""` | no |
| deletion\_protection | If the DB instance should have deletion protection enabled. The database can't be deleted when this value is set to true. The default is false | `string` | `false` | no |
| description | The description of this RDS instance | `string` | n/a | yes |
| engine\_version | The postgres engine version | `string` | `""` | no |
| environment | The environment this RDS belongs to | `string` | n/a | yes |
| instance\_class | The instance type of the RDS instance | `string` | n/a | yes |
| iops | The amount of provisioned IOPS. Setting this implies a storage\_type of io1 | `string` | `"0"` | no |
| kms\_key\_id | Specifies a custom KMS key to be used to encrypt | `string` | `""` | no |
| maintenance\_window | The window to perform maintenance in. Syntax: 'ddd:hh24:mi-ddd:hh24:mi' | `string` | n/a | yes |
| monitoring\_interval | The interval, in seconds, between points when Enhanced Monitoring metrics are collected for the DB instance | `string` | `"60"` | no |
| monitoring\_role\_arn | The ARN for the IAM role that permits RDS to send enhanced monitoring metrics to CloudWatch Logs | `string` | n/a | yes |
| multi\_az | Specifies if the RDS instance is multi-AZ | `string` | `"true"` | no |
| parameter\_group\_name | Name of the DB parameter group to associate | `string` | n/a | yes |
| performance\_insights\_enabled | The values which defines if the performance insights for this db will be enabled or not | `string` | `"false"` | no |
| port | The port on which the DB accepts connections | `string` | `"5432"` | no |
| product\_domain | The name of the product domain this RDS belongs to | `string` | n/a | yes |
| replicate\_source\_db | The source db of read replica instance | `string` | `""` | no |
| service\_name | The name of the service this RDS belongs to, this will be part of the database identifier | `string` | n/a | yes |
| skip\_final\_snapshot | Determines whether a final DB snapshot is created before the DB instance is deleted | `string` | `"false"` | no |
| snapshot\_identifier | The snapshot ID used to restore the DB instance | `string` | `""` | no |
| storage\_encrypted | Specifies whether the DB instance is encrypted | `string` | `"true"` | no |
| storage\_type | One of standard (magnetic), gp2 (general purpose SSD), or io1 (provisioned IOPS SSD) | `string` | `"gp2"` | no |
| username | Username for the master DB user | `string` | `"postgres"` | no |
| vpc\_security\_group\_ids | List of VPC security groups to associate | `list` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| address | The address of the RDS instance |
| arn | The ARN of the RDS instance |
| availability\_zone | The availability zone of the instance |
| endpoint | The connection endpoint |
| hosted\_zone\_id | The canonical hosted zone ID of the DB instance (to be used in a Route 53 Alias record) |
| id | The RDS instance ID |
| password | The password for the DB |
| resource\_id | The RDS Resource ID of this instance |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

## Contributing

This module accepting or open for any contributions from anyone, please see the [CONTRIBUTING.md](https://github.com/traveloka/terraform-aws-private-route53-zone/blob/master/CONTRIBUTING.md) for more detail about how to contribute to this module.

## License

This module is under Apache License 2.0 - see the [LICENSE](https://github.com/traveloka/terraform-aws-private-route53-zone/blob/master/LICENSE) file for details.