#!/bin/sh

set -e

# This entrypoint script wraps common Terraform commands.  It expects
# environment variables to be set by the calling GitHub Action.

cd "$GITHUB_WORKSPACE/terraform" || exit 1

terraform init
terraform plan -input=false -out=tfplan
if [ "$APPLY" = "true" ]; then
  terraform apply -input=false tfplan
fi