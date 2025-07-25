# vpc creation process
resource "aws_vpc" "name" {
  cidr_block = "10.0.0.0/16"
  tags = {
    Name = "test"
  }
}
# subnet creation
resource "aws_subnet" "pub1" {
  vpc_id = aws_vpc.name.id
  cidr_block = "10.0.0.0/24"
  availability_zone = "us-east-1a"
  tags = {
    Name ="testsubnet"
  }
}
# interne gateway
resource "aws_internet_gateway" "name" {
    vpc_id = aws_vpc.name.id
    tags = {
      Name = "testIG"
    }
}
# route table # edit route
resource "aws_route_table" "name" {
    vpc_id = aws_vpc.name.id
    route  {
        cidr_block ="0.0.0.0/0"
        gateway_id = aws_internet_gateway.name.id
    }
}
# subnet assotion
resource "aws_route_table_association" "name" {
    subnet_id = aws_subnet.pub1.id
    route_table_id = aws_route_table.name.id
  
}
# SG group
resource "aws_security_group" "allow_tls" {
  name        = "allow_tls"
  vpc_id      = aws_vpc.name.id
  tags = {
    Name = "dev_sg"
  }
 ingress {
    description      = "TLS from VPC"
    from_port        = 80
    to_port          = 80
    protocol         = "TCP"
    cidr_blocks      = ["0.0.0.0/0"]
    
  }
ingress {
    description      = "TLS from VPC"
    from_port        = 22
    to_port          = 22
    protocol         = "TCP"
    cidr_blocks      = ["0.0.0.0/0"]
    
  }
ingress {
    description      = "TLS from VPC"
    from_port        = 443
    to_port          = 443
    protocol         = "TCP"
    cidr_blocks      = ["0.0.0.0/0"]
}
egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1" #all protocols 
    cidr_blocks      = ["0.0.0.0/0"]
    
  }
}

# nat
#elastic ip
resource "aws_eip" "lb" {
  instance = aws_instance.name.id
  domain   = "vpc"
}
#public nat
resource "aws_nat_gateway" "nat" {
  allocation_id = aws_eip.lb.id
  subnet_id = aws_subnet.pub1.id
  tags = {
    Name = "natid"
  }
depends_on = [ aws_internet_gateway.name ]
}
#private nat
resource "aws_nat_gateway" "name2" {
  connectivity_type = "private"
  subnet_id         = aws_subnet.pub1.id
}
# ec2 creation
resource "aws_instance" "name" {
   ami           = "ami-05ffe3c48a9991133"
  instance_type = "t2.micro"
  key_name      = "test"
  subnet_id =  aws_subnet.pub1.id
  vpc_security_group_ids = [ aws_security_group.allow_tls.id ]
}