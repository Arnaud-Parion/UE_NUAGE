output "result_endpoint" {
  value = "http://localhost:${docker_container.result.ports[0].external}"
  description = "The URL endpoint to access the results"
}

output "vote_endpoint" {
  value = "http://localhost:${docker_container.vote1.ports[0].internal}"
  description = "The URL endpoint to access the votes"
}