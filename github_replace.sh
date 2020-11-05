#!/bin/sh
gsed -i 's/AWS_ACCESS_KEY_ID.replace/${{ secrets.AWS_ACCESS_KEY_ID }}/g' aws.yml
gsed -i 's/AWS_SECRET_ACCESS_KEY.replace/${{ secrets.AWS_SECRET_ACCESS_KEY }}/g' aws.yml
gsed -i 's/ECR_REGISTRY.replace/${{ steps.login-ecr.outputs.registry }}/g' aws.yml
gsed -i 's/IMAGE_TAG.replace/${{ github.sha }}/g' aws.yml
gsed -i 's/image.replace/${{ steps.build-image.outputs.image }}/g' aws.yml
gsed -i 's/task_definition.replace/${{ steps.task-def.outputs.task-definition }}/g' aws.yml
gsed -i 's/SSH_PRIVATE_KEY.replace/${{ secrets.SSH_PRIVATE_KEY }}/g' aws.yml
mkdir -p .github/workflows
mv aws.yml .github/workflows




