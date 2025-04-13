provider "aws" {
  region = "us-east-1"
}

#Creación de la VPC
resource "aws_vpc" "mi_vpc_3" {
  cidr_block = "10.10.0.0/20"
  tags = {
    Name = "VPC_Terraform_3"
  }
}

#Creación de la subred pública
resource "aws_subnet" "subred_publica_3" {
  vpc_id = aws_vpc.mi_vpc_3.id
  cidr_block = "10.10.0.0/24"
  map_public_ip_on_launch = true
  tags = {
    Name = "Subred_Publica_3"
  }
}

#Creación del Internet Gateway
resource "aws_internet_gateway" "igw_3" {
  vpc_id = aws_vpc.mi_vpc_3.id
  tags = {
    Name = "IGW_Terraform_3"
  }
}

#Creación de la tabla de rutas
resource "aws_route_table" "ruta_publica_3" {
  vpc_id = aws_vpc.mi_vpc_3.id

  route{
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw_3.id
  }
  tags = {
    Name = "Tabla_Rutas_Publicas_3"
  }
}

#Asociación de la tabla de rutas a la subred pública
resource "aws_route_table_association" "asociacion_rutas_3" {
  subnet_id = aws_subnet.subred_publica_3.id
  route_table_id = aws_route_table.tabla_rutas_publicas_3.id
}

#Creación del Security Group para el Linux Jump Server
resource "aws_security_group" "sg_linux_js_3" {
  name = "sg_linux_js_3"
  description = "Grupo de Seguridad para el Linux Jump Server"
  vpc_id = aws_vpc.mi_vpc_3.id

  #Reglas de entrada del Linux Jump Server

  #Entrada SSH
  ingress {
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  #Reglas de salida del Linux Jump Server

  #Salida SSH
  ingress {
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  #Salida a Todo el Tráfico
  ingress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

#Instancia de Linux Jump Server
resource "aws_instance" "linux_js_3" {
  ami = "ami-00a929b66ed6e0de6"
  instance_type = "t2.medium"
  subnet_id = aws_subnet.subred_publica_3.id
  vpc_security_group_ids = [aws_security_group.sg_linux_js_3.id]
  key_name = "vockey"

  tags = {
    Name = "Linux_JS_3"
  }
}

#Creación del Security Group para el Windows Web Server 1
resource "aws_security_group" "sg_linux_ws1_3" {
  name = "sg_linux_ws1_3"
  description = "Grupo de Seguridad para el Windows Web Server 1"
  vpc_id = aws_vpc.mi_vpc_3.id

  #Reglas de entrada del Windows Web Server 1

  #Entrada SSH
  ingress {
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  #Entrada de Todo el Tráfico
  ingress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  #Reglas de salida del Windows Web Server 1
  
  #Salida de Todo el Tráfico
  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  #Salida HTTP
  egress {
    from_port = 80
    to_port = 80
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

#Instancia de Windows Web Server 1
resource "aws_instance" "linux_ws1_3" {
  ami = "ami-00a929b66ed6e0de6"
  instance_type = "t2.micro"
  subnet_id = aws_subnet.subred_publica_3.id
  vpc_security_group_ids = [aws_security_group.sg_linux_ws1_3.id]
  key_name = "vockey"

  tags = {
    Name = "Linux_WS1_3"
  }
}

#Creación del Security Group para el Windows Web Server 2
resource "aws_security_group" "sg_linux_ws2_3" {
  name = "sg_linux_ws2_3"
  description = "Grupo de Seguridad para el Windows Web Server 2"
  vpc_id = aws_vpc.mi_vpc_3.id

  #Reglas de entrada del Windows Web Server 2

  #Entrada SSH
  ingress {
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  #Entrada de Todo el Tráfico
  ingress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  #Reglas de salida del Windows Web Server 2
  
  #Salida de Todo el Tráfico
  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  #Salida HTTP
  egress {
    from_port = 80
    to_port = 80
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

#Instancia de Windows Web Server 2
resource "aws_instance" "linux_ws2_3" {
  ami = "ami-00a929b66ed6e0de6"
  instance_type = "t2.micro"
  subnet_id = aws_subnet.subred_publica_3.id
  vpc_security_group_ids = [aws_security_group.sg_linux_ws1_3.id]
  key_name = "vockey"

  tags = {
    Name = "Linux_WS2_3"
  }
}

#Creación del Security Group para el Windows Web Server 3
resource "aws_security_group" "sg_linux_ws3_3" {
  name = "sg_linux_ws3_3"
  description = "Grupo de Seguridad para el Windows Web Server 3"
  vpc_id = aws_vpc.mi_vpc_3.id

  #Reglas de entrada del Windows Web Server 3

  #Entrada SSH
  ingress {
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  #Entrada de Todo el Tráfico
  ingress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  #Reglas de salida del Windows Web Server 3
  
  #Salida de Todo el Tráfico
  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  #Salida HTTP
  egress {
    from_port = 80
    to_port = 80
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

#Instancia de Windows Web Server 3
resource "aws_instance" "linux_ws3_3" {
  ami = "ami-00a929b66ed6e0de6"
  instance_type = "t2.micro"
  subnet_id = aws_subnet.subred_publica_3.id
  vpc_security_group_ids = [aws_security_group.sg_linux_ws1_3.id]
  key_name = "vockey"

  tags = {
    Name = "Linux_WS3_3"
  }
}

#Creación del Security Group para el Windows Web Server 4
resource "aws_security_group" "sg_linux_ws4_3" {
  name = "sg_linux_ws4_3"
  description = "Grupo de Seguridad para el Windows Web Server 4"
  vpc_id = aws_vpc.mi_vpc_3.id

  #Reglas de entrada del Windows Web Server 4

  #Entrada SSH
  ingress {
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  #Entrada de Todo el Tráfico
  ingress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  #Reglas de salida del Windows Web Server 4
  
  #Salida de Todo el Tráfico
  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  #Salida HTTP
  egress {
    from_port = 80
    to_port = 80
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

#Instancia de Windows Web Server 4
resource "aws_instance" "linux_ws4_3" {
  ami = "ami-00a929b66ed6e0de6"
  instance_type = "t2.micro"
  subnet_id = aws_subnet.subred_publica_3.id
  vpc_security_group_ids = [aws_security_group.sg_linux_ws1_3.id]
  key_name = "vockey"

  tags = {
    Name = "Linux_WS4_3"
  }
}

#Salidas de IPs Públicas

output "linux_js_3_public_ip" {
  value = aws_instance.linux_js_3.public_ip
  description = "IP Pública del Linux Jump Server"
}

output "linux_ws1_3_public_ip" {
  value = aws_instance.linux_ws1_3.public_ip
  description = "IP Pública del Windows Web Server 1"
}

output "linux_ws2_3_public_ip" {
  value = aws_instance.linux_ws2_3.public_ip
  description = "IP Pública del Windows Web Server 2"
}

output "linux_ws3_3_public_ip" {
  value = aws_instance.linux_ws3_3.public_ip
  description = "IP Pública del Windows Web Server 3"
}

output "linux_ws4_3_public_ip" {
  value = aws_instance.linux_ws4_3.public_ip
  description = "IP Pública del Windows Web Server 4"
}