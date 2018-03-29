output "address" {
  description = "The address of the RDS instance"
  value       = "${module.postgres.address}"
}

output "arn" {
  description = "The ARN of the RDS instance"
  value       = "${module.postgres.arn}"
}

output "endpoint" {
  description = "The connection endpoint"
  value       = "${module.postgres.endpoint}"
}

output "hosted_zone_id" {
  description = "The canonical hosted zone ID of the DB instance (to be used in a Route 53 Alias record)"
  value       = "${module.postgres.hosted_zone_id}"
}

output "id" {
  description = "The RDS instance ID"
  value       = "${module.postgres.id}"
}

output "resource_id" {
  description = "The RDS Resource ID of this instance"
  value       = "${module.postgres.resource_id}"
}

output "availability_zone" {
  description = "The availability zone of the instance"
  value       = "${module.postgres.availability_zone}"
}

output "route53_fqdn" {
  description = "The Route 53 FQDN"
  value       = "${module.postgres.route53_fqdn}"
}
