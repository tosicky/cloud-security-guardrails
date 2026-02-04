variable "region" { 
    type = string
    default = "us-east-1" 
    }

# Your Audit/Security account ID (12 digits)
variable "audit_account_id" { 
    type = string 
    default = "012736367377" 
    }

# Log archive bucket already created by Control Tower; if you manage here, set a name
variable "log_archive_bucket_name" { 
    type = string 
    default = "ct-log-archive-REPLACE_ME" 
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
