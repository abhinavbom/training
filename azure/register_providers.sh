#!/bin/bash

# List of commonly used Azure provider namespaces
providers=("Microsoft.KeyVault" "Microsoft.Compute" "Microsoft.Network" "Microsoft.Storage")

# Loop through the provider namespaces
for provider in "${providers[@]}"
do
  echo "Registering provider namespace: $provider"
  az provider register --namespace "$provider"
done

echo "Provider registration complete"
