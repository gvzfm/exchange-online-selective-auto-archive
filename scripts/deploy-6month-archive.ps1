param (
    [Parameter(Mandatory = $true)]
    [string[]]$Users
)

# =====================================================
# Configuration
# =====================================================
$BasePolicyName   = "Default MRM Policy"
$PolicyName       = "Default MRM Policy - 6AyAutoArchive"
$ArchiveTagName   = "Default-6Ay-MoveToArchive"
$ArchiveAgeInDays = 180

# =====================================================
# Ensure Retention Policy Tag Exists
# =====================================================
if (-not (Get-RetentionPolicyTag -Identity $ArchiveTagName -ErrorAction SilentlyContinue)) {

    New-RetentionPolicyTag `
        -Name $ArchiveTagName `
        -Type All `
        -AgeLimitForRetention $ArchiveAgeInDays `
        -RetentionAction MoveToArchive
}

# =====================================================
# Clone Default MRM Policy (If Not Exists)
# =====================================================
if (-not (Get-RetentionPolicy -Identity $PolicyName -ErrorAction SilentlyContinue)) {

    $BaseTags = (Get-RetentionPolicy $BasePolicyName).RetentionPolicyTagLinks

    New-RetentionPolicy `
        -Name $PolicyName `
        -RetentionPolicyTagLinks $BaseTags
}

# =====================================================
# Ensure Single MoveToArchive Tag (Conflict Safe)
# =====================================================
$CurrentTags = (Get-RetentionPolicy $PolicyName).RetentionPolicyTagLinks

$CleanTags = $CurrentTags | Where-Object {
    $_ -notmatch "MoveToArchive"
}

if ($CleanTags -notcontains $ArchiveTagName) {
    $CleanTags += $ArchiveTagName
}

Set-RetentionPolicy `
    -Identity $PolicyName `
    -RetentionPolicyTagLinks $CleanTags

# =====================================================
# Assign Policy to Selected Users
# =====================================================
foreach ($User in $Users) {

    Set-Mailbox $User -RetentionPolicy $PolicyName
    Start-ManagedFolderAssistant -Identity $User
}

Write-Host "6-Month Auto Archive policy deployed successfully."
