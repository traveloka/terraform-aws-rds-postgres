locals {
  # The db identifier is in this format <service_name>-postgres-<16_characters_random_suffix>
  identifier = "${var.service_name}-postgres-${random_id.suffix.hex}"
}

resource "random_id" "suffix" {
  byte_length = 8
}

resource "aws_db_instance" "read_replica" {
  identifier     = "${local.identifier}"

  # source db
  replicate_source_db = "${var.replicate_source_db}"

  instance_class = "${var.instance_class}"
  port           = "${var.port}"

  storage_type      = "${var.storage_type}"
  iops              = "${var.iops}"
  storage_encrypted = "${var.storage_encrypted}"
  kms_key_id        = "${var.kms_key_id}"

  vpc_security_group_ids = ["${var.vpc_security_group_ids}"]
  availability_zone      = "${var.availability_zone}"
  multi_az               = false
  publicly_accessible    = "${var.publicly_accessible}"

  db_subnet_group_name = "${var.db_subnet_group_name}"
  parameter_group_name = "${var.parameter_group_name}"

  auto_minor_version_upgrade = "${var.auto_minor_version_upgrade}"
  apply_immediately          = "${var.apply_immediately}"
  maintenance_window         = "${var.maintenance_window}"

  # no backup is required for read replica
  backup_retention_period = 0

  # no snapshot is required for read replica instance
  skip_final_snapshot = true

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

resource "aws_route53_record" "read_replica" {
  zone_id = "${var.route53_zone_id}"
  name    = "${aws_db_instance.read_replica.identifier}"
  records = ["${aws_db_instance.read_replica.address}"]
  type    = "CNAME"
  ttl     = "300"
}
