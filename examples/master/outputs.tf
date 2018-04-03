output "address" {
  description = "The address of the RDS instance"
  value       = "${module.txtbook_postgres.address}"
}

output "arn" {
  description = "The ARN of the RDS instance"
  value       = "${module.txtbook_postgres.arn}"
}

output "endpoint" {
  description = "The connection endpoint"
  value       = "${module.txtbook_postgres.endpoint}"
}

output "hosted_zone_id" {
  description = "The canonical hosted zone ID of the DB instance (to be used in a Route 53 Alias record)"
  value       = "${module.txtbook_postgres.hosted_zone_id}"
}

output "id" {
  description = "The RDS instance ID"
  value       = "${module.txtbook_postgres.id}"
}

output "resource_id" {
  description = "The RDS Resource ID of this instance"
  value       = "${module.txtbook_postgres.resource_id}"
}

output "availability_zone" {
  description = "The availability zone of the instance"
  value       = "${module.txtbook_postgres.availability_zone}"
}
