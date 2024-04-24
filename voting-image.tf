# Worker
variable "worker-source" {
  type = string
  default = "./worker/"
  description = "Source directory of worker"
}

resource "docker_image" "worker" {
  name = "europe-west9-docker.pkg.dev/ue-nuage/voting-images/worker"
  build {
    context = var.worker-source
  }
}

resource "docker_registry_image" "worker" {
  name          = docker_image.worker.name
  keep_remotely = true
}

output "worker-image-name" {
  value = docker_image.worker.name
  description = "Image name of worker container"
}

# Vote
variable "vote-source" {
  type = string
  default = "./vote/"
  description = "Source directory of vote"
}

resource "docker_image" "vote" {
  name = "europe-west9-docker.pkg.dev/ue-nuage/voting-images/vote"
  build {
    context = var.vote-source
  }
}

resource "docker_registry_image" "vote" {
  name          = docker_image.vote.name
  keep_remotely = true
}

output "vote-image-name" {
  value = docker_image.vote.name
  description = "Image name of vote container"
}

# Seed-data
variable "seed-source" {
  type = string
  default = "./seed-data/"
  description = "Source directory of seed-data"
}

resource "docker_image" "seed" {
  name = "europe-west9-docker.pkg.dev/ue-nuage/voting-images/seed"
  build {
    context = var.seed-source
  }
}

resource "docker_registry_image" "seed" {
  name          = docker_image.seed.name
  keep_remotely = true
}

output "seed-image-name" {
  value = docker_image.seed.name
  description = "Image name of seed container"
}

# Result
variable "result-source" {
  type = string
  default = "./result/"
  description = "Source directory of result"
}

resource "docker_image" "result" {
  name = "europe-west9-docker.pkg.dev/ue-nuage/voting-images/result"
  build {
    context = var.result-source
  }
}

resource "docker_registry_image" "result" {
  name          = docker_image.result.name
  keep_remotely = true
}

output "result-image-name" {
  value = docker_image.result.name
  description = "Image name of result container"
}