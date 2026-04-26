// Variables for Azure resources

variable "resource_group_name" {
  description = "Name of the Azure resource group"
  type        = string
  default     = "final-project-rg"
}

variable "location" {
  description = "Azure region for resources"
  type        = string
  default     = "centralus"
}

variable "acr_name" {
  description = "Name of the Azure Container Registry"
  type        = string
  default     = "finalprojectacr${random_string.suffix.result}"
}

variable "container_group_name" {
  description = "Name of the Azure Container Instance group"
  type        = string
  default     = "finalproject-aci"
}

variable "dns_name_label" {
  description = "Unique DNS name label for the container instance"
  type        = string
  default     = "finalproject-${random_string.suffix.result}"
}

variable "image_name" {
  description = "Name of the Docker image (repository)"
  type        = string
  default     = "django-app"
}

variable "image_tag" {
  description = "Tag for the Docker image"
  type        = string
  default     = "latest"
}

variable "django_secret_key" {
  description = "Secret key for the Django application"
  type        = string
  default     = "CHANGEME"
  sensitive   = true
}

variable "database_name" {
  description = "Name of the PostgreSQL database"
  type        = string
  default     = "postgres"
}

variable "database_user" {
  description = "User name for the PostgreSQL database"
  type        = string
  default     = "postgres"
}

variable "database_password" {
  description = "Password for the PostgreSQL database user"
  type        = string
  default     = "postgres"
  sensitive   = true
}

variable "database_host" {
  description = "Hostname for the PostgreSQL database"
  type        = string
  default     = "postgres.example.com"
}

// Random suffix to avoid name collisions
resource "random_string" "suffix" {
  length  = 4
  upper   = false
  special = false
}