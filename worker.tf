resource "kubernetes_deployment_v1" "worker" {
  metadata {
    name = "worker"
  }
  spec {
    replicas = 1
    selector {
      match_labels = {
        App = "worker"
        Tier = "backend"
      }
    }
    template {
      metadata {
        labels = {
          App = "worker"
          Tier = "backend"
        }
      }
      spec {
        container {
          name  = "worker"
          image = docker_image.worker.name
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