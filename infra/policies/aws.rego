package terraform.aws

deny[msg] {
  input.resource_type == "aws_security_group_rule"
  input.resource.cidr_blocks[_] == "0.0.0.0/0"
  input.resource.from_port <= 22
  input.resource.to_port   >= 22
  msg := "SSH ingress from 0.0.0.0/0 is not allowed"
}
