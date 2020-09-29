provider "aws" {
  region = "ap-southeast-1"
}

# Create an IAM Role for RDS Enhanced Monitoring
data "aws_iam_policy" "rds_enhanced_monitoring" {
  arn = "arn:aws:iam::aws:policy/service-role/AmazonRDSEnhancedMonitoringRole"
}
data "aws_vpc" "test_vpc" {
  filter {
    name   = "tag:ProductDomain"
    values = ["tsi"]
  }
}
module "rds_enhanced_monitoring" {
  source = "github.com/traveloka/terraform-aws-iam-role.git//modules/service?ref=master"

  role_identifier  = "RDS Enhanced Monitoring"
  role_description = "Provides access to Cloudwatch for RDS Enhanced Monitoring"
  aws_service      = "monitoring.rds.amazonaws.com"
  product_domain   = "tsi"
  environment      = "testing"
}

resource "aws_iam_role_policy_attachment" "rds_enhanced_monitoring" {
  role       = module.rds_enhanced_monitoring.role_name
  policy_arn = data.aws_iam_policy.rds_enhanced_monitoring.arn
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
    aws_security_group.dummy_sg.id,
  ]

  bastion_security_group_id = aws_security_group.bastion_sg.id

  # Change to valid RDS snapshot
  snapshot_identifier = "rds:abctest-staging-2018-09-04"

  # Change to valid db subnet group nam
  db_subnet_group_name = "tvlk-staging-rds-subnet-group"

  # Change to valid parameter group name
  parameter_group_name = "default.postgres9.5"
  maintenance_window   = "Mon:00:00-Mon:03:00"
  backup_window        = "21:00-23:00"

  # Change to valid monitoring role arn
  monitoring_role_arn = module.rds_enhanced_monitoring.role_arn
}

resource "aws_security_group" "dummy_sg" {
  name        = "tsidum-postgres"
  description = "dummy security group for testing postgres modules"
  vpc_id      = data.aws_vpc.test_vpc.id

  tags = {
    Name          = "tsitest-postgres"
    Service       = "tsitest"
    ProductDomain = "tsi"
    Environment   = "testing"
    description   = "dummy security group for testing postgres modules"
  }
}

resource "aws_security_group" "bastion_sg" {
  name        = "tsitest-bastion"
  description = "dummy security group for testing postgres modules"
  vpc_id      = data.aws_vpc.test_vpc.id

  tags = {
    Name          = "tsidum-postgres"
    Service       = "tsitest"
    ProductDomain = "tsi"
    Environment   = "testing"
    description   = "dummy bastion security group for testing postgres modules"
  }
}
