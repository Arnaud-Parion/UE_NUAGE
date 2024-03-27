resource "docker_image" "redis" {
  name = "docker.io/redis:latest" 
}

resource "docker_image" "db" {
  name = "docker.io/postgres"
}

resource "docker_image" "seed" {
  name  = "seed"
  build {
    context = "./seed-data/"
  }
}

resource "docker_image" "nginx" {
  name  = "nginx"
  build {
    context = "./nginx/"
  }
}

resource "docker_image" "vote" {
  name  = "vote"
  build {
    context = "./vote/"
  }
}

resource "docker_image" "worker" {
  name  = "worker"
  build {
    context = "./worker/"
  }
}

resource "docker_image" "result" {
  name  = "result"
  build {
    context = "./result/"
  }
}