## Para executar o ansible dentro da maquina aws, digite o código:
```
ansible-playbook playbook.yml -u ubuntu --private-key "nome da sua chave .pem" -i hosts.yml
```
substituir o que está dentro das " " pelo nome da key.pem aws para ssh.
___

## Subindo um projeto python:
criar com django: 
```
django-admin startproject setup .
rodar o manage.py dentro na venv: python mange.py runserver 0.0.0.0:8000
```

* alterar o ALLOWED_HOSTES para ALLOWED_HOSTES - ['*'] dentro de settings.py para poder acessar 
___

## Criar chave ssh:
```
ssh-keygen
```

## Para proteger a chave:
```
chmod 400 env/Prod/Iac-Prod.pub
```

## Para pegar o ip dentro da env/Dev ou env/Prod, executar: 
```
terraform output
```
___
## Caminho para prod do ansible:
```
ansible-playbook env/Prod/playbook.yml -i infra/hosts.yml -u ubuntu --private-key env/Prod/Iac-Prod
```
___
## Para acessar via ssh:
```
ssh -i env/Prod/Iac-Prod ubuntu@"ip da maquina"
```
___

## Ativar a venv do python:
```
. venv/bin/activate
```
___

## Verificar as dependências do projeto:
```
pip freeze
```