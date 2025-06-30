
## Criação de Cluster GKE com gcloud

### Explicações dos Parâmetros

- `create-auto`: Usa o modo Autopilot (remova se quiser usar modo Standard).
- `--region`: Define a região do cluster (ex: `--region=us-central1`).
- `--zone`: Define a zona específica (ex: `--zone=us-central1-a`). Use apenas um entre `--region` ou `--zone`.
- `--release-channel=regular`: Usa o canal Regular, que oferece estabilidade com atualizações programadas.
- `--enable-autoscaling`: Ativa o Cluster Autoscaler no node pool.
- `--min-nodes` e `--max-nodes`: Define o intervalo mínimo/máximo de nós.
- `--num-nodes=3`: Define o número inicial de nós.
- `--cluster-version=latest`: Se não especificado, o canal Regular usará a versão 1.27.8+ automaticamente.
- `--project`: Substitua pelo seu ID do projeto no GCP.

### Exemplo de Comando

```sh
gcloud container clusters create hello-world-rg22 \
  --zone=us-central1-c \
  --release-channel=regular \
  --enable-autoscaling \
  --num-nodes=3 \
  --min-nodes=2 \
  --max-nodes=6 \
  --project=qwiklabs-gcp-00-3a985779399a
```

## Gerar token de acesso ao cluster para o kubectl

```sh
gcloud container clusters get-credentials hello-world-rg22 --zone=us-central1-c --project=qwiklabs-gcp-00-3a985779399a
```

## Habilitar o Managed Service for Prometheus no GKE

```sh
gcloud container clusters update nome-do-cluster \
  --zone=us-central1-a \
  --enable-managed-prometheus
```

## Criar Métrica baseada em Logs

```sh
gcloud logging metrics create pod-image-errors \
  --description="Erros de referência inválida de imagem Docker" \
  --log-filter='resource.type="k8s_container" AND jsonPayload.MESSAGE:"InvalidImageName"'

```