[English Version](README.EN.md)

# Unbound

Implementação em Docker e Kubernetes de um servidor de DNS recursivo utilizando o Unbound.

## Como executar

### Docker

Na pasta ```docker```, abra um Terminal, Prompt de Comando ou PowerShell, e digite o seguinte comando:

```shell
docker compose up -d
```

### Kubernetes

Na pasta ```k8s```, abra um Terminal, Prompt de Comando ou PowerShell, e digite o seguinte comando:

```shell
kubectl apply -k .
```