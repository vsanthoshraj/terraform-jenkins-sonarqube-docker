
# Security Groups Module - Main Configuration
# File: modules/security_groups/main.tf
# Purpose: Create 3 security groups (Jenkins, SonarQube, Docker)



# SECURITY GROUP 1: JENKINS

resource "aws_security_group" "jenkins_sg" {
  name_prefix = "${var.project_name}-jenkins-"
  description = "Security group for Jenkins server"
  vpc_id      = var.vpc_id

  tags = {
    Name = "${var.project_name}-jenkins-sg"
  }

  lifecycle {
    create_before_destroy = true
  }
}

# Inbound: SSH from anywhere
resource "aws_security_group_rule" "jenkins_ssh" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  cidr_blocks       = var.allowed_ssh_cidr
  security_group_id = aws_security_group.jenkins_sg.id

  description = "SSH access from allowed CIDR"
}

# Inbound: Jenkins Web UI from anywhere
resource "aws_security_group_rule" "jenkins_web" {
  type              = "ingress"
  from_port         = 8080
  to_port           = 8080
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.jenkins_sg.id

  description = "Jenkins web UI"
}

# Inbound: Jenkins Agent Port from VPC
resource "aws_security_group_rule" "jenkins_agent" {
  type              = "ingress"
  from_port         = 50000
  to_port           = 50000
  protocol          = "tcp"
  cidr_blocks       = [var.vpc_cidr]
  security_group_id = aws_security_group.jenkins_sg.id

  description = "Jenkins agent communication"
}

# Outbound: All traffic to anywhere
resource "aws_security_group_rule" "jenkins_egress" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.jenkins_sg.id

  description = "Allow all outbound traffic"
}

# ============================================
# SECURITY GROUP 2: SONARQUBE
# ============================================

resource "aws_security_group" "sonarqube_sg" {
  name_prefix = "${var.project_name}-sonarqube-"
  description = "Security group for SonarQube server"
  vpc_id      = var.vpc_id

  tags = {
    Name = "${var.project_name}-sonarqube-sg"
  }

  lifecycle {
    create_before_destroy = true
  }
}

# Inbound: SSH from anywhere
resource "aws_security_group_rule" "sonarqube_ssh" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  cidr_blocks       = var.allowed_ssh_cidr
  security_group_id = aws_security_group.sonarqube_sg.id

  description = "SSH access from allowed CIDR"
}

# Inbound: SonarQube Web UI from Jenkins only
resource "aws_security_group_rule" "sonarqube_web" {
  type              = "ingress"
  from_port         = 9000
  to_port           = 9000
  protocol          = "tcp"
  cidr_blocks       = [var.vpc_cidr]
  security_group_id = aws_security_group.sonarqube_sg.id

  description = "SonarQube web UI from Jenkins"
}

# Inbound: PostgreSQL from VPC
resource "aws_security_group_rule" "sonarqube_postgres" {
  type              = "ingress"
  from_port         = 5432
  to_port           = 5432
  protocol          = "tcp"
  cidr_blocks       = [var.vpc_cidr]
  security_group_id = aws_security_group.sonarqube_sg.id

  description = "PostgreSQL database"
}

# Outbound: All traffic to anywhere
resource "aws_security_group_rule" "sonarqube_egress" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.sonarqube_sg.id

  description = "Allow all outbound traffic"
}


# SECURITY GROUP 3: DOCKER BUILDER

resource "aws_security_group" "docker_sg" {
  name_prefix = "${var.project_name}-docker-"
  description = "Security group for Docker builder"
  vpc_id      = var.vpc_id

  tags = {
    Name = "${var.project_name}-docker-sg"
  }

  lifecycle {
    create_before_destroy = true
  }
}

# Inbound: SSH from VPC only
resource "aws_security_group_rule" "docker_ssh" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  cidr_blocks       = [var.vpc_cidr]
  security_group_id = aws_security_group.docker_sg.id

  description = "SSH access from VPC (Jenkins)"
}

# Inbound: Docker Daemon from VPC
resource "aws_security_group_rule" "docker_daemon" {
  type              = "ingress"
  from_port         = 2375
  to_port           = 2375
  protocol          = "tcp"
  cidr_blocks       = [var.vpc_cidr]
  security_group_id = aws_security_group.docker_sg.id

  description = "Docker daemon API"
}

# Inbound: Docker Registry from VPC
resource "aws_security_group_rule" "docker_registry" {
  type              = "ingress"
  from_port         = 5000
  to_port           = 5000
  protocol          = "tcp"
  cidr_blocks       = [var.vpc_cidr]
  security_group_id = aws_security_group.docker_sg.id

  description = "Docker registry"
}

# Outbound: All traffic to anywhere
resource "aws_security_group_rule" "docker_egress" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.docker_sg.id

  description = "Allow all outbound traffic"
}
