package terraform.aws

deny[msg] {
  input.resource_type == "aws_security_group_rule"
  input.resource.cidr_blocks[_] == "0.0.0.0/0"
  input.resource.from_port <= 22
  input.resource.to_port   >= 22
  msg := "SSH ingress from 0.0.0.0/0 is not allowed"
}


# Deny if EC2 root volume is not encrypted
deny[msg] {
  some i
  input.resource_changes[i].type == "aws_instance"
  after := input.resource_changes[i].change.after
  not after.root_block_device[_].encrypted
  msg := sprintf("EC2 root volume must be encrypted: %s", [input.resource_changes[i].address])
}

# Deny if EC2 does not require IMDSv2
deny[msg] {
  some i
  input.resource_changes[i].type == "aws_instance"
  after := input.resource_changes[i].change.after
  not after.metadata_options[_].http_tokens == "required"
  msg := sprintf("EC2 must require IMDSv2 (http_tokens=required): %s", [input.resource_changes[i].address])
}

# Optional: fail if a wide-open SSH rule is added (kept for future SG changes)
deny[msg] {
  some i
  input.resource_changes[i].type == "aws_security_group_rule"
  after := input.resource_changes[i].change.after
  after.cidr_blocks[_] == "0.0.0.0/0"
  after.from_port <= 22
  after.to_port   >= 22
  msg := sprintf("SSH from 0.0.0.0/0 not allowed: %s", [input.resource_changes[i].address])
}
