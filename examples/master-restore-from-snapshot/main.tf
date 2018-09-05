provider "aws" {
  region = "ap-southeast-1"
}

# Create an IAM Role for RDS Enhanced Monitoring
data "aws_iam_policy" "rds_enhanced_monitoring" {
  arn = "arn:aws:iam::aws:policy/service-role/AmazonRDSEnhancedMonitoringRole"
}

module "rds_enhanced_monitoring" {
  source = "github.com/traveloka/terraform-aws-iam-role.git//modules/service?ref=master"

  role_identifier  = "RDS Enhanced Monitoring"
  role_description = "Provides access to Cloudwatch for RDS Enhanced Monitoring"
  aws_service      = "monitoring.rds.amazonaws.com"
}

resource "aws_iam_role_policy_attachment" "rds_enhanced_monitoring" {
  role       = "${module.rds_enhanced_monitoring.role_name}"
  policy_arn = "${data.aws_iam_policy.rds_enhanced_monitoring.arn}"
}

module "rds_postgres" {
  source = "../../"

  product_domain = "abc"
  service_name   = "abctest"
  environment    = "staging"
  description    = "Postgres to store abctest data"

  instance_class    = "db.t2.small"
  engine_version    = "9.5.10"
  allocated_storage = 20
  storage_encrypted = false

  # Change to valid security group id
  vpc_security_group_ids = [
    "sg-1234a51e",
  ]

  # Change to valid RDS snapshot
  snapshot_identifier = "rds:abctest-staging-2018-09-04"

  # Change to valid db subnet group nam
  db_subnet_group_name = "tvlk-staging-rds-subnet-group"

  # Change to valid parameter group name
  parameter_group_name = "default.postgres9.5"
  maintenance_window   = "Mon:00:00-Mon:03:00"
  backup_window        = "21:00-23:00"

  # Change to valid monitoring role arn
  monitoring_role_arn = "${module.rds_enhanced_monitoring.role_arn}"
}
