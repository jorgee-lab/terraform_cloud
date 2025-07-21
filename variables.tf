variable "vpc_lab_tf_cidr" {
description = "CIDR_lab_tf"
type = string
}

# variable "subnetpublic" {
# description = "CIDR public subnet"
# type = string
# }

# variable "subnetprivate" {
# description = "CIDR private subnet"
# type = string
# }`

variable "subnets" {
    description = "Lista de subnets"
    type = list(string)
}

variable "tags" {
    description = "Tags del proyectos"
    type = map(string)
}

variable "sg_ingress_cidr" {
    description = "CIDR for ingress traffic"
    type = string
}

variable "ec2_specs" {
    description = "Parametros de la instancia"
    type = map(string)    
}

variable "enable_monitoring" {
  #type        = bool
  type = number
  description = "Habilita el despliegue de un servidor de monitoreo"
}

variable "ingress_port_list" {
  type        = list(number)
  description = "Lista de puertos ingress"
}
