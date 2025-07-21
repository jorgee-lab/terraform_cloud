variable "instancias" {
  type        = list(string)
  #type        = set(string)
  description = "Nombre de las instancias"
  default = [ "apache",]
}




resource "aws_instance" "web_instance" {
  #count = 3 #Agrega 3 instancias
  #count = length(var.instancias) #si a la funcion se le pasa una lista, el count se va basar en el resultado de la funcion, como existen 3 elementos va dsesplegar 3 instancias. 
  for_each = toset(var.instancias) #Creara una instancia por cada elemento de la lista
  ami = var.ec2_specs.ami
  instance_type = var.ec2_specs.instance_type
  subnet_id = aws_subnet.PublicSubnet.id 
  key_name = data.aws_key_pair.vockey.key_name
  vpc_security_group_ids = [aws_security_group.sg_web_instance.id]
  user_data = file("user_data.sh")
  tags = {
    #Name = var.instancias[count.index] #esta variable de relacion con la funcion length. Cuando cree 3 instancias, usara los  indices de los valores para asignarlos como nombre.
    "Name" = "${each.value}-${local.sufix}" #Asigna como nombre cada elemento + el sufijo creado en loc
  }

}

resource "aws_instance" "monitoring_instance" {
  #count = var.enable_monitoring ? 1:0 #Estructura condicional (?) lo que se evalua es la variable (que para este caso es un booleano). depende del resultado de la variable si se despliega servidor. 
  count = var.enable_monitoring == 1 ? 1 : 0
  ami = var.ec2_specs.ami
  instance_type = var.ec2_specs.instance_type
  subnet_id = aws_subnet.PublicSubnet.id 
  key_name = data.aws_key_pair.vockey.key_name
  vpc_security_group_ids = [aws_security_group.sg_web_instance.id]
  tags = {
    
    "Name" = "Monitoreo-${local.sufix}"
    
  }

}