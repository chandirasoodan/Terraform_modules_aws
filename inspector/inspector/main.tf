
###################### Inspector version 1 ######################

resource "aws_inspector_resource_group" "inspector-grp" {
  count = var.enable_inspector_classic == true ? 1 : 0
  tags  = var.inspector-group-tags
}

resource "aws_inspector_assessment_target" "inspector-assessment-target" {
  count              = var.enable_inspector_classic == true ? 1 : 0
  name               = var.assessment_target_name
  resource_group_arn = aws_inspector_resource_group.inspector-grp[count.index].arn
}

resource "aws_inspector_assessment_template" "example" {
  count      = var.enable_inspector_classic == true ? 1 : 0
  name       = var.assessment_template_name
  target_arn = aws_inspector_assessment_target.inspector-assessment-target[count.index].arn
  duration   = var.inspector_run_duration

  rules_package_arns = var.rules_package_arns
  #Activate to generate event notifications
  /*event_subscription {
    event     = ""
    topic_arn = sns arn
  }*/
}

###################### Inspector version 2 ######################
resource "aws_inspector2_enabler" "test" {
  count          = var.enable_inspector_v2 == true ? 1 : 0
  account_ids    = var.account_ids
  resource_types = ["ECR", "EC2"]
}
resource "aws_inspector2_delegated_admin_account" "delegated_admin_account" {
  count      = var.enable_inspector_v2 == true ? 1 : 0
  account_id = var.delegated_admin_account_id
}
resource "aws_inspector2_member_association" "member_association" {
  count      = var.enable_inspector_v2 == true ? 1 : 0
  account_id = var.member_account_id
}

resource "aws_inspector2_organization_configuration" "organization_configuration" {
  count = var.enable_inspector_v2 == true ? 1 : 0
  auto_enable {
    ec2         = true
    ecr         = true
    lambda      = true
    lambda_code = true
  }
}

