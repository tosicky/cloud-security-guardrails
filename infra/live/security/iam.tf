data "aws_iam_policy_document" "github_security_platform" {
  statement {
    sid    = "TfStateListBucketScoped"
    effect = "Allow"
    actions = ["s3:ListBucket"]
    # Tighten to your state bucket(s) if applicable; otherwise remove this block.
    resources = ["arn:aws:s3:::cloud-sec-org-bucket"]
    condition {
        test = "StringLike"
        variable = "s3:prefix"
        values = ["security-platform/*"]
        }
  }

  statement {
    sid    = "TfStateObjectAccessScoped"
    effect = "Allow"
    actions = [
      "s3:GetObject", "s3:PutObject", "s3:DeleteObject"
    ]
    # Tighten to your state bucket(s) if applicable; otherwise remove this block.
    resources = ["arn:aws:s3:::cloud-sec-org-bucket/security-platform/*"]
  }

  statement {
    sid    = "TfLockTableAccess"
    effect = "Allow"
    actions = [
      "dynamodb:GetItem", "dynamodb:PutItem", "dynamodb:DeleteItem",
      "dynamodb:UpdateItem", "dynamodb:DescribeTable"
    ]
    # Tighten to your state bucket(s) if applicable; otherwise remove this block.
    resources = ["arn:aws:dynamodb:us-east-1:${var.audit_account_id}:table/${var.dynamodb_lock_table}"]
  }

#   statement {
#     sid    = "KmsForTfStateAccess"
#     effect = "Allow"
#     actions = [
#       "kms:Encrypt", "kms:Decrypt", "kms:GenerateDataKey", "kms:DescribeKey"
#     ]
#     # Tighten to your state bucket(s) if applicable; otherwise remove this block.
#     resources = ["${var.kms_key_arn}"]
#   }
}