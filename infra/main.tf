terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.27"
    }
  }

  required_version = ">= 0.14.9"
}

provider "aws" {
  profile = "default"
  region  = var.regiao_aws
}

# Template para maquinas
resource "aws_launch_template" "maquina" {
  image_id           = "ami-03d5c68bab01f3496"
  instance_type = var.instancia
  key_name = var.chave

  security_group_names = [ var.grupoDeSeguranca ]
  user_data = var.producao ? filebase64("ansible.sh") : ""

  tags = {
    Name = "Terraform Ansible Python"
  }
}

# Chave SSH
resource "aws_key_pair" "chaveSSH" {
  key_name = var.chave
  public_key = file("${var.chave}.pub")
}

# Criando ASG
resource "aws_autoscaling_group" "grupo" {
  availability_zones = [ "${var.regiao_aws}a", "${var.regiao_aws}b" ]
  name = var.nomeGrupo
  min_size = var.minimo
  max_size = var.maximo
  desired_capacity = 1
  target_group_arns = var.producao ? [ aws_lb_target_group.alvoLoadBalancer[0].arn ] : []

  launch_template {
    id = aws_launch_template.maquina.id
    version = "$Latest"
  }
}

# VPC_ID
resource "aws_default_vpc" "default" {  
}

# Subnets
resource "aws_default_subnet" "subnet_1" {
  availability_zone = "${var.regiao_aws}a"
}

# Subnets
resource "aws_default_subnet" "subnet_2" {
  availability_zone = "${var.regiao_aws}b"
}

# LoadBalancer
resource "aws_lb" "loadBalancer" {
  internal = false
  subnets = [ aws_default_subnet.subnet_1.id, aws_default_subnet.subnet_2.id ]
  count = var.producao ? 1 : 0
}

# LoadBalancer Alvo
resource "aws_lb_target_group" "alvoLoadBalancer" {
  name = "maquinasAlvo"
  port = "8000"
  protocol = "HTTP"
  vpc_id = aws_default_vpc.default.id
  count = var.producao ? 1 : 0
}

# LoadBalancer Listener
resource "aws_lb_listener" "entradaLoadBalancer" {
  load_balancer_arn = aws_lb.loadBalancer[0].arn
  port = "8000"
  protocol = "HTTP"
  default_action {
    type = "forward"
    target_group_arn = aws_lb_target_group.alvoLoadBalancer[0].arn
  }
  count = var.producao ? 1 : 0
}

resource "aws_autoscaling_policy" "escala-Producao" {
  name = "terraform-escala"
  autoscaling_group_name = var.nomeGrupo
  policy_type = "TargetTrackingScalling"  # Por uso de CPU
  target_tracking_configuration {
    predefined_metric_specification {
      predefined_metric_type = "ASGAverageCPUUtilization"
    }
    target_value = 50.0
  }
  count = var.producao ? 1 : 0
}