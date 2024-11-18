data "aws_networkfirewall_firewall" "firewall-info" {
  for_each = {for i in var.list-firewalls: i => i }
  name = each.value
}
data "aws_networkfirewall_firewall_policy" "firewall-policy-info" {
  for_each = {for i in var.list-firewall-policies: i => i }
  name = each.value
}