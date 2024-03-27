terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "~> 3.0.2"
    }
  }
}

resource "docker_image" "redis" {
  name = "docker.io/redis:latest"
}

resource "docker_container" "redis" {
  name  = "redis_container"
  image = docker_image.redis.name
  ports {
    internal = "6379"
    external = "6379"
  }
}

resource "docker_image" "db" {
  name = "docker.io/postgres"
}

resource "docker_container" "db" {
  name  = "db_container"
  image = docker_image.db.name
  env = [
    "POSTGRES_USER=postgres",
    "POSTGRES_PASSWORD=postgres",
    "POSTGRES_DB=postgres"
  ]
  ports {
    internal = "5432"
    external = "5432"
  }
}

resource "docker_image" "seed" {
  name  = "seed"
  build {
    context = "./seed-data/"
  }
}
resource "docker_container" "seed-container" {
  name = "seed_container"
  image = docker_image.seed.name
  host {
    host = "nginx"
    ip = docker_container.nginx.network_data[0].ip_address
  }
}

resource "docker_image" "nginx" {
  name  = "nginx"
  build {
    context = "./nginx/"
  }
}
resource "docker_container" "nginx" {
  name = "nginx_container"
  image = docker_image.nginx.name
  ports {
    internal = "8000"
    external = "8000"
  }
  host {
    host = "vote1"
    ip = docker_container.vote1.network_data[0].ip_address
  }
  host {
    host = "vote2"
    ip = docker_container.vote2.network_data[0].ip_address
  }
}

resource "docker_image" "vote" {
  name  = "vote"
  build {
    context = "./vote/"
  }
}
resource "docker_container" "vote1" {
  name  = "vote1_container"
  image = docker_image.vote.name
  ports {
    internal = "5000"
    external = "5000"
  }
  host {
    host = "redis"
    ip = docker_container.redis.network_data[0].ip_address
  }
}

resource "docker_container" "vote2" {
  name  = "vote2_container"
  image = docker_image.vote.name
  ports {
    internal = "5000"
    external = "5001"
  }
  host {
    host = "redis"
    ip = docker_container.redis.network_data[0].ip_address
  }
}

resource "docker_image" "worker" {
  name  = "worker"
  build {
    context = "./worker/"
  }
}
resource "docker_container" "worker" {
  name = "worker_container"
  image = docker_image.worker.name
  host {
    host = "redis"
    ip = docker_container.redis.network_data[0].ip_address
  }
  host {
    host = "db"
    ip = docker_container.db.network_data[0].ip_address
  }
}

resource "docker_image" "result" {
  name  = "result"
  build {
    context = "./result/"
  }
}
resource "docker_container" "result" {
  name = "result_container"
  image = docker_image.result.name
  ports {
    internal = "4000"
    external = "4000"
  }
  host {
    host = "db"
    ip = docker_container.db.network_data[0].ip_address
  }
}

output "result_endpoint" {
  value = "http://localhost:${docker_container.result.ports[0].external}"
  description = "The URL endpoint to access the results"
}

output "vote_endpoint" {
  value = "http://localhost:5000"
  description = "The URL endpoint to access the votes"
}