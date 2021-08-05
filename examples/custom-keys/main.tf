provider "helm" {
  kubernetes {
    config_path    = "~/.kube/config"
    config_context = "minikube"
  }
}

provider "kubernetes" {
  config_path    = "~/.kube/config"
  config_context = "minikube"
}

resource "tls_private_key" "this" {
  algorithm = "RSA"
  rsa_bits  = "4096"
}

resource "tls_self_signed_cert" "this" {
  key_algorithm   = "RSA"
  private_key_pem = tls_private_key.this.private_key_pem

  subject {
    common_name  = "sealed-secrets"
    organization = "sealed-secrets"
  }

  validity_period_hours = 12

  allowed_uses = [
    "key_encipherment",
    "data_encipherment",
    "digital_signature",
    "server_auth",
  ]
}

module "sealed_secrets" {
  source = "../../"
  # source = "kube-champ/sealed-secrets-bootstrap/k8s"

  create_namespace = true
  namespace        = "sealed-secrets"

  auto_generate_key_cert = false

  key_cert = {
    private_key  = tls_private_key.this.private_key_pem
    private_cert = tls_self_signed_cert.this.cert_pem
  }
}