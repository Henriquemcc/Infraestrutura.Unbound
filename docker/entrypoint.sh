#!/bin/sh
set -eu

# Garante que o diretório de dados exista
mkdir -p /var/lib/unbound

# Ajusta permissões apenas se o usuário unbound existir
if id unbound >/dev/null 2>&1; then
    chown -R unbound:unbound /etc/unbound /var/lib/unbound || true
fi

# Tenta gerar a trust anchor, mas não derruba o container se a rede ou a
# infraestrutura não estiverem prontas no momento do boot.
if [ ! -f /var/lib/unbound/root.key ]; then
    echo "DNSSEC trust anchor not found; attempting to generate it..."
    if ! unbound-anchor -a /var/lib/unbound/root.key; then
        echo "Warning: could not generate DNSSEC trust anchor. Continuing without it."
    fi
fi

# Inicia o Unbound em modo foreground com configurações explícitas
exec unbound -d -v -c /etc/unbound/unbound.conf