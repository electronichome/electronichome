#!/usr/bin/env bash

declare -a EMAILS=(${SG_NOTIFY_EMAILS//\,/ })

for EMAIL in "${EMAILS[@]}"
do
  echo "Sending email to ${EMAIL}"
  curl --request POST \
    --url https://api.sendgrid.com/v3/mail/send \
    --header "Authorization: Bearer $SG_API_KEY" \
    --header 'Content-Type: application/json' \
    --data "{\"personalizations\": [{\"to\": [{\"email\": \"${EMAIL}\"}]}],\"from\": {\"email\": \"${SG_NOTIFY_FROM}\"},\"subject\": \"[CI] Pipeline failed!\",\"content\": [{\"type\": \"text/plain\", \"value\": \"The pipeline for project ${CI_PROJECT_NAME} on commit ${CI_BUILD_REF} has failed!\nSee failure here: ${CI_PROJECT_URL}/pipelines/${CI_PIPELINE_ID}\"}]}"
done
