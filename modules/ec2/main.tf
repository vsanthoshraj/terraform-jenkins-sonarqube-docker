
# EC2 Module - Main Configuration
# File: modules/ec2/main.tf
# Purpose: Create 3 EC2 instances with Elastic IPs

# EC2 INSTANCE 1: JENKINS

resource "aws_instance" "jenkins" {
  ami                    = var.ami_id
  instance_type          = var.instance_type
  subnet_id              = var.subnet_id
  key_name               = var.key_name
  vpc_security_group_ids = [var.jenkins_sg_id]
  
  root_block_device {
    volume_type           = "gp2"
    volume_size           = var.jenkins_volume_size
    delete_on_termination = true
    encrypted             = false

    tags = {
      Name = "${var.project_name}-jenkins-root"
    }
  }

  monitoring = true

  tags = {
    Name        = "${var.project_name}-jenkins-master"
    Environment = var.environment
    Service     = "Jenkins"
  }
}

resource "aws_eip" "jenkins_eip" {
  instance = aws_instance.jenkins.id
  domain   = "vpc"

  tags = {
    Name = "${var.project_name}-jenkins-eip"
  }

  depends_on = [aws_instance.jenkins]
}

resource "aws_instance" "sonarqube" {
  ami                    = var.ami_id
  instance_type          = var.instance_type
  subnet_id              = var.subnet_id
  key_name               = var.key_name
  vpc_security_group_ids = [var.sonarqube_sg_id]
  
  root_block_device {
    volume_type           = "gp2"
    volume_size           = var.sonarqube_volume_size
    delete_on_termination = true
    encrypted             = false

    tags = {
      Name = "${var.project_name}-sonarqube-root"
    }
  }

  monitoring = true

  tags = {
    Name        = "${var.project_name}-sonarqube-server"
    Environment = var.environment
    Service     = "SonarQube"
  }
}

resource "aws_eip" "sonarqube_eip" {
  instance = aws_instance.sonarqube.id
  domain   = "vpc"

  tags = {
    Name = "${var.project_name}-sonarqube-eip"
  }

  depends_on = [aws_instance.sonarqube]
}

resource "aws_instance" "docker" {
  ami                    = var.ami_id
  instance_type          = var.instance_type
  subnet_id              = var.subnet_id
  key_name               = var.key_name
  vpc_security_group_ids = [var.docker_sg_id]
  
  root_block_device {
    volume_type           = "gp2"
    volume_size           = var.docker_volume_size
    delete_on_termination = true
    encrypted             = false

    tags = {
      Name = "${var.project_name}-docker-root"
    }
  }

  monitoring = true

  tags = {
    Name        = "${var.project_name}-docker-builder"
    Environment = var.environment
    Service     = "Docker"
  }
}

resource "aws_eip" "docker_eip" {
  instance = aws_instance.docker.id
  domain   = "vpc"

  tags = {
    Name = "${var.project_name}-docker-eip"
  }

  depends_on = [aws_instance.docker]
}
