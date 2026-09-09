FROM alpine

# Instalando requisitos
RUN apk add --no-cache unbound drill ca-certificates openssl certbot

# Baixando o root hints
WORKDIR /etc/unbound
ADD https://www.internic.net/domain/named.root root.hints
RUN chmod 777 root.hints

# Copiando arquivo de configuração
WORKDIR /etc/unbound
COPY unbound.conf unbound.conf

# Copiando Entrypoint
WORKDIR /
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

# Definindo permissões corretas
RUN mkdir -p /var/lib/unbound
RUN chown -R unbound:unbound /etc/unbound /var/lib/unbound

EXPOSE 53/udp 853/tcp 443/tcp

CMD ["/entrypoint.sh"]
