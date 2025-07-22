resource "aws_instance" "name" {
   ami          = var.ami_id
  instance_type = var.instance_type
  #instance_type = "t3.micro"
  key_name      = "test"
  tags = {
    name = "day-3"
  }
  
}