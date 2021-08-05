output "namespace_name" {
  value = module.sealed_secrets.namespace_name
}

output "generated_private_key" {
  sensitive = true
  value     = module.sealed_secrets.generated_private_key
}

output "generated_cert" {
  sensitive = true
  value     = module.sealed_secrets.generated_cert
}