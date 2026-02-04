resource "aws_cloudwatch_event_rule" "securityhub_high" {
  name        = "securityhub-high-critical-only"
  description = "Route only HIGH/CRITICAL NEW ACTIVE Security Hub imported findings to SNS."
  event_pattern = jsonencode({
    "source": ["aws.securityhub"],
    "detail-type": ["Security Hub Findings - Imported"],
    "detail": {
      "findings": {
        "Severity": { "Label": ["HIGH", "CRITICAL"] },
        "Workflow": { "Status": ["NEW"] },
        "RecordState": ["ACTIVE"]
      }
    }
  })
}

resource "aws_cloudwatch_event_target" "to_sns" {
  rule      = aws_cloudwatch_event_rule.securityhub_high.name
  target_id = "sns"
  arn       = var.sns_topic_arn
}
