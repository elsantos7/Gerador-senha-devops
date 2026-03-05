#!/bin/bash

set -e

PACKAGE_NAME="gerador-senha-devops"
PACKAGE_DIR="."
OUTPUT_DEB="../${PACKAGE_NAME}.deb"

echo "🔧 Iniciando build do pacote .deb..."

# 1️⃣ Verificações básicas
if [ ! -d "$PACKAGE_DIR/DEBIAN" ]; then
  echo "❌ Pasta DEBIAN não encontrada."
  exit 1
fi

if [ ! -f "$PACKAGE_DIR/DEBIAN/control" ]; then
  echo "❌ Arquivo DEBIAN/control não encontrado."
  exit 1
fi

if [ ! -f "$PACKAGE_DIR/usr/bin/gerador-senha-devops" ]; then
  echo "❌ Executável não encontrado em usr/bin/gerador-senha-devops"
  exit 1
fi

# 2️⃣ Garantir permissão do executável
echo "🔑 Ajustando permissão do executável..."
chmod +x "$PACKAGE_DIR/usr/bin/gerador-senha-devops"

# 3️⃣ Garantir permissões Debian
chmod 755 "$PACKAGE_DIR/DEBIAN"
chmod 644 "$PACKAGE_DIR/DEBIAN/control"

# 4️⃣ Remover build antigo
if [ -f "$OUTPUT_DEB" ]; then
  echo "🧹 Removendo build antigo..."
  rm -f "$OUTPUT_DEB"
fi

# 5️⃣ Build do pacote
echo "📦 Gerando pacote .deb..."
dpkg-deb --build "$PACKAGE_DIR" "$OUTPUT_DEB"

echo "✅ Pacote gerado com sucesso:"
echo "👉 $OUTPUT_DEB"

echo "🎉 Build finalizado com sucesso."
