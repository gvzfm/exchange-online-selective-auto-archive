param (
    [Parameter(Mandatory = $true)]
    [string[]]$Users
)

# =====================================================
# Configuration
# =====================================================
$DefaultPolicyName = "Default MRM Policy"

# =====================================================
# Rollback Users to Default Policy
# =====================================================
foreach ($User in $Users) {

    Set-Mailbox $User -RetentionPolicy $DefaultPolicyName
    Start-ManagedFolderAssistant -Identity $User
}

Write-Host "Rollback completed. Users reverted to Default MRM Policy."
