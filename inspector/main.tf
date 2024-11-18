## data block to fetch aws managed policies
data "aws_inspector_rules_packages" "rules" {}

## module block for inspector
module "inspector" {
  source                   = "./inspector"
  enable_inspector_classic = var.enable_inspector_classic
  enable_inspector_v2      = var.enable_inspector_v2
  inspector-group-tags     = var.inspector-group-tags
  inspector_run_duration   = var.inspector_run_duration
  assessment_target_name   = var.assessment_target_name
  assessment_template_name = var.assessment_template_name
  rules_package_arns       = data.aws_inspector_rules_packages.rules.arns
}