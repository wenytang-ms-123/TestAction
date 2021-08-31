#!/bin/bash
clientId = echo $creds | jq '.clientId'
cleintSecret = echo $creds | jq './clientSecret'
subscriptionId = echo $creds | jq './subscriptionId'
tenantId = echo $creds | jq './tenantId'
curl -d "grant_type=client_credentials&client_id=$(clientId)&client_secret=$(cleintSecret)&scope=https://vault.azure.net/.default" -H "Content-Type: application/x-www-form-urlencoded" -X POST https://login.microsoftonline.com/$(tenantId)/oauth2/v2.0/token
