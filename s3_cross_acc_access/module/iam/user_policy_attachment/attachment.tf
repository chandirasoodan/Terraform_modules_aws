resource "aws_iam_user_policy_attachment" "prod_s3" {
  user       = var.user_name
  policy_arn = var.policy_arn
}

variable "user_name" {
  
}
variable "policy_arn" {
  
}