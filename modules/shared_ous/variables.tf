variable "ou_names" {
  description = "List of organizational unit names to create inside the shared OU."
  type        = list(string)
}

variable "parent_id" {
  description = "ID of the parent organizational unit (usually the root OU or a shared OU)."
  type        = string
}
