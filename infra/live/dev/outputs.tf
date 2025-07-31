output "instance_id" {
  value = aws_instance.this.id
}

output "public_ip" {
  value       = aws_instance.this.public_ip
  description = "Public IP"
}

output "subnet_id" {
  value = aws_instance.this.subnet_id
}
