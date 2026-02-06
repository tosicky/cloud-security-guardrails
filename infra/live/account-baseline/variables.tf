variable "region" { 
    type = string
    default = "us-east-1" 
    }

variable "workload_account_id" { 
    type = string 
    default = "" 
    }

# KMS admins (e.g., security admin role ARNs)
variable "kms_admin_arns" { 
    type = list(string) 
    default = [] 
    }

# GitHub OIDC repo scope
variable "github_org" { 
    type = string 
    default = "tosicky" 
    }
variable "github_repo" { 
    type = string 
    default = "cloud-security-guardrails" 
    }

variable "branch" {
  default = "main"
  type    = string
}

variable "management_account_id" {
  type = string
}

variable "dynamodb_lock_table" {
  default = "terraform-locks"
  type = string
}

variable "audit_account_id" {
  type = string
}