# Grupo de segurança
resource "aws_security_group" "acesso_geral" {
    name = var.grupoDeSeguranca
    # Regras de entrada
    ingress {
        cidr_blocks = [ "0.0.0.0/0" ]
        ipv6_cidr_blocks = [ "::/0" ]
        from_port = 0
        to_port = 0
        protocol = "-1"
    }
    # Regras de saida
    egress {
         cidr_blocks = [ "0.0.0.0/0" ]
        ipv6_cidr_blocks = [ "::/0" ]
        from_port = 0
        to_port = 0
        protocol = "-1"
    }
    
    tags = {
        Name = "acesso_geral"
    }
}