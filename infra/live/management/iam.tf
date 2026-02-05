# resource "aws_iam_role" "github_org_bootstrap" {
#   name               = "github-org-bootstrap"
#   assume_role_policy = var.github_trust_policy
#   max_session_duration = 1800  # 30 minutes
# }


data "aws_iam_policy_document" "bootstrap_permissions" {
  statement {
    sid    = "AssumeOAAIntoWorkloads"
    effect = "Allow"
    actions = ["sts:AssumeRole"]
    resources = [
      "arn:aws:iam::${var.workload_account_id}:role/OrganizationAccountAccessRole"
      # add more workload account IDs here if needed
    ]
  }
}

# resource "aws_iam_role_policy" "bootstrap_inline" {
#   role   = aws_iam_role.github_org_bootstrap.id
#   policy = data.aws_iam_policy_document.bootstrap_permissions.json
# }


data "aws_iam_policy_document" "deployer_policy" {
  statement {
    sid    = "TerraformStateAccessIfUsed"
    effect = "Allow"
    actions = [
      "s3:GetObject", "s3:PutObject", "s3:ListBucket"
    ]
    # Tighten to your state bucket(s) if applicable; otherwise remove this block.
    resources = ["*"]
  }

  statement {
    sid    = "AllowCommonWorkloadInfra"
    effect = "Allow"
    actions = [
      # Core infra building blocks (tighten to what you actually deploy)
      "ec2:*",
      "elasticloadbalancing:*",
      "autoscaling:*",
      "logs:*",
      "cloudwatch:*",
      "iam:GetRole",
      "iam:GetPolicy",
      "iam:PassRole",
      "kms:DescribeKey",
      "kms:Encrypt",
      "kms:Decrypt",
      "kms:GenerateDataKey",
      "s3:*",
      "ssm:*",
      "ecr:*",
      "eks:*"
    ]
    resources = ["*"]
  }

  # Strong safety rail: deny IAM admin-style actions
  statement {
    sid    = "DenyIamAdmin"
    effect = "Deny"
    actions = [
      "iam:CreateUser",
      "iam:DeleteUser",
      "iam:CreateAccessKey",
      "iam:DeleteAccessKey",
      "iam:UpdateAccountPasswordPolicy",
      "iam:AttachUserPolicy",
      "iam:PutUserPolicy",
      "iam:CreatePolicy",
      "iam:DeletePolicy",
      "iam:SetDefaultPolicyVersion",
      "iam:CreateRole",
      "iam:DeleteRole",
      "iam:UpdateAssumeRolePolicy",
      "organizations:*"
    ]
    resources = ["*"]
  }
}