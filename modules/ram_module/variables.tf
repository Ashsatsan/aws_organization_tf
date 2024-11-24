variable "share_name" {
  description = "The name of the resource share."
  type        = string
}

variable "resource_arn" {
  description = "The ARN of the resource to share (e.g., VPC ARN)."
  type        = string
}

variable "target_principal_arn" {
  description = "The ARN of the account or OU to share the resource with."
  type        = string
}

variable "tags" {
  description = "Tags to apply to the resource share."
  type        = map(string)
  default     = {}
}
