# 🧩 GCP Terraform Study

Repositório de estudos e experimentação com **Terraform + Google Cloud Platform (GCP)**, organizado por módulos temáticos (VM, serverless, containers, Kubernetes). Ideal para aprendizado, portfólio e seleção técnica.

---

## 📚 Módulos Disponíveis

### 1. VM + NGINX + Firewall
- Provisiona uma **Compute Engine (e2-micro)** com NGINX instalado via metadata startup script.
- Rede custom: VPC, sub-rede, regras de firewall (SSH, HTTP, HTTPS).
- Código em `gcp_vm_nginx/`.

### 2. NGINX no Cloud Run
- Deploy de container `nginx:alpine` do Docker Hub no Cloud Run.
- Configuração completa com Terraform.
- Código em `gcp_container_nginx/`.

### 3. k3s com 1 nó (e2-micro) - EM BREVE
- Cluster Kubernetes leve para laboratório ou testes.
- Control plane gerenciado + node e2‑micro.
- Código em `gcp_vm_k3s/`.

---

## 🛠️ Estrutura de Pastas

```
gcp-terraform-study/
├── gcp_vm_nginx/
├── gcp_container_nginx/
├── gcp_vm_k3s/ (em-breve)
└── README.md  ← este arquivo
```

Cada módulo contém seus próprios arquivos `main.tf`, `variables.tf`, `outputs.tf` e documentação específica.

---

## 🚀 Instruções Gerais

Para iniciar qualquer módulo, entre na pasta correspondente e rode:

```bash
terraform init
terraform plan -var="project_id=<seu-projeto>" -var="region=<região>"
terraform apply -var="project_id=<seu-projeto>" -var="region=<região>"
```

Não se esqueça de:
- Ter **billing ativado** e permissões adequadas no projeto GCP.
- Ativar APIs nos módulos conforme instruído (`container.googleapis.com`, `run.googleapis.com`, etc).

---

## 📌 Recomendações

- Execute instruções em ambiente isolado.
- Use `.gitignore` para descartar `terraform.tfstate`.
- Remova recursos com `terraform destroy` ao final.
- Leia os READMEs individuais para detalhes específicos de cada aplicação.

---

## 🚀 Próximos passos sugeridos

- Modularizar recursos reutilizáveis.
- CI/CD com GitHub Actions ou Cloud Build.
- Monitoramento, logging, custom domains.
- Auto-scaling em Cloud Run / GKE / funções serverless.

---

## 📘 Licença

MIT © [Alan Ramalho](https://github.com/raioramalho)