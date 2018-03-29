variable "product_domain" {
  description = "The name of the product domain this RDS belongs to"
}

variable "service_name" {
  description = "The name of the service this RDS belongs to, this will be part of the database identifier"
}

variable "environment" {
  description = "The environment this RDS belongs to"
}

variable "description" {
  description = "The description of this RDS instance"
}

variable "replicate_source_db" {
  description = "The source db of this read replicate"
}

variable "instance_class" {
  description = "The instance type of the RDS instance"
}

variable "port" {
  description = "The port on which the DB accepts connections"
  default     = 5432
}

variable "storage_type" {
  description = "One of standard (magnetic), gp2 (general purpose SSD), or io1 (provisioned IOPS SSD)"
  default     = "gp2"
}

variable "iops" {
  description = "The amount of provisioned IOPS. Setting this implies a storage_type of io1"
  default     = 0
}

variable "storage_encrypted" {
  description = "Specifies whether the DB instance is encrypted"
  default     = true
}

variable "kms_key_id" {
  description = "Specifies a custom KMS key to be used to encrypt"
  default     = ""
}

variable "vpc_security_group_ids" {
  description = "List of VPC security groups to associate"
  type        = "list"
}

variable "db_subnet_group_name" {
  description = "Name of DB subnet group"
  default     = ""
}

variable "parameter_group_name" {
  description = "Name of the DB parameter group to associate"
}

variable "availability_zone" {
  description = "The availability zone this read replica resides, must be one of the master's availability zone"
}

variable "publicly_accessible" {
  description = "Specifies if the RDS instance is publicly accessible"
  default     = false
}

variable "auto_minor_version_upgrade" {
  description = "Indicates that minor engine upgrades will be applied automatically to the DB instance during the maintenance window"
  default     = false
}

variable "apply_immediately" {
  description = "Specifies whether any database modifications are applied immediately, or during the next maintenance window"
  default     = false
}

variable "maintenance_window" {
  description = "The window to perform maintenance in. Syntax: 'ddd:hh24:mi-ddd:hh24:mi'"
}

variable "monitoring_interval" {
  description = "The interval, in seconds, between points when Enhanced Monitoring metrics are collected for the DB instance"
  default     = 60
}

variable "monitoring_role_arn" {
  description = "The ARN for the IAM role that permits RDS to send enhanced monitoring metrics to CloudWatch Logs"
}

variable "route53_zone_id" {
  description = "The Route 53 zone id to create the record set"
}
