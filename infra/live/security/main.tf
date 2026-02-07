locals {
  role_name = "github-security-platform"
}

# module "kms" {
#   source     = "../../modules/kms-key"
#   alias      = "security-platform"
#   admin_arns = var.kms_admin_arns
# }

# # Optional: secure bucket for evidence exports or custom reports (separate from CT log archive)
# module "audit_evidence_bucket" {
#   source      = "../../modules/audit-evidence"
#   bucket_name = "audit-evidence-REPLACE_ME"
#   kms_key_arn = module.kms.key_arn
# }

# # Detective: baseline Config rules (recorders already enabled by Control Tower)
# module "config_baseline" {
#   source = "../../modules/config-baseline"
# }

# # Detective: Security Hub + GuardDuty (enable when ready; note org-wide delegated admin must be set)
# module "securityhub" {
#   source = "../../modules/securityhub-org"
# }

# module "guardduty" {
#   source = "../../modules/guardduty-org"
# }

# Alert noise control: route only HIGH/CRITICAL NEW ACTIVE findings to SNS (provide topic ARN)
# module "securityhub_alert_filter" {
#   source        = "../../modules/eventbridge-securityhub-filter"
#   sns_topic_arn = "arn:aws:sns:us-east-1:${var.audit_account_id}:aws-control-tower-SecurityNotifications"
# }

module "github_oidc_bootstrap" {
  source      = "../../modules/oidc-github"
  github_org  = var.github_org
  github_repo = var.github_repo
  role_name   = local.role_name
  policy_json = data.aws_iam_policy_document.github_security_platform.json
  branch      = var.branch
  environment = var.environment
}