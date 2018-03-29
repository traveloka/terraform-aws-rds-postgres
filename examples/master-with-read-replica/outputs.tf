output "master_address" {
  description = "The address of the RDS instance"
  value       = "${module.master.address}"
}

output "master_arn" {
  description = "The ARN of the RDS instance"
  value       = "${module.master.arn}"
}

output "master_endpoint" {
  description = "The connection endpoint"
  value       = "${module.master.endpoint}"
}

output "master_hosted_zone_id" {
  description = "The canonical hosted zone ID of the DB instance (to be used in a Route 53 Alias record)"
  value       = "${module.master.hosted_zone_id}"
}

output "master_id" {
  description = "The RDS instance ID"
  value       = "${module.master.id}"
}

output "master_resource_id" {
  description = "The RDS Resource ID of this instance"
  value       = "${module.master.resource_id}"
}

output "master_availability_zone" {
  description = "The availability zone of the instance"
  value       = "${module.master.availability_zone}"
}

output "master_route53_fqdn" {
  description = "The Route 53 FQDN"
  value       = "${module.master.route53_fqdn}"
}

output "read_replica_address" {
  description = "The address of the RDS instance"
  value       = "${module.read_replica.address}"
}

output "read_replica_arn" {
  description = "The ARN of the RDS instance"
  value       = "${module.read_replica.arn}"
}

output "read_replica_endpoint" {
  description = "The connection endpoint"
  value       = "${module.read_replica.endpoint}"
}

output "read_replica_hosted_zone_id" {
  description = "The canonical hosted zone ID of the DB instance (to be used in a Route 53 Alias record)"
  value       = "${module.read_replica.hosted_zone_id}"
}

output "read_replica_id" {
  description = "The RDS instance ID"
  value       = "${module.read_replica.id}"
}

output "read_replica_resource_id" {
  description = "The RDS Resource ID of this instance"
  value       = "${module.read_replica.resource_id}"
}

output "read_replica_availability_zone" {
  description = "The availability zone of the instance"
  value       = "${module.read_replica.availability_zone}"
}

output "read_replica_route53_fqdn" {
  description = "The Route 53 FQDN"
  value       = "${module.read_replica.route53_fqdn}"
}
