output "master_address" {
  description = "The address of the RDS instance"
  value       = "${module.txtbook_postgres_1.address}"
}

output "master_arn" {
  description = "The ARN of the RDS instance"
  value       = "${module.txtbook_postgres_1.arn}"
}

output "master_endpoint" {
  description = "The connection endpoint"
  value       = "${module.txtbook_postgres_1.endpoint}"
}

output "master_hosted_zone_id" {
  description = "The canonical hosted zone ID of the DB instance (to be used in a Route 53 Alias record)"
  value       = "${module.txtbook_postgres_1.hosted_zone_id}"
}

output "master_id" {
  description = "The RDS instance ID"
  value       = "${module.txtbook_postgres_1.id}"
}

output "master_resource_id" {
  description = "The RDS Resource ID of this instance"
  value       = "${module.txtbook_postgres_1.resource_id}"
}

output "master_availability_zone" {
  description = "The availability zone of the instance"
  value       = "${module.txtbook_postgres_1.availability_zone}"
}

output "read_replica_address" {
  description = "The address of the RDS instance"
  value       = "${module.txtbook_postgres_2.address}"
}

output "read_replica_arn" {
  description = "The ARN of the RDS instance"
  value       = "${module.txtbook_postgres_2.arn}"
}

output "read_replica_endpoint" {
  description = "The connection endpoint"
  value       = "${module.txtbook_postgres_2.endpoint}"
}

output "read_replica_hosted_zone_id" {
  description = "The canonical hosted zone ID of the DB instance (to be used in a Route 53 Alias record)"
  value       = "${module.txtbook_postgres_2.hosted_zone_id}"
}

output "read_replica_id" {
  description = "The RDS instance ID"
  value       = "${module.txtbook_postgres_2.id}"
}

output "read_replica_resource_id" {
  description = "The RDS Resource ID of this instance"
  value       = "${module.txtbook_postgres_2.resource_id}"
}

output "read_replica_availability_zone" {
  description = "The availability zone of the instance"
  value       = "${module.txtbook_postgres_2.availability_zone}"
}
