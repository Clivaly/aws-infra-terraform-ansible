module "aws-dev" {
  source = "../../infra"
  instancia = "t2.micro"
  regiao_aws = "us-west-2"
  chave = "Iac-Dev"
  grupoDeSeguranca = "DEVELOPER"
  minimo = 0
  maximo = 1
  nomeGrupo = "Dev"
  producao = false
}
