resource "tls_private_key" "this" {
  count = var.auto_generate_key_cert ? 1 : 0

  algorithm = "RSA"
  rsa_bits  = "4096"
}

resource "tls_self_signed_cert" "this" {
  count = var.auto_generate_key_cert ? 1 : 0

  key_algorithm   = "RSA"
  private_key_pem = tls_private_key.this.0.private_key_pem

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

resource "kubernetes_namespace" "this" {
  count = var.create_namespace ? 1 : 0

  metadata {
    name   = var.namespace
    labels = var.namespace_labels
  }

  lifecycle {
    ignore_changes = [
      metadata[0].labels,
    ]
  }
}

resource "kubernetes_secret" "this" {
  count = var.auto_generate_key_cert || (var.key_cert.private_key != "" && var.key_cert.private_cert != "") ? 1 : 0

  metadata {
    name      = "sealed-secret-encryption-key"
    namespace = var.create_namespace ? kubernetes_namespace.this.0.metadata.0.name : var.namespace
    labels = {
      "sealedsecrets.bitnami.com/sealed-secrets-key" = "active"
    }
  }

  data = {
    "tls.key" = var.auto_generate_key_cert ? tls_private_key.this.0.private_key_pem : var.key_cert.private_key
    "tls.crt" = var.auto_generate_key_cert ? tls_self_signed_cert.this.0.cert_pem : var.key_cert.private_cert
  }

  type = "kubernetes.io/tls"
}

resource "helm_release" "this" {
  name      = "sealed-secrets"
  namespace = var.create_namespace ? kubernetes_namespace.this.0.metadata.0.name : var.namespace

  repository = var.chart_repository
  chart      = "sealed-secrets"
  version    = var.chart_version

  values = var.additional_chart_value_files

  dynamic "set" {
    for_each = var.chart_values_overrides

    content {
      name  = set.key
      value = set.value
    }
  }
}