output "key_pair_name" {
  description = "Name of the SSH key pair"
  value       = aws_key_pair.cicd_keypair.key_name
}

output "key_pair_id" {
  description = "ID of the SSH key pair"
  value       = aws_key_pair.cicd_keypair.id
}
