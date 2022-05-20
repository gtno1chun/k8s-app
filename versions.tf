terraform {
  # required_version = ">= 0.13.1"
  required_version = ">= 0.12.6"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 3.40.0"
    }
    local = {
      source  = "hashicorp/local"
      version = ">= 1.4"
    }
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = ">= 1.11.4"
    }
    random = {
      source  = "hashicorp/random"
      version = ">= 2.1"
    }
    kustomization = {
      source  = "kbst/kustomize"
      # version = "v0.2.0-beta.3"
    }
    
  }
}
