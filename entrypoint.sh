#!/bin/sh
set -e

# Garante que o diretório de dados exista
mkdir -p /var/lib/unbound

# Baixa a trust anchor se não existir
if [ ! -f /var/lib/unbound/root.key ]; then
    echo "Downloading DNSSEC trust anchor..."
    unbound-anchor -a /var/lib/unbound/root.key || exit 1
fi

# Inicia o Unbound em modo foreground
exec unbound -d -v