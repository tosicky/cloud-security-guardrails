resource "aws_iam_role" "this" {
  name               = var.name
  assume_role_policy = var.assume_role_policy
  permissions_boundary = var.permissions_boundary_arn
  tags = { managed_by = "terraform" }
}

resource "aws_iam_role_policy" "inline" {
  name   = "${var.name}-inline"
  role   = aws_iam_role.this.id
  policy = var.policy_json
}
