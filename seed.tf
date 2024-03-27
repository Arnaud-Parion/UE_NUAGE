resource "kubernetes_job_v1" "seed" {
  metadata {
    name = "seed"
  }
  spec {
    template {
      metadata {
        labels = {
          App = "seed"
          Tier = "frontend"
        }
      }
      spec {
        container {
          name  = "seed"
          image = docker_image.seed.name
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
        restart_policy = "Never"
      }
    }
  }
}