resource "kubernetes_deployment_v1" "result" {
  metadata {
    name = "result"
  }
  spec {
    replicas = 1
    selector {
      match_labels = {
        App = "result"
        Tier = "frontend"
        Tier = "backend"
      }
    }
    template {
      metadata {
        labels = {
          App = "result"
          Tier = "frontend"
          Tier = "backend"
        }
      }
      spec {
        container {
          name  = "result"
          image = docker_image.result.name
          resources {
            requests = {
              cpu = "100m"
              memory = "100Mi"
            }
          }
          port {
            container_port = 80
          }
        }
      }
    }
  }
}

resource "kubernetes_service_v1" "result" {
  metadata {
    name = "result"
    labels = {
      App = "result"
      Tier = "frontend"
      Tier = "backend"
    }
  }
  spec {
    selector = {
      App = "result"
      Tier = "frontend"
      Tier = "backend"
    }
    port {
      port = 4000
      target_port = 4000
    }
    type = "LoadBalancer"
  }
}