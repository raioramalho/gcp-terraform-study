## ☁️ Cloud SQL – Engines e Versões Suportadas (GCP)

### 🐘 PostgreSQL

| Versão | `database_version` |
|--------|---------------------|
| 15     | `POSTGRES_15`       |
| 14     | `POSTGRES_14`       |
| 13     | `POSTGRES_13`       |
| 12     | `POSTGRES_12`       |
| 11     | `POSTGRES_11`       |

> ✅ Elegível para Free Tier (com `db-f1-micro`, região `us-*`, disco HDD)

---

### 🐬 MySQL

| Versão | `database_version` |
|--------|---------------------|
| 8.0    | `MYSQL_8_0`         |
| 5.7    | `MYSQL_5_7`         |

> ⚠️ `MYSQL_5_6` foi descontinuado.

---

### 🪟 SQL Server

| Versão e Edição              | `database_version`                      |
|-----------------------------|------------------------------------------|
| SQL Server 2022 Standard    | `SQLSERVER_2022_STANDARD`               |
| SQL Server 2022 Enterprise  | `SQLSERVER_2022_ENTERPRISE`             |
| SQL Server 2022 Express     | `SQLSERVER_2022_EXPRESS`                |
| SQL Server 2022 Web         | `SQLSERVER_2022_WEB`                    |
| SQL Server 2019 Standard    | `SQLSERVER_2019_STANDARD`               |
| SQL Server 2019 Enterprise  | `SQLSERVER_2019_ENTERPRISE`             |
| SQL Server 2019 Express     | `SQLSERVER_2019_EXPRESS`                |
| SQL Server 2019 Web         | `SQLSERVER_2019_WEB`                    |

> ❌ **Não entra no Free Tier**. Licenciamento pago via GCP.
