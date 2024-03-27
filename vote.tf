resource "kubernetes_deployment_v1" "vote" {
  metadata {
    name = "vote"
  }
  spec {
    replicas = 3
    selector {
      match_labels = {
        App = "vote"
        Tier = "frontend"
        Tier = "backend"
      }
    }
    template {
      metadata {
        labels = {
          App = "vote"
          Tier = "frontend"
          Tier = "backend"
        }
      }
      spec {
        container {
          name  = "vote"
          image = docker_image.vote.name
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

resource "kubernetes_service_v1" "vote" {
  metadata {
    name = "vote"
    labels = {
      App = "vote"
      Tier = "frontend"
      Tier = "backend"
    }
  }
  spec {
    selector = {
      App = "vote"
      Tier = "frontend"
      Tier = "backend"
    }
    port {
      port = 5000
      target_port = 5000
    }
    type = "LoadBalancer"
  }
}