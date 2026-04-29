# Final Project: Django on Azure with GitHub Actions

This repository contains a simple Python Django application that displays a "Hello, world" page. The application is containerized with Docker, pushed to Azure Container Registry, deployed to Azure Container Instance, and verified through GitHub Actions.

## Live Deployment

Current deployed application URL:

```text
http://william-django-app-13.centralus.azurecontainer.io:8000
```

The GitHub Actions deployment workflow includes a custom HTTP 200 check that confirms the deployed URL is reachable.

## Project Structure

```text
final-project/
├── app/                         # Django application
│   ├── manage.py
│   ├── myproject/               # Django settings and URLs
│   ├── main/                    # Main Django app and view
│   ├── Dockerfile               # Docker container definition
│   └── requirements.txt         # Python dependencies
├── terraform/                   # Terraform IaC configuration
│   ├── main.tf
│   ├── variables.tf
│   └── outputs.tf
├── .github/
│   ├── actions/
│   │   └── http-200-check/      # Custom GitHub Action
│   │       └── action.yml
│   └── workflows/
│       ├── deploy.yml           # Build, push, deploy, and verify app
│       └── iac.yml              # Terraform workflow
└── README.md
```

## Application

The Django app has a simple index page that returns:

```text
Hello, world! This is your Django app deployed on Azure.
```

The app runs with Gunicorn on port `8000` inside the container.

## Containerization

The application is containerized using Docker:

- Uses the official `python:3.11-slim` base image.
- Installs Python dependencies from `requirements.txt`.
- Copies the Django application into the container.
- Exposes port `8000`.
- Starts the app with Gunicorn.

Build command used by the workflow:

```bash
docker build -t williamfinalacr.azurecr.io/django-app:<commit-sha> ./app
```

## Azure Resources

The project uses these Azure resources:

- Resource group: `rg-final-project`
- Azure Container Registry: `williamfinalacr`
- Azure Container Instance: `django-app`
- PostgreSQL flexible server: `williamfinalpg`

The running application is exposed through the Azure Container Instance FQDN.

## GitHub Actions Deployment Workflow

The deployment workflow is located at:

```text
.github/workflows/deploy.yml
```

It automatically runs on pushes to the application, workflow, or custom action files. The workflow performs these steps:

1. Checks out the repository.
2. Logs into Azure using repository secrets.
3. Builds the Docker image.
4. Pushes the image to Azure Container Registry.
5. Deploys the image to Azure Container Instance.
6. Gets the application URL.
7. Runs the custom HTTP 200 check.

The workflow uses repository secrets for Azure authentication:

```text
AZURE_CLIENT_ID
AZURE_CLIENT_SECRET
AZURE_TENANT_ID
AZURE_SUBSCRIPTION_ID
DJANGO_SECRET_KEY
DATABASE_NAME
DATABASE_USER
DATABASE_PASSWORD
DATABASE_HOST
```

## Custom GitHub Action

The custom action is located at:

```text
.github/actions/http-200-check/action.yml
```

Purpose:

- Accepts a URL as input.
- Uses `curl` to check the deployed application.
- Retries while the container starts.
- Passes only if the app returns HTTP `200`.
- Fails the workflow if the deployment is not reachable.

This provides automated proof that the Azure deployment is accessible.

## Infrastructure as Code

Terraform files are stored in:

```text
terraform/
```

The Terraform configuration documents Azure infrastructure for:

- Resource group
- Azure Container Registry
- Azure Container Instance
- Public DNS name label
- Container image registry credentials
- Useful deployment outputs

The Terraform workflow is located at:

```text
.github/workflows/iac.yml
```

## Project Tracking / User Stories

Project tasks are documented as GitHub Issues using user story format with acceptance criteria. The issues cover:

- Repository setup and project tracking
- Docker containerization
- Terraform/IaC configuration
- Docker build and push automation
- Azure Container Instance deployment
- Custom HTTP 200 verification action
- README and documentation
- Final video presentation and submission

## Local Development

To run locally:

```bash
cd app
python3 -m venv env
source env/bin/activate
pip install -r requirements.txt
python manage.py runserver 0.0.0.0:8000
```

Then open:

```text
http://localhost:8000
```

## Cleanup

Azure Container Instance can create charges while running. After grading or testing is complete, clean up resources in Azure Portal or run Azure CLI commands such as:

```bash
az container delete --resource-group rg-final-project --name django-app --yes
```

If Terraform is used to manage the full environment, cleanup can also be done through:

```bash
cd terraform
terraform destroy
```

## Final Submission

Repository link:

```text
https://github.com/williamWWz/final-project
```

Live app URL:

```text
http://william-django-app-13.centralus.azurecontainer.io:8000
```

The final presentation should show the repository, project issues/user stories, Dockerfile, Terraform files, GitHub Actions workflow, custom action, successful HTTP 200 check, and live deployed application.
