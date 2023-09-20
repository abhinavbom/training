# List of commonly used Azure provider namespaces
$providers = @("Microsoft.KeyVault", "Microsoft.Compute", "Microsoft.Network", "Microsoft.Storage")

# Loop through the provider namespaces
foreach ($provider in $providers) {
    Write-Host "Registering provider namespace: $provider"
    Register-AzResourceProvider -ProviderNamespace $provider
}

Write-Host "Provider registration complete"
