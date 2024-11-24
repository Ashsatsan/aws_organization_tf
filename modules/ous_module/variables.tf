variable "ous" {
  description = "Map of OUs to create"
  type        = map(string)
  default = {
    "DEV"    = "Development"
    "TEST"   = "Testing"
    "PROD"   = "Production"
    "SHARED" = "Shared"
  }
}

variable "parent_id" {
  description = "The ID of the Root node (parent for all OUs)"
  type        = string
}
