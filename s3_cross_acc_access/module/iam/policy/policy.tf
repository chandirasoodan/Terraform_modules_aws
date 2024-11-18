resource "aws_iam_policy" "policy" {
    name = var.policy_name
    policy = var.policy
  
}

variable "policy_name" {
  
}

variable "policy" {
  
}

output "policy_arn" {
    value = aws_iam_policy.policy.arn
  
}