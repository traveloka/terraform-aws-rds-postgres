output "address" {
  description = "The address of the RDS instance"
  value       = "${aws_db_instance.read_replica.address}"
}

output "arn" {
  description = "The ARN of the RDS instance"
  value       = "${aws_db_instance.read_replica.arn}"
}

output "endpoint" {
  description = "The connection endpoint"
  value       = "${aws_db_instance.read_replica.endpoint}"
}

output "hosted_zone_id" {
  description = "The canonical hosted zone ID of the DB instance (to be used in a Route 53 Alias record)"
  value       = "${aws_db_instance.read_replica.hosted_zone_id}"
}

output "id" {
  description = "The RDS instance ID"
  value       = "${aws_db_instance.read_replica.id}"
}

output "resource_id" {
  description = "The RDS Resource ID of this instance"
  value       = "${aws_db_instance.read_replica.resource_id}"
}

output "availability_zone" {
  description = "The availability zone of the instance"
  value       = "${aws_db_instance.read_replica.availability_zone}"
}

output "route53_fqdn" {
  description = "The Route 53 FQDN"
  value       = "${aws_route53_record.read_replica.fqdn}"
}
