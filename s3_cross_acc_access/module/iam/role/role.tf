/*resource "a" "ro" {
    name = var.role_name
    assume_role_policy = var.assume_role_policy
    tags = var.role_tag
    provider = var.provider_name
  
}*/
resource "aws_iam_role" "name" {
    name = var.role_name
    assume_role_policy = var.assume_role_policy
    tags = var.role_tag

}


variable "role_name" {}
variable "assume_role_policy" {}
variable "role_tag" {
    type = map(string)
}


output "role_name" {
    value = aws_iam_role.name.name
  
}