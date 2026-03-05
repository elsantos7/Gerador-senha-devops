#!/bin/bash

set -e

APP_NAME="Gerador de Senha DevOps"
BIN_PATH="/usr/bin/gerador-senha-devops"
DESKTOP_FILE="/usr/share/applications/gerador-senha-devops.desktop"

echo "🚀 Criando atalho do aplicativo no menu do sistema..."

# 1️⃣ Verificar se o executável existe
if [ ! -f "$BIN_PATH" ]; then
  echo "❌ Executável não encontrado em $BIN_PATH"
  echo "👉 Verifique se o pacote .deb foi instalado corretamente."
  exit 1
fi

# 2️⃣ Criar arquivo .desktop
echo "📄 Criando arquivo .desktop..."
sudo tee "$DESKTOP_FILE" > /dev/null <<EOF
[Desktop Entry]
Name=Gerador de Senha DevOps
Comment=Gerador de senhas seguras para ambientes DevOps
Exec=/usr/bin/gerador-senha-devops
Icon=utilities-terminal
Terminal=false
Type=Application
Categories=Utility;Security;
StartupNotify=true
EOF

# 3️⃣ Ajustar permissões
echo "🔑 Ajustando permissões..."
sudo chmod 644 "$DESKTOP_FILE"

# 4️⃣ Atualizar cache do menu e ícones
echo "🔄 Atualizando cache do sistema..."
sudo update-desktop-database /usr/share/applications >/dev/null 2>&1 || true
sudo gtk-update-icon-cache -f /usr/share/icons/hicolor >/dev/null 2>&1 || true

echo ""
echo "✅ Atalho criado com sucesso!"
echo "🔍 Agora você pode procurar o aplicativo no menu como:"
echo ""
echo "   👉 $APP_NAME"
echo ""
echo "ℹ️ Caso não apareça imediatamente, faça logout/login."
echo "🎉 Processo finalizado."
