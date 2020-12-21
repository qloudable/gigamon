#!/bin/bash
#Destroy resources
terraform destroy --auto-approve

# Call api to change status of deployment in azure table and send details to users using sendgrid
#curl -d '{}' -H 'Content-Type: application/json' $SUCCESS_API/status/destroyed

#Exit the container
exit
