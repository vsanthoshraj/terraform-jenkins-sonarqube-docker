
# Terraform CI/CD AWS Infrastructure

This repository contains Terraform code to provision a professional AWS infrastructure for a 3-instance CI/CD pipeline environment, including Jenkins, SonarQube, and Docker builder instances.

## Features

- Jenkins Master setup for CI/CD orchestration
- SonarQube server for code quality analysis
- Docker builder instance for container image building
- Dedicated VPC, public subnet, and internet gateway
- Security groups with ingress and egress rules tailored for each service
- SSH key pair management for secure remote access
- Elastic IPs assigned for public accessibility
- Modular Terraform code for maintainability and scalability

## AWS IAM Role Usage

This project supports secure uncredentialed AWS API access via IAM Roles:

- When running Terraform on AWS EC2 instances, attach IAM Roles with necessary permissions. The AWS provider automatically uses these credentials without requiring AWS keys.
- This enhances security by avoiding hardcoded AWS credentials.
- For local development, set up AWS CLI profiles or environment variables with appropriate access.

## Getting Started

1. Clone this repository
2. Configure variables in `terraform.tfvars` or environment variables
3. Initialize Terraform:
   ```
   terraform init
   ```
4. Plan the infrastructure
   ```
   terraform plan
   ```
5. Apply the plan
   ```
   terraform apply
   ```

## Important Notes

- Do NOT commit `.terraform/` directory or provider binaries to GitHub; use `.gitignore` to exclude them.
- Sensitive files including private keys (`*.pem`) should not be committed.
- Use Git LFS if you need to version large files.
- Ensure your EC2 instances have SSH keys configured properly for access.
- For troubleshooting Git ownership issues, use:
  ```
  git config --global --add safe.directory /home/ubuntu
  ```

## Repository Structure

```
terraform-cicd/
├── modules/
│   ├── ec2/
│   ├── keypair/
│   └── security_groups/
├── main.tf
├── variables.tf
├── outputs.tf
├── terraform.tfvars
└── .gitignore
```

## License

This project is open source 

***

Let me know if you want me to generate `.gitignore` or sample `terraform.tfvars` next!
