<#
    Provision-Examsandbox.ps1
    Automated Entra ID provisioning for:
    - Bulk user import
    - Dynamic group creation
    - Conditional Access MFA policy
    - CA policy evaluation
#>

# -------------------------------
# Tenant Configuration
# -------------------------------
$tenantId = "11d4f510-c7f2-43ad-b9f3-c08f6dda6e12"
$domain   = "Examsandbox.onmicrosoft.com" #you need to use your own credentials in my case I used tenant domain
$csvPath  = "C:\Users\scorp\OneDrive\Documents\programming_scripts_for_cybersecurity\IAM EntraID personal lab project\Entra_Bulk_Import_Examsandbox.csv" 

# -------------------------------
# Connect to Microsoft Graph
# -------------------------------
Install-Module Microsoft.Graph -Scope CurrentUser -ErrorAction SilentlyContinue

Connect-MgGraph -TenantId $tenantId -Scopes `
"User.ReadWrite.All",
"Group.ReadWrite.All",
"Policy.ReadWrite.ConditionalAccess",
"Directory.ReadWrite.All"

Write-Host "`nConnected to Microsoft Graph for tenant $tenantId" -ForegroundColor Cyan

# -------------------------------
# Bulk User Import
# -------------------------------
Write-Host "`nImporting users from CSV..." -ForegroundColor Yellow

$users = Import-Csv -Path $csvPath

foreach ($u in $users) {

    $upn = $u.'User name [userPrincipalName] Required'

    # Validate domain
    if (-not $upn.ToLower().EndsWith($domain.ToLower())) {
        Write-Warning "Skipping $upn — UPN does not match tenant domain $domain."
        continue
    }

    $passwordProfile = @{
        Password = $u.'Initial password [passwordProfile] Required'
        ForceChangePasswordNextSignIn = $true
    }

    try {
        New-MgUser `
            -DisplayName $u.'Name [displayName] Required' `
            -UserPrincipalName $upn `
            -AccountEnabled ($u.'Block sign in (Yes/No) [accountEnabled] Required' -eq "No") `
            -GivenName $u.'First name [givenName]' `
            -Surname $u.'Last name [surname]' `
            -JobTitle $u.'Job title [jobTitle]' `
            -Department $u.'Department [department]' `
            -UsageLocation $u.'Usage location [usageLocation]' `
            -StreetAddress $u.'Street address [streetAddress]' `
            -State $u.'State or province [state]' `
            -Country $u.'Country or region [country]' `
            -City $u.'City [city]' `
            -PostalCode $u.'ZIP or postal code [postalCode]' `
            -OfficeLocation $u.'Office [physicalDeliveryOfficeName]' `
            -MobilePhone $u.'Mobile phone [mobile]' `
            -PasswordProfile $passwordProfile

        Write-Host "Created user: $upn" -ForegroundColor Green
    }
    catch {
        Write-Warning "Failed to create user $upn. Error: $_"
    }
}

# -------------------------------
# Dynamic Groups
# -------------------------------
Write-Host "`nCreating dynamic groups..." -ForegroundColor Yellow

# IT Group
try {
    $ITGroup = New-MgGroup `
        -DisplayName "IT Department-Automation" `
        -MailEnabled $false `
        -MailNickname "ITDeptAuto" `
        -SecurityEnabled $true `
        -GroupTypes @("DynamicMembership") `
        -MembershipRule '(user.department -eq "IT")' `
        -MembershipRuleProcessingState "On"

    Write-Host "Created IT dynamic group: $($ITGroup.Id)" -ForegroundColor Green
}
catch {
    Write-Warning "IT group creation failed: $_"
}

# HR Group
try {
    $HRGroup = New-MgGroup `
        -DisplayName "HR" `
        -MailEnabled $true `
        -MailNickname "HR" `
        -SecurityEnabled $false `
        -GroupTypes @("DynamicMembership","Unified") `
        -MembershipRule '(user.department -eq "HR")' `
        -MembershipRuleProcessingState "On"

    Write-Host "Created HR dynamic group: $($HRGroup.Id)" -ForegroundColor Green
}
catch {
    Write-Warning "HR group creation failed: $_"
}

# -------------------------------
# Conditional Access Policy (MFA)
# -------------------------------
Write-Host "`nCreating Conditional Access MFA policy..." -ForegroundColor Yellow

try {
    $ITGroupId = (Get-MgGroup -Filter "displayName eq 'IT Department-Automation'").Id

    $policy = @{
        displayName = "Enforce MFA for IT Department"
        state = "enabled"
        conditions = @{
            users = @{
                includeGroups = @($ITGroupId)
            }
            clientAppTypes = @("browser","mobileAppsAndDesktopClients")
        }
        grantControls = @{
            operator = "AND"
            builtInControls = @("mfa")
        }
    }

    $createdPolicy = New-MgIdentityConditionalAccessPolicy -BodyParameter $policy

    Write-Host "Created Conditional Access policy: $($createdPolicy.Id)" -ForegroundColor Green
}
catch {
    Write-Warning "Conditional Access policy creation failed: $_"
}

# -------------------------------
# Conditional Access Evaluation (What-If)
# -------------------------------
Write-Host "`nEvaluating Conditional Access policy for test user..." -ForegroundColor Yellow

try {
    $testUser = Get-MgUser -UserId "alice.vance@Examsandbox.onmicrosoft.com"

    $body = @{
        principalId = $testUser.Id
        resourceId = "00000003-0000-0000-c000-000000000000" # Microsoft Graph
        ipAddress = "40.77.182.32"
    }

    $evaluation = Invoke-MgEvaluateIdentityConditionalAccessPolicy -BodyParameter $body

    Write-Host "`nConditional Access Evaluation Result:" -ForegroundColor Cyan
    $evaluation | Format-List
}
catch {
    Write-Warning "CA evaluation failed: $_"
}

Write-Host "`nProvisioning complete." -ForegroundColor Cyan
