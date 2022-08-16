module "aws-prod" {
  source = "../../infra"
  instancia = "t2.micro"
  regiao_aws = "us-west-2"
  chave = "Iac-Prod"
  grupoDeSeguranca = "PRODUCAO"
  minimo = 1
  maximo = 10
  nomeGrupo = "Prod"
  producao = true
}
