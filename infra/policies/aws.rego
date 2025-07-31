package terraform.aws

# EC2 root volume must be encrypted
deny[msg] {
  rc := input.resource_changes[_]
  rc.type == "aws_instance"
  after := rc.change.after
  block := after.root_block_device[_]   # bind an element first
  not block.encrypted                   # now it's safe to negate
  msg := sprintf("EC2 root volume must be encrypted: %s", [rc.address])
}

# EC2 must require IMDSv2 (http_tokens=required)
deny[msg] {
  rc := input.resource_changes[_]
  rc.type == "aws_instance"
  after := rc.change.after
  mo := after.metadata_options[_]       # bind element first
  mo.http_tokens != "required"
  msg := sprintf("EC2 must require IMDSv2 (http_tokens=required): %s", [rc.address])
}

# Optional: block wide‑open SSH rules if you add SG rules later
deny[msg] {
  rc := input.resource_changes[_]
  rc.type == "aws_security_group_rule"
  after := rc.change.after
  after.cidr_blocks[_] == "0.0.0.0/0"
  after.from_port <= 22
  after.to_port   >= 22
  msg := sprintf("SSH from 0.0.0.0/0 not allowed: %s", [rc.address])
}
