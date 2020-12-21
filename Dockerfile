FROM alpine:latest

ENV TERRAFORM_VERSION=0.11.8
ENV TERRAFORM_SHA256SUM=84ccfb8e13b5fce63051294f787885b76a1fedef6bdbecf51c5e586c9e20c9b7

#RUN apk add --update \
#    python \
#    python-dev \
#    py-pip \
#    build-base \
#  && pip install virtualenv \
#  && rm -rf /var/cache/apk/*
  
RUN apk add --update git curl bash openssl openssh && \
    curl https://releases.hashicorp.com/terraform/${TERRAFORM_VERSION}/terraform_${TERRAFORM_VERSION}_linux_amd64.zip > terraform_${TERRAFORM_VERSION}_linux_amd64.zip && \
    echo "${TERRAFORM_SHA256SUM}  terraform_${TERRAFORM_VERSION}_linux_amd64.zip" > terraform_${TERRAFORM_VERSION}_SHA256SUMS && \
    sha256sum -cs terraform_${TERRAFORM_VERSION}_SHA256SUMS && \
    unzip terraform_${TERRAFORM_VERSION}_linux_amd64.zip -d /bin && \
    rm -f terraform_${TERRAFORM_VERSION}_linux_amd64.zip
    

COPY deploy.sh /home/deploy.sh
COPY destroy.sh /home/destroy.sh
COPY backend.tf /home/backend.tf

# Gigamon Cloud Credential: TF_VAR_access_key, TF_VAR_secret_key, TF_VAR_region, TF_VAR_account_id
# Gigamon Solution Terraform Template: TEMPLATE_URL 
# System Variables: TF_VAR_deployment_auuid, $SUCCESS_API
# State File Credentials: TF_VAR_tenant_id, TF_VAR_subscription_id, TF_VAR_resource_group_name, TF_VAR_storage_account_name, TF_VAR_azure_access_key

WORKDIR /home

#ENTRYPOINT ["/bin/bash", "sleep 7200", "deploy.sh" ]
CMD ["sh", "-c", "./deploy.sh | sleep 2h"]
