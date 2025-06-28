variable "cloudflare_email" {
  description = "Email da conta Cloudflare"
  type        = string
}

variable "cloudflare_api_key" {
  description = "API key da conta Cloudflare"
  type        = string
}

variable "cloudflare_zone_name" {
  description = "Nome do domínio (zona DNS)"
  type        = string
}

variable "cloudflare_record_name" {
  description = "Subdomínio para apontar (ex: app)"
  type        = string
}
variable "kubeconfig_path" {
  description = "Caminho para o arquivo kubeconfig"
  type        = string
  default     = "~/.kube/config" # Pode ser alterado conforme necessário
}