config {
  module = true
}

plugin "aws" {
  enabled = true
  version = "0.32.0"
  source  = "github.com/terraform-linters/tflint-ruleset-aws"
}

rule "terraform_unused_declarations" { enabled = true }
rule "terraform_comment_syntax"      { enabled = true }
