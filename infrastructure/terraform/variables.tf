variable "project_name" {
  description = "Name of the project."
  type        = string
  default     = "cloudcart"
}

variable "environment" {
  description = "Deployment environment."
  type        = string
  default     = "dev"
}

variable "location" {
  description = "Azure region."
  type        = string
  default     = "West Europe"
}

variable "admin_username" {
  description = "Linux administrator username."
  type        = string
  default     = "azureuser"
}

variable "admin_source_ip" {
  description = "Public IPv4 address allowed to SSH to the VM."
  type        = string
}

variable "vm_size" {
  description = "Azure VM size."
  type        = string
  default     = "Standard_B2s_v2"
}

variable "ssh_public_key" {
  description = "SSH public key used to access the CloudCart VM"
  type        = string
}