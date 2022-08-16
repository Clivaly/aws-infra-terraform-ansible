variable "regiao_aws" {
  type        = string
  description = "description"
}

variable "chave" {
  type        = string
  description = "description"
}

variable "instancia" {
  type        = string
  description = "description"
}

variable "grupoDeSeguranca" {
  type = string
}

variable "nomeGrupo" {
  type = string
}
variable "minimo" {
  type = number
}

variable "maximo" {
  type = number
}

variable "producao" {
  type = bool
}