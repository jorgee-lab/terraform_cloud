vpc_lab_tf_cidr = "10.0.0.0/16"
# subnetpublic = "10.0.1.0/24"
# subnetprivate = "10.0.2.0/24"
subnets = ["10.0.1.0/24", "10.0.2.0/24"]

tags = {
    "env" = "dev"
    "owner" = "Jorge"
    "Cloud" = "AWS"
    "IAC" = "Terraform" 
    "project" = "maximo"
    "region" = "virginia"
}
sg_ingress_cidr = "0.0.0.0/0"


ec2_specs = {
    "ami" = "ami-05ffe3c48a9991133"
    "instance_type" = "t2.micro"
}

#enable_monitoring = true
enable_monitoring = 0
ingress_port_list = [22, 80, 443]