#!/bin/bash
set -e

ROOT_DIR=$(pwd)
echo "[+] Iniciando destruição recursiva de pastas Terraform em: $ROOT_DIR"

# Loop por cada pasta que contém arquivos .tf
find "$ROOT_DIR" -type f -name "*.tf" -exec dirname {} \; | sort -u | while read -r dir; do
  echo "[*] Entrando na pasta: $dir"
  cd "$dir"

  if [ -f ".terraform.lock.hcl" ] || [ -d ".terraform" ]; then
    echo "    [~] Rodando: terraform destroy -auto-approve"
    terraform destroy -auto-approve || echo "    [!] Falha ao destruir em $dir"
  else
    echo "    [!] Pasta $dir ainda não foi inicializada, pulando..."
  fi

  cd "$ROOT_DIR"
done

echo "[✔] Processo concluído."
