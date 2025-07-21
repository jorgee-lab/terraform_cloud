
###### VPC ######

resource "aws_vpc" "vpc_lab_tf" {
  cidr_block = var.vpc_lab_tf_cidr
    tags = {
    Name = "vpc_lab_tf-${local.sufix}"
    # env = "Dev"
    # tags = var.tags
  }
}

###### Subred Publica ######

resource "aws_subnet" "PublicSubnet" {
  vpc_id     = aws_vpc.vpc_lab_tf.id
  cidr_block = var.subnets[0]
  map_public_ip_on_launch = true
  tags = {
    Name = "PublicSubnet-${local.sufix}"
  # tags = var.tags
  }
}

###### Subred Privada ######

resource "aws_subnet" "PrivateSubnet" {
  vpc_id     = aws_vpc.vpc_lab_tf.id
  cidr_block = var.subnets[1]
  tags = {
    Name = "PrivateSubnet-${local.sufix}"
  # tags = var.tags
  }
  depends_on = [
    aws_subnet.PublicSubnet
  ]
}

###### Internet Gateway ######

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc_lab_tf.id

  tags = {
    Name = "igw vpc lab tf-${local.sufix}"
  }
}

###### Tabla se enrutamiento ######

resource "aws_route_table" "Publicrtb" {
  vpc_id = aws_vpc.vpc_lab_tf.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name = "Public Rtb-${local.sufix}"
  }
}

resource "aws_route_table_association" "rtb_public_subnet" {
  subnet_id      = aws_subnet.PublicSubnet.id
  route_table_id = aws_route_table.Publicrtb.id
}

###### Grupo de Seguridad ######

resource "aws_security_group" "sg_web_instance" {
  name        = "sdefag_web_instanceult"
  description = "sg_web_instance VPC security group"
  vpc_id      = aws_vpc.vpc_lab_tf.id

  dynamic "ingress" {
    for_each = var.ingress_port_list
      content {
        from_port = ingress.value
        to_port = ingress.value
        protocol = "tcp"
        cidr_blocks = [var.sg_ingress_cidr]
    }
}

  # ingress {
  #   description = "ssh access"
  #   from_port         = 22
  #   protocol          = "tcp"
  #   to_port           = 22
  #   cidr_blocks       = [var.sg_ingress_cidr]
  # }

  # ingress {
  #   description = "http access"
  #   from_port         = 80
  #   protocol          = "tcp"
  #   to_port           = 80
  #   cidr_blocks       = [var.sg_ingress_cidr]
  # }

  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = "sg_web_instance-${local.sufix}"
  }
}

module "mybucket" {
  source = "./modulos/s3"
  bucket_name = "maximobk24681012141618" 
}

output "s3_arn" {
  value       = module.mybucket.s3_bucket_arn
}

# module "terraform_state_backend" {
#      source = "cloudposse/tfstate-backend/aws"
#      version     = "1.5.0"
#      namespace  = "jorge-lab"
#      stage      = "prod"
#      name       = "terraform"
#      attributes = ["state"]

#      terraform_backend_config_file_path = "."
#      terraform_backend_config_file_name = "backend.tf"
#      force_destroy                      = false
#    }