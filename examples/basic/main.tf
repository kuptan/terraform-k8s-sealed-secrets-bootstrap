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

module "sealed_secrets" {
  source = "../../"

  create_namespace = true
  namespace = "sealed-secrets"

  auto_generate_key_cert = true
}