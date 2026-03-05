#!/bin/bash

set -e

REPO="elsantos7/Gerador-senha-devops"
PACKAGE="gerador-senha-devops-pkg.deb"

echo "🔽 Baixando última versão..."

URL=$(curl -s https://api.github.com/repos/$REPO/releases/latest \
  | grep browser_download_url \
  | grep .deb \
  | cut -d '"' -f 4)

wget -O $PACKAGE $URL

echo "📦 Instalando pacote..."

#sudo dpkg -i $PACKAGE
sudo apt update
sudo apt install -y ./gerador-senha-devops-pkg.deb

echo "✅ Instalação concluída!"

