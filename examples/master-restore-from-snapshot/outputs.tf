output "address" {
  description = "The address of the RDS instance"
  value       = "${module.rds_postgres.address}"
}

output "arn" {
  description = "The ARN of the RDS instance"
  value       = "${module.rds_postgres.arn}"
}

output "endpoint" {
  description = "The connection endpoint"
  value       = "${module.rds_postgres.endpoint}"
}

output "hosted_zone_id" {
  description = "The canonical hosted zone ID of the DB instance (to be used in a Route 53 Alias record)"
  value       = "${module.rds_postgres.hosted_zone_id}"
}

output "id" {
  description = "The RDS instance ID"
  value       = "${module.rds_postgres.id}"
}

output "resource_id" {
  description = "The RDS Resource ID of this instance"
  value       = "${module.rds_postgres.resource_id}"
}

output "availability_zone" {
  description = "The availability zone of the instance"
  value       = "${module.rds_postgres.availability_zone}"
}
