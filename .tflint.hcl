plugin "aws" {
  enabled = true
  version = "0.32.0"
  source  = "github.com/terraform-linters/tflint-ruleset-aws"
}

# Core rules (examples — keep what you want)
rule "terraform_unused_declarations" { enabled = true }
rule "terraform_comment_syntax"      { enabled = true }

# If you later lint S3 or other services, add those rules here
# rule "aws_s3_bucket_enable_versioning" { enabled = true }
# rule "aws_s3_bucket_logging"           { enabled = true }
