variable "location" {
  description = "Azure region for CloudCart infrastructure."
  type        = string
  default     = "West Europe"
}

variable "project_name" {
  description = "Project name used in Azure resource naming."
  type        = string
  default     = "cloudcart"
}