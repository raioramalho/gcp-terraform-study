# GCP Terraform Study

Repositório de estudos e experimentação com **Terraform + Google Cloud Platform (GCP)**, organizado por módulos temáticos. Este repositório simula um ambiente real de Platform Engineering, com automações, infraestrutura modular e boas práticas de provisionamento.

Ideal para:
- **Aprendizado prático**
- **Portfólio técnico**
- **Preparação para entrevistas técnicas**
- **Testes em ambientes reais (GCP Free Tier + CI/CD)**
---

## Módulos Disponíveis

### 1. GCP VM com NGINX + Firewall
- Provisiona **Compute Engine (e2-micro)** com NGINX via startup script.
- VPC customizada, sub-rede, firewall para portas 22/80/443.
- Local: `gcp_vm_nginx/`

### 2. Cloud Run com Docker
- App containerizado FastAPI rodando no Cloud Run.
- Build via Dockerfile + push para Artifact Registry.
- Pipeline com `cloudbuild.yaml` e `GitHub Actions`.
- Local: `cloudrun_python_dockerfile/`

### 3. PostgreSQL no Cloud SQL (Free Tier)
- Instância `db-f1-micro`, disco HDD, com `POSTGRES_15`.
- Usuário, banco e configuração mínima via Terraform.
- Local: `gcp_cloud_sql/`

### 4. GKE + NGINX + Cloudflare
- Cluster GKE com `nginx` exposto via LoadBalancer.
- Integração automática com Cloudflare DNS (Terraform).
- Ideal para ambientes Kubernetes com domínio dinâmico.
- Local: `gke_nginx_cloudflare/`

### 5. k3s VM autogerenciada
- Cluster k3s em Compute Engine com `containerd`.
- Provisionamento 100% automatizado com startup script.
- Local: `gcp_vm_k3s/`

---

## ⚙️ Estrutura

├── atualizar-role-gke-artifact-registry.md
├── cloudrun_python_dockerfile
│   ├── Dockerfile
│   ├── cloudbuild.yaml
│   ├── main.py
│   └── requirements.txt
├── gcp_actions
│   └── build_push_gcr.yaml
├── gcp_cloud_sql
│   ├── database_version_list.md
│   ├── main.tf
│   ├── output.tf
│   ├── provider.tf
│   ├── terraform.tfstate
│   ├── terraform.tfstate.backup
│   ├── terraform.tfvars
│   └── variables.tf
├── gcp_cloud_storage
├── gcp_container_nginx
│   ├── gcp_container_nginx.drawio
│   ├── gcp_container_nginx.png
│   ├── main.tf
│   ├── output.tf
│   ├── provider.tf
│   ├── readme.md
│   ├── terraform.tfstate
│   ├── terraform.tfstate.backup
│   ├── terraform.tfvars
│   └── variables.tf
├── gcp_vm_k3s
│   ├── gcp_vm_k3s.drawio
│   ├── gcp_vm_k3s.png
│   ├── k3s-server.sh
│   ├── main.tf
│   ├── output.tf
│   ├── provider.tf
│   ├── readme.md
│   ├── terraform.tfstate
│   ├── terraform.tfstate.backup
│   ├── terraform.tfvars
│   └── variables.tf
├── gcp_vm_nginx
│   ├── files
│   ├── gcp_vm_ngninx.drawio
│   ├── gcp_vm_ngninx.png
│   ├── main.tf
│   ├── output.tf
│   ├── provider.tf
│   ├── readme.md
│   ├── terraform.tfstate
│   ├── terraform.tfstate.backup
│   ├── terraform.tfvars
│   └── variables.tf
├── gke_nginx_cloudflare
│   ├── main.tf
│   ├── output.tf
│   ├── provider.tf
│   ├── terraform.tfstate
│   ├── terraform.tfstate.backup
│   ├── terraform.tfvars
│   └── variables.tf
└── readme.md


---

## 🚀 Como Usar

Para qualquer módulo:

```bash
cd <modulo>
terraform init
terraform apply -var="project_id=<seu-projeto>" -var="region=<região>"
```