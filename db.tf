resource "kubernetes_deployment_v1" "db" {
  metadata {
    name = "db"
  }
  spec {
    replicas = 1
    selector {
      match_labels = {
        App = "db"
        Tier = "backend"
      }
    }
    template {
      metadata {
        labels = {
          App = "db"
          Tier = "backend"
        }
      }
      spec {
        container {
          name  = "db"
          image = "postgres:latest"
          env {
            name = "POSTGRES_DB"
            value = "postgres"
          }
          env {
            name = "POSTGRES_USER"
            value = "postgres"
          }
          env {
            name = "POSTGRES_PASSWORD"
            value = "postgres"
          }
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

resource "kubernetes_service_v1" "db" {
  metadata {
    name = "db"
    labels = {
      App = "db"
      Tier = "backend"
    }
  }
  spec {
    selector = {
      App = "db"
      Tier = "backend"
    }
    port {
      port = 5432
      target_port = 5432
    }
  }
}