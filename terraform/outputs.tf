# Output the public IP address of the EC2 instance
output "instance_public_ip" {
  value = aws_instance.fastapi_instance.public_ip
}

# Output the Elastic IP (if used)
output "eip_address" {
  value = aws_eip.fastapi_eip.public_ip
}
