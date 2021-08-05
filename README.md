# Terraform K8S Sealed Secrets Bootstrap
[![License](https://img.shields.io/badge/License-Apache%202.0-blue.svg)](https://opensource.org/licenses/Apache-2.0) [![GitHub Release](https://img.shields.io/github/release/kube-champ/terraform-k8s-sealed-secrets-bootstrap.svg?style=flat)]() [![PR's Welcome](https://img.shields.io/badge/PRs-welcome-brightgreen.svg?style=flat)](http://makeapullrequest.com)

A terraform module that will bootstrap a Kubernetes cluster with Sealed Secret controller

## Usage

```terraform
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
  source = "kube-champ/sealed-secrets-bootstrap/k8s"

  create_namespace = true
  namespace        = "sealed-secrets"

  auto_generate_key_cert = true
}
```

For more examples, please check the examples folder

## Module Info
See the module info here [here](./TERRAFORM.md) or view it on the [Terraform Registry](https://registry.terraform.io/modules/kube-champ/sealed-secrets-bootstrap/k8s/latest)

## Contributing
See contributing docs [here](./docs/CONTRIBUTING.md)
