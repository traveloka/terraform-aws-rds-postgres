output "address" {
  description = "The address of the RDS instance"
  value       = "${aws_db_instance.postgres.address}"
}

output "arn" {
  description = "The ARN of the RDS instance"
  value       = "${aws_db_instance.postgres.arn}"
}

output "endpoint" {
  description = "The connection endpoint"
  value       = "${aws_db_instance.postgres.endpoint}"
}

output "hosted_zone_id" {
  description = "The canonical hosted zone ID of the DB instance (to be used in a Route 53 Alias record)"
  value       = "${aws_db_instance.postgres.hosted_zone_id}"
}

output "id" {
  description = "The RDS instance ID"
  value       = "${aws_db_instance.postgres.id}"
}

output "resource_id" {
  description = "The RDS Resource ID of this instance"
  value       = "${aws_db_instance.postgres.resource_id}"
}
