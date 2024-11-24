variable "environment" {
  description = "Environment name (e.g., shared, dev, test)"
  type        = string
  default     = "shared"
}

variable "account_id" {
  description = "AWS Account ID of the SharedServicesAccount"
  type        = string
}

variable "is_organization_trail" {
  description = "Whether this is an organization-wide trail"
  type        = bool
  default     = true
}

variable "enable_notifications" {
  description = "Whether to enable SNS notifications for CloudTrail"
  type        = bool
  default     = false
}

variable "tags" {
  description = "Tags to assign to resources"
  type        = map(string)
  default     = {}
}
