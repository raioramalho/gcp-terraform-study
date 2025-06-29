### 1. Descubra o projectNumber

```sh
gcloud projects describe estudos-464221 --format="value(projectNumber)"
```

Você deve obter algo como:

```
1034263767453
```

### 2. Conceda permissão para a conta de serviço padrão

```sh
gcloud projects add-iam-policy-binding estudos-464221 \
    --member="serviceAccount:1034263767453-compute@developer.gserviceaccount.com" \
    --role="roles/artifactregistry.reader"
```