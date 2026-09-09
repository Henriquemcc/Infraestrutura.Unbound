FROM alpine

# Instalando requisitos
RUN apk add --no-cache unbound curl ca-certificates

# Usando RUN curl em vez de ADD URL
RUN mkdir -p /etc/unbound && \
    curl -o /etc/unbound/root.hints https://www.internic.net/domain/named.root

# Copiando arquivo de configuração
COPY unbound.conf /etc/unbound/unbound.conf

# Copiando Entrypoint
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

# Criando diretório e definindo usuário (best practice)
RUN mkdir -p /var/lib/unbound && \
    chown -R unbound:unbound /etc/unbound /var/lib/unbound

EXPOSE 53/udp 53/tcp

# Mudando para o usuário não-root
USER unbound
CMD ["/entrypoint.sh"]