#!/bin/bash

# Solicita o nome de usuário
read -p "Digite o nome de usuário do GitHub: " USERNAME

# Solicita o email
read -p "Digite o email do GitHub: " EMAIL

# Solicita a senha para a chave SSH
read -s -p "Digite uma senha para a chave SSH (ou deixe em branco para sem senha): " PASSPHRASE
echo

# Define o caminho completo do diretório .ssh
SSH_DIR="$HOME/.ssh"

# Define o nome do arquivo da chave SSH
KEY_NAME="$SSH_DIR/id_rsa_github_${USERNAME}"

# Cria o diretório .ssh se não existir
mkdir -p "$SSH_DIR"

# Verifica se a chave SSH já existe
if [ -f "$KEY_NAME" ]; then
    echo "A chave SSH $KEY_NAME já existe."
    exit 1
fi

# Gera a chave SSH
ssh-keygen -t rsa -b 4096 -C "$EMAIL" -f "$KEY_NAME" -N "$PASSPHRASE"

# Inicia o agente SSH
eval "$(ssh-agent -s)"

# Adiciona a chave SSH ao agente
ssh-add "$KEY_NAME"

# Exibe a chave pública
echo "A chave pública gerada é:"
cat "$KEY_NAME.pub"

echo "Copie a chave acima e adicione-a ao seu GitHub, acessando https://github.com/settings/keys"
