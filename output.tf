output "namespace_name" {
  value = var.create_namespace ? kubernetes_namespace.this.0.metadata.0.name : var.namespace
}

output "generated_private_key" {
  sensitive = true
  value     = var.auto_generate_key_cert ? tls_private_key.this.0.private_key_pem : "CUSTOM_KEY_USED"
}

output "generated_cert" {
  sensitive = true
  value     = var.auto_generate_key_cert ? tls_self_signed_cert.this.0.cert_pem : "CUSTOM_CERT_USED"
}