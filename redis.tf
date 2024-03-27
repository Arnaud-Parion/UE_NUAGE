resource "kubernetes_deployment_v1" "redis" {
  metadata {
    name = "redis"
  }
  spec {
    replicas = 1
    selector {
      match_labels = {
        App = "redis"
        Tier = "backend"
      }
    }
    template {
      metadata {
        labels = {
          App = "redis"
          Tier = "backend"
        }
      }
      spec {
        container {
          name  = "redis"
          image = "redis:latest"
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

resource "kubernetes_service_v1" "redis" {
  metadata {
    name = "redis"
    labels = {
      App = "redis"
      Tier = "backend"
    }
  }
  spec {
    selector = {
      App = "redis"
      Tier = "backend"
    }
    port {
      port = 6379
      target_port = 6379
    }
  }
}