terraform {
  required_providers {
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "~> 2.0"
    }
  }
}

provider "kubernetes" {
  config_path = "~/.kube/config"
}

variable "image_version" {
  description = "Application Version"
  type        = string
}

# lk8s API Deployment
resource "kubernetes_deployment" "lk8s_api" {
  metadata {
    name = "lk8s-api"
  }
  
  spec {
    replicas = 1
    
    selector {
      match_labels = {
        app = "lk8s-api"
      }
    }
    
    template {
      metadata {
        labels = {
          app = "lk8s-api"
        }
      }
      
      spec {
        container {
          image = "lk8s-api:${var.image_version}"
          name  = "lk8s-api"
          image_pull_policy = "Never"    # Use local Minikube images
          port {
            container_port = 5001
          }
        }
      }
    }
  }
}

# lk8s API Service
resource "kubernetes_service" "lk8s_api" {
  metadata {
    name = "lk8s-api-service"
  }
  
  spec {
    selector = {
      app = "lk8s-api"
    }
    
    port {
      port        = 5001
      target_port = 5001
    }
    
    type = "ClusterIP"
  }
}

# lk8s App Deployment
resource "kubernetes_deployment" "lk8s_app" {
  metadata {
    name = "lk8s-app"
  }
  
  spec {
    replicas = 1
    
    selector {
      match_labels = {
        app = "lk8s-app"
      }
    }
    
    template {
      metadata {
        labels = {
          app = "lk8s-app"
        }
      }
      
      spec {
        container {
          image = "lk8s-app:${var.image_version}"
          name  = "lk8s-app"
          image_pull_policy = "Never"    # Use local Minikube images
          port {
            container_port = 5002
          }
        }
      }
    }
  }
}

# lk8s App Service
resource "kubernetes_service" "lk8s_app" {
  metadata {
    name = "lk8s-app-service"
  }
  
  spec {
    selector = {
      app = "lk8s-app"
    }
    
    port {
      port        = 5002
      target_port = 5002
    }
    
    type = "ClusterIP"
  }
}
