#!/bin/bash
clientId=$(echo $creds | jq -r '.clientId')
echo $clientId
clientSecret=$(echo $creds | jq -r '.clientSecret')
echo $clientSecret
subscriptionId=$(echo $creds | jq -r '.subscriptionId')
echo $subscriptionId
tenantId=$(echo $creds | jq -r '.tenantId')
echo $tenantId
tokencc=$(curl -X POST -F "grant_type=client_credentials" -F "client_id=$clientId" -F "client_secret=$clientSecret" -F "scope=https://vault.azure.net/.default" "https://login.microsoftonline.com/$tenantId/oauth2/v2.0/token" | jq -r '.access_token') 
value=$(curl -H 'Accept: application/json' -H "Authorization: Bearer $tokencc" https://e2etestenv.vault.azure.net/secrets/TestSecret1?api-version=2016-10-01 |jq -r '.value')
echo value