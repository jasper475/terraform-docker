terraform {
  required_providers {
    docker = {
      source = "kreuzwerker/docker"
      version = "3.0.1"
    }
  }
}

provider "docker" {
  # Configuration options
  # write terraform code for docker provider with latest nginx in windows 
    host    = "npipe:////.//pipe//docker_engine"
}

resource "docker_image" "nginx" {
  name         = "caddy"
  keep_locally = false
}

resource "docker_container" "nginx" {
  image = docker_image.nginx.name

  name  = "jazzy_container"
  ports {
    internal = 80
    external = 8000
  }
}

output "web_url" {
value =   "http://localhost:${docker_container.nginx.ports[0].external}"
}
