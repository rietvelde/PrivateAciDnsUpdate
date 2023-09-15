#!/bin/bash
az login --service-principal -u $APP_ID -p $APP_PASSWORD --tenant $APP_TENANT_ID
#ACI_IP=$(az container show --name $ACI_INSTANCE_NAME --resource-group $ACI_RESOURCE_GROUP --subscription $ACI_SUBSCRIPTION --query ipAddress.ip --output tsv)
ACI_IP=ip -4 addr | grep -oP '(?<=inet\s)\d+(\.\d+){3}' | grep -v 127.0.0.1
az network private-dns record-set a update --name $DNS_RECORD_NAME --resource-group $DNS_RESOURCE_GROUP --subscription $DNS_SUBSCRIPTION --zone-name $DNS_ZONE_NAME --set aRecords[0].ipv4Address=$ACI_IP
echo "Done"
