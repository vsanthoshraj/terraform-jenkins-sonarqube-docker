# ============================================
# EC2 Module - Variables
# File: modules/ec2/variables.tf
# ============================================

variable "project_name" {
  description = "Project name for resource naming"
  type        = string
}

variable "environment" {
  description = "Environment name (dev, staging, prod)"
  type        = string
}

variable "ami_id" {
  description = "AMI ID to use for instances"
  type        = string
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t3.small"
}

variable "subnet_id" {
  description = "Subnet ID where instances will be launched"
  type        = string
}

variable "key_name" {
  description = "SSH key pair name"
  type        = string
}

variable "jenkins_sg_id" {
  description = "Security group ID for Jenkins"
  type        = string
}

variable "sonarqube_sg_id" {
  description = "Security group ID for SonarQube"
  type        = string
}

variable "docker_sg_id" {
  description = "Security group ID for Docker"
  type        = string
}

variable "jenkins_volume_size" {
  description = "Root volume size for Jenkins (GB)"
  type        = number
  default     = 30
}

variable "sonarqube_volume_size" {
  description = "Root volume size for SonarQube (GB)"
  type        = number
  default     = 40
}

variable "docker_volume_size" {
  description = "Root volume size for Docker (GB)"
  type        = number
  default     = 50
}
