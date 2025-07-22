resource "aws_instance" "name" {
   ami = "ami-05ffe3c48a9991133"
   instance_type = "t2.micro"
   tags = {
     name = "statefile"
   }

}
resource "aws_s3_bucket" "name" {
    bucket = "devopsterraformstatefilebackend"
  
}