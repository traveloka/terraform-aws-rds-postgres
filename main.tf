locals {
  max_byte_length = 8

  db_identifier_max_length = 63
  db_identifier_prefix     = "${var.service_name}-postgres-"

  db_identifier_suffix_max_byte_length = "${(local.db_identifier_max_length - length(db_identifier_prefix)) / 2}"
  db_identifier_suffix_byte_length     - "${min(local.max_byte_length, local.db_identifier_suffix_max_byte_length)}"

  final_snapshot_identifier = "${local.identifier}-final-snapshot"
}

resource "random_id" "db_identifier" {
  prefix      = "${local.db_identifier_prefix}"
  byte_length = "${local.db_identifier_suffix_byte_length}"
}

resource "aws_db_instance" "this" {
  identifier = "${random_id.db_identifier.hex}"

  # Indicates that this instance is a read replica
  replicate_source_db = "${var.replicate_source_db}"

  engine         = "postgres"
  engine_version = "${var.engine_version}"
  instance_class = "${var.instance_class}"
  username       = "${var.username}"
  password       = "${var.password}"
  port           = "${var.port}"

  allocated_storage = "${var.allocated_storage}"
  storage_type      = "${var.storage_type}"
  iops              = "${var.iops}"
  storage_encrypted = "${var.storage_encrypted}"
  kms_key_id        = "${var.kms_key_id}"

  vpc_security_group_ids = ["${var.vpc_security_group_ids}"]
  multi_az               = "${var.multi_az}"
  publicly_accessible    = false

  db_subnet_group_name = "${var.db_subnet_group_name}"
  parameter_group_name = "${var.parameter_group_name}"

  allow_major_version_upgrade = "${var.allow_major_version_upgrade}"
  auto_minor_version_upgrade  = "${var.auto_minor_version_upgrade}"
  apply_immediately           = "${var.apply_immediately}"
  maintenance_window          = "${var.maintenance_window}"

  backup_retention_period = "${var.backup_retention_period}"
  backup_window           = "${var.backup_window}"

  skip_final_snapshot       = "${var.skip_final_snapshot}"
  final_snapshot_identifier = "${local.final_snapshot_identifier}"
  copy_tags_to_snapshot     = "${var.copy_tags_to_snapshot}"

  monitoring_interval = "${var.monitoring_interval}"
  monitoring_role_arn = "${var.monitoring_role_arn}"

  tags {
    Name          = "${local.identifier}"
    Service       = "${var.service_name}"
    ProductDomain = "${var.product_domain}"
    Environment   = "${var.environment}"
    Description   = "${var.description}"
    ManagedBy     = "Terraform"
  }
}
