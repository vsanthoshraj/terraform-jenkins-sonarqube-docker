locals {
  public_key_content = file(var.ssh_public_key_path)
}

resource "aws_key_pair" "cicd_keypair" {
  key_name   = "${var.project_name}-keypair"
  public_key = local.public_key_content

  tags = {
    Name = "${var.project_name}-keypair"
  }
}
