#!/bin/bash
# ci_cd.sh - Pipeline simples de CI/CD

# Diretório do projeto no servidor
PROJECT_DIR="/home/modup/Área de trabalho/teste novo vscode"
# Diretório de produção (onde seu site roda)
DEPLOY_DIR="/var/www/html"

# 1️⃣ Ir para o diretório do projeto
cd "$PROJECT_DIR" || exit 1

# 2️⃣ Puxar as últimas alterações do Git
git reset --hard
git pull origin master

# 3️⃣ Rodar testes (exemplo PHP)
for file in $(find . -name "*.php"); do
    php -l "$file" || { echo "Erro de sintaxe em $file"; exit 1; }
done
echo "Testes OK ✅"

# 4️⃣ Deploy (sincronizar arquivos para produção)
rsync -av --exclude='.git' "$PROJECT_DIR/" "$DEPLOY_DIR/"

echo "Deploy concluído 🚀"
