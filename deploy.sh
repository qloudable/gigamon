#!/bin/bash

# download tempalte from remote url and extract it
curl -o soln.zip $TEMPLATE_URL
v=$(unzip soln.zip | grep -m1 'creating:' | cut -d' ' -f5-)
v="$v."
cp -r $v .

# setup remote state url for terraform
#curl -o tf_remote_config.tf $TERR_REMOTE_STATE_URL
#terraform init -input=false -backend-config="bucket=$TF_VAR_terraform_remote_bucket" -backend-config="key=$TF_VAR_deployment_auuid/terraform.tfstate" -backend-config="region=$TF_VAR_terraform_remote_bucket_region" -backend-config="encrypt=true" -backend-config="access_key=$TF_VAR_aws_access_key" -backend-config="secret_key=$TF_VAR_aws_secret_key" -force-copy

terraform init -input=false -backend-config="tenant_id=$TF_VAR_tenant_id" -backend-config="subscription_id=$TF_VAR_subscription_id" -backend-config="resource_group_name=$TF_VAR_resource_group_name" -backend-config="storage_account_name=$TF_VAR_storage_account_name" -backend-config="container_name=tfstate" -backend-config="key=$TF_VAR_deployment_auuid/terraform.tfstate" -backend-config="use_msi=true" -backend-config="access_key=$TF_VAR_azure_access_key" -force-copy

# run terraform deployment commands (plan & apply)
terraform plan

terraform apply --auto-approve

output_json=${cat terraform output -json}

echo "$output_json"

# Call api to change status of deployment in azure table and send details to users using sendgrid
#curl -d '$output_json' -H 'Content-Type: application/json' $SUCCESS_API
