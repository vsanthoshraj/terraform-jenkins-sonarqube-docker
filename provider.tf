# ============================================
# AWS Provider Configuration
# File: provider.tf
# Purpose: Configure AWS provider and backend
# ============================================

terraform {
  required_version = ">= 1.0"
  
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
  
  # Optional: Remote state backend (S3)
  # backend "s3" {
  #   bucket         = "terraform-state-cicd"
  #   key            = "cicd/terraform.tfstate"
  #   region         = "us-east-1"
  #   encrypt        = true
  #   dynamodb_table = "terraform-state-lock"
  # }
}

provider "aws" { 
  region  = var.aws_region
  #profile = var.aws_profile # Or use access_key and secret_key
  
  default_tags {
    tags = {
      Project     = "CICD-Infrastructure"
      ManagedBy   = "Terraform"
      Environment = var.environment
      Owner       = "DevOps-Team"
    }
  }
}
