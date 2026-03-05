#!/bin/bash

set -e

APP_NAME="gerador-senha-devops"
BASE_DIR="$HOME/gerador-senha-devops"
SRC_DIR="$BASE_DIR/usr/bin"
PKG_DIR="$BASE_DIR/${APP_NAME}-pkg"

echo "📦 Preparando estrutura Debian para $APP_NAME"

# 1️⃣ Criar estrutura base
echo "📁 Criando estrutura de diretórios..."
mkdir -p "$PKG_DIR/DEBIAN"
mkdir -p "$PKG_DIR/usr/bin"
mkdir -p "$PKG_DIR/usr/share/applications"
mkdir -p "$PKG_DIR/usr/share/icons/hicolor/256x256/apps"

# 2️⃣ Copiar executável
if [ ! -f "$SRC_DIR/$APP_NAME" ]; then
  echo "❌ Executável não encontrado em $SRC_DIR/$APP_NAME"
  exit 1
fi

echo "📄 Copiando executável..."
cp "$SRC_DIR/$APP_NAME" "$PKG_DIR/usr/bin/"

# 3️⃣ Copiar script de build (opcional, mas útil)
if [ -f "$SRC_DIR/build-deb.sh" ]; then
  echo "📄 Copiando script de build..."
  cp "$SRC_DIR/build-deb.sh" "$PKG_DIR/"
else
  echo "⚠️ build-deb.sh não encontrado, pulando essa etapa."
fi

# 4️⃣ Ajustar permissões
chmod +x "$PKG_DIR/usr/bin/$APP_NAME"

# 5️⃣ Criar arquivo control se não existir
CONTROL_FILE="$PKG_DIR/DEBIAN/control"
if [ ! -f "$CONTROL_FILE" ]; then
  echo "📝 Criando arquivo DEBIAN/control..."
  cat <<EOF > "$CONTROL_FILE"
Package: gerador-senha-devops
Version: 1.0.0
Section: utils
Priority: optional
Architecture: all
Depends: python3
Maintainer: Eri <eri@devops.local>
Description: Gerador de Senha DevOps
 Aplicativo gráfico para geração de senhas seguras
 com políticas de segurança corporativas.
 Desenvolvido por Eri.
EOF
else
  echo "ℹ️ Arquivo control já existe, mantendo."
fi

echo "✅ Estrutura criada com sucesso em:"
echo "👉 $PKG_DIR"

echo ""
echo "➡️ Próximo passo:"
echo "cd $PKG_DIR"
echo "./build-deb.sh  (ou dpkg-deb --build .)"
