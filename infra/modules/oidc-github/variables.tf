variable "github_org" {}
variable "github_repo" {}
variable "role_name" {}
variable "policy_json" { type = string }
variable "branch" { 
    type = string
    default = "main" 
    }
variable "environment" {
    default = "CloudSec"
    type = string
}