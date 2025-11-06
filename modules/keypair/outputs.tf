# ============================================
# Key Pair Module - Variables
# File: modules/keypair/variables.tf
# ============================================

variable "project_name" {
  description = "Project name for key pair naming"
  type        = string
}

variable "ssh_public_key_path" {
  description = "Path to SSH public key"
  type        = string
  default     = "~/.ssh/id_rsa.pub"
}
