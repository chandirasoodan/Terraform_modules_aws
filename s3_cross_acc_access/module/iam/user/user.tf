resource "aws_iam_user" "user" {
    name = var.user_name
    tags = var.user_tags

}

variable "user_name" {
  
}

variable "user_tags" {
  type = map(string)
}

output "user_name" {
    value = aws_iam_user.user.name
  
}