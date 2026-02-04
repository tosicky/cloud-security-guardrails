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
    default = "YOUR_ORG" 
    }
variable "github_repo" { 
    type = string 
    default = "security-platform-repo" 
    }

variable "branch" {
  default = "main"
  type    = string
}