resource "aws_iam_role" "account_bootstrap_role" {
  name               = "account-bootsrap-role"
  assume_role_policy = data.aws_iam_policy_document.account_bootstrap_trust_policy.json
  max_session_duration = 3600  # 30 minutes
}

resource "aws_iam_role_policy" "accounts_bootstrap_inline" {
  role   = aws_iam_role.account_bootstrap_role.id
  policy = data.aws_iam_policy_document.account_bootstrap_permissions.json
}


data "aws_iam_policy_document" "account_bootstrap_trust_policy" {
  statement {
    effect = "Allow"
  
    actions = ["sts:AssumeRole"]
    principals {
      type        = "AWS"
      identifiers = ["arn:aws:iam::${var.management_account_id}:role/github-org-bootstrap"]
    }
  } 
}

data "aws_iam_policy_document" "account_bootstrap_permissions" {

  statement {
    sid     = "ManageIamRolesForBootstrap"
    effect  = "Allow"
    actions = [
      "iam:CreateRole",
      "iam:UpdateRole",
      "iam:DeleteRole",
      "iam:AttachRolePolicy",
      "iam:DetachRolePolicy",
      "iam:PutRolePolicy",
      "iam:DeleteRolePolicy",
      "iam:TagRole",
      "iam:UntagRole",
      "iam:GetRole",
      "iam:ListRolePolicies",
      "iam:ListAttachedRolePolicies"
    ]
    resources = [
      "arn:aws:iam::*:role/github-*",
      "arn:aws:iam::*:role/account-*"
    ]
  }

  statement {
    sid     = "ManageOidcProvider"
    effect  = "Allow"
    actions = [
      "iam:CreateOpenIDConnectProvider",
      "iam:DeleteOpenIDConnectProvider",
      "iam:UpdateOpenIDConnectProviderThumbprint",
      "iam:GetOpenIDConnectProvider"
    ]
    resources = ["*"]
  }

  statement {
    sid     = "AllowReadIamForPlanning"
    effect  = "Allow"
    actions = [
      "iam:ListRoles",
      "iam:GetPolicy",
      "iam:ListPolicies"
    ]
    resources = ["*"]
  }
}

data "aws_iam_policy_document" "deployer_policy" {
  # statement {
  #   sid    = "TfStateListBucketScoped"
  #   effect = "Allow"
  #   actions = ["s3:ListBucket"]
  #   # Tighten to your state bucket(s) if applicable; otherwise remove this block.
  #   resources = ["arn:aws:s3:::cloud-sec-org-bucket"]
  #   condition {
  #       test = "StringLike"
  #       variable = "s3:prefix"
  #       values = ["workloads/${var.workload_account_id}/*"]
  #       }
  # }

  # statement {
  #   sid    = "TfStateObjectAccessScoped"
  #   effect = "Allow"
  #   actions = [
  #     "s3:GetObject", "s3:PutObject", "s3:DeleteObject"
  #   ]
  #   # Tighten to your state bucket(s) if applicable; otherwise remove this block.
  #   resources = ["arn:aws:s3:::cloud-sec-org-bucket/workloads/${var.workload_account_id}/*"]
  # }

  # statement {
  #   sid    = "TfLockTableAccess"
  #   effect = "Allow"
  #   actions = [
  #     "dynamodb:GetItem", "dynamodb:PutItem", "dynamodb:DeleteItem",
  #     "dynamodb:UpdateItem", "dynamodb:DescribeTable"
  #   ]
  #   # Tighten to your state bucket(s) if applicable; otherwise remove this block.
  #   resources = ["arn:aws:dynamodb:us-east-1:${var.audit_account_id}:table/${var.dynamodb_lock_table}"]
  # }

  # statement {
  #   sid    = "KmsForTfStateAccess"
  #   effect = "Allow"
  #   actions = [
  #     "kms:Encrypt", "kms:Decrypt", "kms:GenerateDataKey", "kms:DescribeKey"
  #   ]
  #   # Tighten to your state bucket(s) if applicable; otherwise remove this block.
  #   resources = ["${var.kms_key_arn}"]
  # }

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