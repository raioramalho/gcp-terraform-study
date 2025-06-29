# Como configurar o Secret GCP_SA_KEY para GitHub Actions

Para permitir que o GitHub Actions se autentique no GCP (para deploys, push de imagens, etc), siga os passos abaixo para gerar e configurar uma **Service Account com chave JSON**:

## Passo 1: Criar uma Service Account

```bash
gcloud iam service-accounts create github-ci \
  --description="Conta para GitHub Actions CI/CD" \
  --display-name="GitHub CI"
```

## Passo 2: Conceder permissões necessárias

```bash
gcloud projects add-iam-policy-binding estudos-464221 \
  --member="serviceAccount:github-ci@estudos-464221.iam.gserviceaccount.com" \
  --role="roles/artifactregistry.writer"

gcloud projects add-iam-policy-binding estudos-464221 \
  --member="serviceAccount:github-ci@estudos-464221.iam.gserviceaccount.com" \
  --role="roles/run.admin"

gcloud projects add-iam-policy-binding estudos-464221 \
  --member="serviceAccount:github-ci@estudos-464221.iam.gserviceaccount.com" \
  --role="roles/iam.serviceAccountUser"
```

## Passo 3: Gerar a chave JSON

```bash
gcloud iam service-accounts keys create gcp-sa-key.json \
  --iam-account=github-ci@estudos-464221.iam.gserviceaccount.com
```

## Passo 4: Adicionar ao GitHub como Secret

1. Acesse seu repositório no GitHub
2. Vá em **Settings > Secrets and variables > Actions**
3. Clique em **New secret**
4. Nome: `GCP_SA_KEY`
5. Conteúdo: cole o conteúdo completo do arquivo `gcp-sa-key.json`

**Atenção:** Nunca comite esse arquivo JSON no repositório. Se precisar revogar a chave:

```bash
gcloud iam service-accounts keys list \
  --iam-account=github-ci@estudos-464221.iam.gserviceaccount.com

gcloud iam service-accounts keys delete <KEY_ID> \
  --iam-account=github-ci@estudos-464221.iam.gserviceaccount.com
```
