locals {
  bootstrap_role_name = "github-org-bootstrap"
}

module "github_oidc_bootstrap" {
  source      = "../../modules/oidc-github"
  github_org  = var.github_org
  github_repo = var.github_repo
  role_name   = local.bootstrap_role_name
  policy_json = data.aws_iam_policy_document.bootstrap_permissions.json
  branch      = var.branch
  environment = var.environment
}
