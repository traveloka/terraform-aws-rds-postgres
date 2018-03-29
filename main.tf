locals {
  # The db identifier is in this format <service_name>-postgres-<16_characters_random_suffix>
  identifier = "${var.service_name}-postgres-${random_id.suffix.hex}"

  final_snapshot_identifier = "${local.identifier}-final-snapshot"
}

resource "random_id" "suffix" {
  byte_length = 8
}

resource "aws_db_instance" "postgres" {
  identifier     = "${local.identifier}"

  engine         = "postgres"
  engine_version = "${var.engine_version}"
  instance_class = "${var.instance_class}"
  username       = "${var.username}"
  password       = "${var.password}"
  name           = "${var.name}"
  port           = "${var.port}"

  allocated_storage = "${var.allocated_storage}"
  storage_type      = "${var.storage_type}"
  iops              = "${var.iops}"
  storage_encrypted = "${var.storage_encrypted}"
  kms_key_id        = "${var.kms_key_id}"

  vpc_security_group_ids = ["${var.vpc_security_group_ids}"]
  multi_az               = "${var.multi_az}"
  publicly_accessible    = "${var.publicly_accessible}"

  db_subnet_group_name = "${var.db_subnet_group_name}"
  parameter_group_name = "${var.parameter_group_name}"

  allow_major_version_upgrade = "${var.allow_major_version_upgrade}"
  auto_minor_version_upgrade  = "${var.auto_minor_version_upgrade}"
  apply_immediately           = "${var.apply_immediately}"
  maintenance_window          = "${var.maintenance_window}"

  backup_retention_period   = "${var.backup_retention_period}"
  backup_window             = "${var.backup_window}"

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
  }
}

resource "aws_route53_record" "postgres" {
  zone_id = "${var.route53_zone_id}"
  name    = "${aws_db_instance.postgres.identifier}"
  records = ["${aws_db_instance.postgres.address}"]
  type    = "CNAME"
  ttl     = "300"
}
