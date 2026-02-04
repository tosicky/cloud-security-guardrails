data "aws_iam_policy_document" "kms" {
  statement {
    sid       = "KeyAdmins"
    actions   = ["kms:*"]
    resources = ["*"]
    principals { 
      type = "AWS" 
      identifiers = var.admin_arns 
      }
  }
}

resource "aws_kms_key" "this" {
  description         = "CMK for ${var.alias}"
  enable_key_rotation = true
  policy              = data.aws_iam_policy_document.kms.json
}

resource "aws_kms_alias" "this" {
  name          = "alias/${var.alias}"
  target_key_id = aws_kms_key.this.key_id
}
