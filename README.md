# Control Tower Multi-Account + GitHub OIDC Guardrails (Repo Skeleton)

This repo is structured for **Control Tower multi-account** with **GitHub OIDC**.

## Account model

- **Audit/Security account** (delegated admin): Security Hub, GuardDuty, Config Aggregator, alert routing
- **Workload accounts**: application infrastructure deployments

## Values to set

- Audit account id: **1273636737** (AWS account IDs are typically **12 digits**; if yours is missing digits, confirm the full 12-digit ID)
- Update these in:
  - `infra/live/security/variables.tf`
  - `.github/workflows/security-platform.yml`
  - `.github/workflows/workload-deploy.yml`

## How to use

### Security platform (Audit account)

```bash
cd infra/live/security
terraform init
terraform plan
terraform apply
```

### Workload deployment (per workload account)

```bash
cd infra/live/workload
terraform init
terraform plan
terraform apply
```

## CI/CD

- `security-platform.yml`: deploys security tooling to the Audit account using OIDC role
- `workload-deploy.yml`: deploys to workload accounts using a matrix of account IDs (OIDC role per account)

> NOTE: The default templates include placeholders you must replace (account IDs, repo/org names, regions).
