# Project Board / Kanban

This file documents the project board used for the final project. The repository also contains GitHub Issues written as user stories with acceptance criteria.

## Done

| Issue | User Story | Evidence |
|---|---|---|
| #1 | Set up repository and project tracking | Public GitHub repository created; issues document user stories and acceptance criteria. |
| #2 | Containerize the Django application | `app/Dockerfile` builds and starts the Django app with Gunicorn on port 8000. |
| #3 | Provision Azure infrastructure with IaC | Terraform files are included in `terraform/` for Azure resources. |
| #4 | Automate Docker build and push with GitHub Actions | `deploy.yml` builds and pushes the image to Azure Container Registry. |
| #5 | Deploy the application to Azure Container Instance | `deploy.yml` deploys the container image to Azure Container Instance. |
| #6 | Verify deployment with a custom HTTP 200 action | `.github/actions/http-200-check/action.yml` checks the deployed URL and requires HTTP 200. |
| #7 | Document the final deployment and workflow | `README.md` explains the live app, workflow, custom action, IaC, and cleanup. |
| #8 | Prepare final video presentation and submission | Repository link, live URL, and workflow evidence are ready for submission. |

## In Progress

No remaining implementation tasks.

## To Do

No remaining implementation tasks.

## Notes

The latest successful workflow demonstrates the end-to-end deployment process:

1. Scan Python dependencies.
2. Authenticate to Azure.
3. Build the Docker image.
4. Push the image to Azure Container Registry.
5. Deploy to Azure Container Instance.
6. Get the deployed app URL.
7. Run the custom HTTP 200 check.

Current repository submission link:

```text
https://github.com/williamWWz/final-project
```

Current live application URL from the latest successful run:

```text
http://william-django-app-13.centralus.azurecontainer.io:8000
```
