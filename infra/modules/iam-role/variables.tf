variable "name" {}
variable "assume_role_policy" { type = string }
variable "policy_json"        { type = string }
variable "permissions_boundary_arn" { 
    type = string 
    default = null 
    }
