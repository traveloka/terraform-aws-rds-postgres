output "address" {
  description = "The address of the RDS instance"
  value       = "${aws_db_instance.this.address}"
}

output "arn" {
  description = "The ARN of the RDS instance"
  value       = "${aws_db_instance.this.arn}"
}

output "endpoint" {
  description = "The connection endpoint"
  value       = "${aws_db_instance.this.endpoint}"
}

output "hosted_zone_id" {
  description = "The canonical hosted zone ID of the DB instance (to be used in a Route 53 Alias record)"
  value       = "${aws_db_instance.this.hosted_zone_id}"
}

output "id" {
  description = "The RDS instance ID"
  value       = "${aws_db_instance.this.id}"
}

output "resource_id" {
  description = "The RDS Resource ID of this instance"
  value       = "${aws_db_instance.this.resource_id}"
}

output "availability_zone" {
  description = "The availability zone of the instance"
  value       = "${aws_db_instance.this.availability_zone}"
}

output "password" {
  description = "The password for the DB"
  value       = "${local.password}"
}
