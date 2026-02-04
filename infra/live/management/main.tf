locals {
  role_name = "github-workload-deployer"
}

module "github_oidc_deployer" {
  source      = "../../modules/oidc-github"
  github_org  = var.github_org
  github_repo = var.github_repo
  role_name   = local.role_name
  policy_json = data.aws_iam_policy_document.deployer_policy.json
  branch      = var.branch
}

# OPTIONAL: attach permissions boundary if you use them org-wide
# (Your oidc module would need to support this; otherwise apply boundary in a separate role module.)
