output "ip" {
    value = aws_instance.name.public_ip
  
}
output "vpc" {
    value = aws_instance.name.vpc_security_group_ids
  
}