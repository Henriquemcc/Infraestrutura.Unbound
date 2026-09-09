[Versão em Português](README.md)

# Unbound

Docker and Kubernetes implementation of a recursive DNS server using Unbound.

## How to run

### Docker

In the `docker` folder, open a Terminal, Command Prompt, or PowerShell window and run the following command:

```shell
docker compose up -d
```

### Kubernetes

In the `k8s` folder, open a Terminal, Command Prompt, or PowerShell window and run the following command:

```shell
kubectl apply -k .
```