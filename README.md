# Final Project: Django on Azure with Terraform and GitHub Actions

This repository contains a simple two‑tier web application built with Django and PostgreSQL.  The app is containerised with Docker and deployed to Azure using Infrastructure as Code (IaC) via Terraform and a pair of GitHub Actions workflows.

## Project structure

```
final_project_repo/
├── app/                     # Django application and Docker image
│   ├── manage.py
│   ├── myproject/           # Django project settings and URLs
│   ├── main/                # Example Django app with a single view
│   ├── templates/           # HTML templates
│   ├── Dockerfile           # Container definition for the Django app
│   └── requirements.txt     # Python dependencies for the app
├── terraform/               # Terraform configuration for Azure resources
│   ├── main.tf
│   ├── variables.tf
│   └── outputs.tf
├── .github/workflows/       # GitHub Actions CI/CD workflows
│   ├── iac.yml              # Applies Terraform to provision infrastructure
│   └── deploy.yml           # Builds and deploys the Docker image to Azure Container Instance
├── .gitignore
└── README.md
```

## Prerequisites

- An Azure account with permission to create resource groups, container registries and container instances.
- A GitHub repository with [Actions secrets](https://docs.github.com/en/actions/security-guides/encrypted-secrets) configured for Azure credentials and registry credentials:
  - `AZURE_CREDENTIALS` – JSON output from an Azure service principal (used by `azure/login@v1`).
  - `ACR_NAME` – Name of your Azure Container Registry.
  - `AZURE_RG` – Resource group name used by Terraform and ACI.
  - `ACR_USERNAME` and `ACR_PASSWORD` – Credentials for pushing images to the registry (if not using the service principal).
  - Database and Django secrets: `DJANGO_SECRET_KEY`, `DATABASE_NAME`, `DATABASE_USER`, `DATABASE_PASSWORD`, `DATABASE_HOST`.

## Local development

To run the application locally without Azure:

```bash
# From the `app` directory
python3 -m venv env
source env/bin/activate
pip install -r requirements.txt

# Set environment variables for the database and secret key
export DJANGO_SECRET_KEY="changeme"
export DATABASE_NAME="postgres"
export DATABASE_USER="postgres"
export DATABASE_PASSWORD="postgres"
export DATABASE_HOST="localhost"

# Apply migrations and start the development server
python manage.py migrate
python manage.py runserver 0.0.0.0:8000
```

Then visit `http://localhost:8000/` to see the “Hello, world” page.

## Container build

To build and run the Docker image manually:

```bash
cd app
docker build -t django-app:latest .
docker run -it --rm -p 8000:8000 \
  -e DJANGO_SECRET_KEY=changeme \
  -e DATABASE_NAME=postgres \
  -e DATABASE_USER=postgres \
  -e DATABASE_PASSWORD=postgres \
  -e DATABASE_HOST=db.host.example \
  django-app:latest
```

## Terraform deployment

Terraform files are stored under the `terraform/` directory.  They define the Azure Container Registry (ACR), Azure Container Instance (ACI) and supporting resources.  Variables are declared in `variables.tf` and outputs in `outputs.tf`.  Before applying, customise the variables or provide values via environment variables or a `terraform.tfvars` file.  Run the following commands:

```bash
cd terraform
terraform init
terraform plan -out=tfplan
terraform apply -auto-approve tfplan
```

After applying, note the outputs printed by Terraform; these include the fully qualified domain name of the running container.

## GitHub Actions workflows

Two workflows under `.github/workflows` automate your CI/CD:

1. **`iac.yml`** – triggered on pushes to the `terraform/` directory.  It installs Terraform, performs an `init`, `plan` and `apply` using the credentials provided in repository secrets.
2. **`deploy.yml`** – triggered on pushes to the `app/` directory.  It logs in to Azure, builds and pushes the Docker image to ACR, then deploys a new container instance using `az container create`.  Database and Django secrets are passed to the container via environment variables.

These workflows are intentionally simple and meant to be extended.  See the comments in the YAML files for guidance.

## Cleaning up

After you no longer need the deployment, run `terraform destroy` from the `terraform/` directory or trigger the cleanup stage of your CI/CD pipeline to delete all cloud resources.

## License

This project is provided for educational purposes and carries no warranty.  Feel free to adapt it for your own learning.