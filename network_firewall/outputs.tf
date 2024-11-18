output "firewall-details" {
  value = [for i in values(data.aws_networkfirewall_firewall.firewall-info):{"${i.name}" = ["name = ${i.name}","id = ${i.id}","delete_protection = ${i.delete_protection}","firewall_policy_arn = ${i.firewall_policy_arn}","firewall_policy_change_protection = ${i.firewall_policy_change_protection}","update_token = ${i.update_token}","vpc_id = ${i.vpc_id}"]}]
}

output "firewall-encryption-details" {
  value = {for i in values(data.aws_networkfirewall_firewall.firewall-info):i.name => i.encryption_configuration}
}

output "firewall-status" {
  value = {for i in values(data.aws_networkfirewall_firewall.firewall-info):i.name => i.firewall_status}
}

output "firewall-subnet-mapping" {
  value = {for i in values(data.aws_networkfirewall_firewall.firewall-info):i.name =>  i.subnet_mapping}
}


// terraform created firewall
output "custom-firewall-details" {
  value = [for i in values(aws_networkfirewall_firewall.network-firewall):{"${i.name}" = ["name = ${i.name}","id = ${i.id}","delete_protection = ${i.delete_protection}","firewall_policy_arn = ${i.firewall_policy_arn}","firewall_policy_change_protection = ${i.firewall_policy_change_protection == null ? "" : i.firewall_policy_change_protection}","update_token = ${i.update_token}","vpc_id = ${i.vpc_id}"]}]
}

output "custom-firewall-encryption-details" {
  value = {for i in values(aws_networkfirewall_firewall.network-firewall):i.name => i.encryption_configuration}
}

output "custom-firewall-status" {
  value = {for i in values(aws_networkfirewall_firewall.network-firewall):i.name => i.firewall_status}
}

output "custom-firewall-subnet-mapping" {
  value = {for i in values(aws_networkfirewall_firewall.network-firewall):i.name =>  i.subnet_mapping}
}


output "firewall-policy-details" {
  value = [for i in values(data.aws_networkfirewall_firewall_policy.firewall-policy-info):{"${i.name}" = ["arn = ${i.arn}","name = ${i.name}","description = ${i.description}","update_token = ${i.update_token}"]}]
}

output "firewall-policy" {
  value = {for i in values(data.aws_networkfirewall_firewall_policy.firewall-policy-info):i.name => i.firewall_policy}
}

output "custom-firewall-policy-details" {
  value = [for i in values(aws_networkfirewall_firewall_policy.fw-policy):{"${i.name}" = ["arn = ${i.arn}","name = ${i.name}","description = ${i.description}","update_token = ${i.update_token}"]}]
}

output "custom-firewall-policy" {
  value = {for i in values(aws_networkfirewall_firewall_policy.fw-policy):i.name => i.firewall_policy}
}