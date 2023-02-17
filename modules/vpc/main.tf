#GUIDE
#Are you in the appropriate region
#Did you select the appropriate vpc
#Did you select the appropriate subnet/availability zone?
#Did you configure security group and allow the right
    #port 80 = internet traffic
    #port 22  = SSH 


# create vpc
resource "aws_vpc" "vpc" {
  cidr_block              = var.vpc_cidr
  instance_tenancy        = "default"
  enable_dns_hostnames    = true

  tags      = {
    Name    = "${var.project_name}-vpc"
  }
}

# create internet gateway and attach it to vpc
resource "aws_internet_gateway" "internet_gateway" {
  vpc_id    = aws_vpc.vpc.id

  tags      = {
    Name    = "${var.project_name}-igw"
  }
}

# use data source to get all avalablility zones in region
data "aws_availability_zones" "available_zones" {}

# create public subnet az1
resource "aws_subnet" "public_subnet_az1" {
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = var.public_subnet_az1_cidr
  availability_zone       = data.aws_availability_zones.available_zones.names[0]
  map_public_ip_on_launch = true

  tags      = {
    Name    = "public_subnet_az1"
  }
}

# create public subnet az2
resource "aws_subnet" "public_subnet_az2" {
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = var.public_subnet_az2_cidr
  availability_zone       = data.aws_availability_zones.available_zones.names[1]
  map_public_ip_on_launch = true

  tags      = {
    Name    = "public_subnet_az2"
  }
}

# create route table and add public route
resource "aws_route_table" "public_route_table" {
  vpc_id       = aws_vpc.vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.internet_gateway.id
  }

  tags       = {
    Name     = "public route table"
  }
}

# associate public subnet az1 to "public route table"
resource "aws_route_table_association" "public_subnet_az1_route_table_association" {
  subnet_id           = aws_subnet.public_subnet_az1.id
  route_table_id      = aws_route_table.public_route_table.id
}

# associate public subnet az2 to "public route table"
resource "aws_route_table_association" "public_subnet_az2_route_table_association" {
  subnet_id           = aws_subnet.public_subnet_az2.id
  route_table_id      = aws_route_table.public_route_table.id
}

# create private app subnet az1
resource "aws_subnet" "private_app_subnet_az1" {
  vpc_id                   =  aws_vpc.vpc.id
  cidr_block               = var.private_app_subnet_az1_cidr
  availability_zone        = data.aws_availability_zones.available_zones.names[0]
  map_public_ip_on_launch  = false

  tags      = {
    Name    = "private app subnet az1"
  }
}

# create private app subnet az2
resource "aws_subnet" "private_app_subnet_az2" {
  vpc_id                   = aws_vpc.vpc.id
  cidr_block               = var.private_app_subnet_az2_cidr
  availability_zone        = data.aws_availability_zones.available_zones.names[1]
  map_public_ip_on_launch  = false

  tags      = {
    Name    = "private app subnet az2"
  }
}

# create private data subnet az1
resource "aws_subnet" "private_data_subnet_az1" {
  vpc_id                   = aws_vpc.vpc.id
  cidr_block               = var.private_data_subnet_az1_cidr
  availability_zone        = data.aws_availability_zones.available_zones.names[0]
  map_public_ip_on_launch  = false

  tags      = {
    Name    = "private data subnet az1"
  }
}

# create private data subnet az2
resource "aws_subnet" "private_data_subnet_az2" {
  vpc_id                   = aws_vpc.vpc.id
  cidr_block               = var.private_data_subnet_az2_cidr
  availability_zone        = data.aws_availability_zones.available_zones.names[1]
  map_public_ip_on_launch  = false

  tags      = {
    Name    = "private data subnet az2"
  }
}


# resource "aws_instance" "jengomartuswest1_ec2" {
#   # Creates eight identical aws ec2 instances for AZ1
#   count = 8

#   # All eight instances will have the same ami and instance_type - CentOS 7 
#   ami           = var.ec2_ami
#   instance_type = var.ec2_instance_type
#   key_name      = var.ec2_eastkey

#   ebs_block_device {
#     device_name           = "/dev/sda1"
#     volume_size           = 250
#     delete_on_termination = false
#   }
#   security_groups = [aws_security_group.ec2-SG.id]
#   subnet_id       = aws_subnet.subnet_1_private.id
#   tags = {
#     # The count.index allows you to launch a resource 
#     # starting with the distinct index number 0 and corresponding to this instance.
#     Name = "jengomart_ec2a-${count.index}"
#   }
# }


# resource "aws_instance" "jengomartuseastb_ec2" {
#   # Creates eight identical aws ec2 instances for AZ2
#   count = 8

#   # All six instances will have the same ami and instance_type - CentOS 7 
#   ami           = var.ec2_ami
#   instance_type = var.ec2_instance_type
#   key_name      = var.ec2_eastkey
#   ebs_block_device {
#     device_name           = "/dev/sda1"
#     volume_size           = 250
#     delete_on_termination = false
#   }
#   security_groups = [aws_security_group.ec2-SG.id]
#   subnet_id       = aws_subnet.subnet_2_private.id
#   tags = {
#     # The count.index allows you to launch a resource 
#     # starting with the distinct index number 0 and corresponding to this instance.
#     Name = "jengomart_ec2b-${count.index}"
#   }
# }
# resource "aws_instance" "jengomartuseastc_ec2" {
#   # Creates four identical aws ec2 instances for AZ2
#   count = 4

#   # All four instances will have the same ami and instance_type - CentOS 7 
#   ami           = var.ec2_ami
#   instance_type = var.ec2_instance_type
#   key_name      = var.ec2_eastkey
#   ebs_block_device {
#     device_name           = "/dev/sda1"
#     volume_size           = 250
#     delete_on_termination = false
#   }
#   security_groups = [aws_security_group.ec2-SG.id]
#   subnet_id       = aws_subnet.subnet_2_private.id
#   tags = {
#     # The count.index allows you to launch a resource 
#     # starting with the distinct index number 0 and corresponding to this instance.
#     Name = "jengomart_ec2c-${count.index}"
#   }
# }


