# Practical Guardrail Model (CT + OIDC)

## Preventive (CI)
- Terraform fmt/validate/plan
- Checkov + Conftest policies
- GitHub Environment approval gate for prod apply

## Detective (Runtime)
- AWS Config rules + org aggregator
- Security Hub standards + centralized findings

## Corrective
- EventBridge routing (only high signal)
- Optional Config remediation via SSM Automation
