#!/bin/sh
set -eu

# Garante que o diretório de dados exista e seja gravável para o usuário do Unbound
mkdir -p /var/lib/unbound

if [ "$(id -u)" = "0" ] && id unbound >/dev/null 2>&1; then
    chown -R unbound:unbound /etc/unbound /var/lib/unbound
fi

# Gera o trust anchor somente se ainda não existir
if [ ! -f /var/lib/unbound/root.key ]; then
    echo "DNSSEC trust anchor not found; attempting to generate it..."
    if ! unbound-anchor -a /var/lib/unbound/root.key; then
        echo "Warning: could not generate DNSSEC trust anchor. Continuing without it."
    fi
fi

# Inicia o Unbound em modo foreground com a configuração correta
exec unbound -d -v -c /etc/unbound/unbound.conf