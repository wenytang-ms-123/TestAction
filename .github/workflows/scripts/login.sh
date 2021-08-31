#!/bin/bash
clientI =$(echo $1 | jq '.clientId')
cleintSecret=$(echo $1 | jq './clientSecret')
subscriptionId=$(echo $1 | jq './subscriptionId')
tenantId=$(echo $1 | jq './tenantId')
tokencc=$(curl -X POST -F "grant_type=client_credentials" -F "client_id=$clientId" -F "client_secret=$clientSecret" -F "scope=https://vault.azure.net/.default" "https://login.microsoftonline.com/$tenantId/oauth2/v2.0/token" | jq -r '.access_token') 
value=$(curl -H 'Accept: application/json' -H "Authorization: Bearer $tokencc" https://e2etestenv.vault.azure.net/secrets/TestSecret1?api-version=2016-10-01 |jq -r '.value')
echo value