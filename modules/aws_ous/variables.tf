variable "ou_names" {
  description = "A list of names for the organizational units"
  type        = list(string)
}

variable "parent_id" {
  description = "The parent ID under which the OUs will be created"
  type        = string
}
