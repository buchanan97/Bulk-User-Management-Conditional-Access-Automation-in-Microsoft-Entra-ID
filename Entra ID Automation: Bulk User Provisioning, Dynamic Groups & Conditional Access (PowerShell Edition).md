🚀 Entra ID Automation: Bulk User Provisioning, Dynamic Groups & Conditional Access (PowerShell Edition)
This branch contains a fully automated PowerShell workflow for provisioning users, creating dynamic groups, and enforcing Conditional Access policies in Microsoft Entra ID, without using the admin portal UI.

All scripts are written for the tenant:

Tenant ID: 11d4f510-c7f2-43ad-b9f3-c08f6dda6e12

Primary Domain: Examsandbox.onmicrosoft.com

The automation uses the Microsoft Graph PowerShell SDK, the modern and supported method for identity lifecycle scripting.

📂 Repository Structure
Code
/powershell-automation
│
├── Import-Users.ps1
├── Create-DynamicGroups.ps1
├── Create-CAPolicies.ps1
├── Evaluate-CA-Policy.ps1
└── README.md   ← (this file)
📌 1. Prerequisites
Before running any scripts:

Install Microsoft Graph PowerShell SDK
powershell
Install-Module Microsoft.Graph -Scope CurrentUser
Connect to Graph (Tenant‑Scoped)
powershell
Connect-MgGraph -TenantId "11d4f510-c7f2-43ad-b9f3-c08f6dda6e12" -Scopes `
"User.ReadWrite.All",
"Group.ReadWrite.All",
"Policy.ReadWrite.ConditionalAccess",
"Directory.ReadWrite.All"
📥 2. Bulk User Import (PowerShell)
This script provisions users directly from your CSV file:

Code
C:\Users\scorp\OneDrive\Documents\programming_scripts_for_cybersecurity\IAM EntraID personal lab project\Entra_Bulk_Import_Examsandbox.csv
Import-Users.ps1
powershell
$tenantId = "11d4f510-c7f2-43ad-b9f3-c08f6dda6e12"
$domain   = "Examsandbox.onmicrosoft.com"

Connect-MgGraph -TenantId $tenantId -Scopes `
"User.ReadWrite.All",
"Directory.ReadWrite.All"

$csvPath = "C:\Users\scorp\OneDrive\Documents\programming_scripts_for_cybersecurity\IAM EntraID personal lab project\Entra_Bulk_Import_Examsandbox.csv"
$users   = Import-Csv -Path $csvPath

foreach ($u in $users) {

    $upn = $u.'User name [userPrincipalName] Required'

    if (-not $upn.ToLower().EndsWith($domain.ToLower())) {
        Write-Warning "Skipping $upn — UPN does not match tenant domain."
        continue
    }

    $passwordProfile = @{
        Password = $u.'Initial password [passwordProfile] Required'
        ForceChangePasswordNextSignIn = $true
    }

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
}
✔ Fully replaces the Entra ID bulk upload UI
✔ Validates domain suffix
✔ Applies all user attributes from the CSV

👥 3. Dynamic Group Creation (IT & HR)
Create-DynamicGroups.ps1
powershell
Connect-MgGraph -TenantId "11d4f510-c7f2-43ad-b9f3-c08f6dda6e12" -Scopes "Group.ReadWrite.All"

# IT Department
New-MgGroup `
    -DisplayName "IT Department-Automation" `
    -MailEnabled $false `
    -MailNickname "ITDeptAuto" `
    -SecurityEnabled $true `
    -GroupTypes @("DynamicMembership") `
    -MembershipRule '(user.department -eq "IT")' `
    -MembershipRuleProcessingState "On"

# HR Department
New-MgGroup `
    -DisplayName "HR" `
    -MailEnabled $true `
    -MailNickname "HR" `
    -SecurityEnabled $false `
    -GroupTypes @("DynamicMembership","Unified") `
    -MembershipRule '(user.department -eq "HR")' `
    -MembershipRuleProcessingState "On"
✔ Matches your dynamic group rules
✔ Automatically assigns users based on CSV department values

🛡️ 4. Conditional Access Policy (Require MFA)
Create-CAPolicies.ps1
powershell
Connect-MgGraph -TenantId "11d4f510-c7f2-43ad-b9f3-c08f6dda6e12" -Scopes "Policy.ReadWrite.ConditionalAccess"

$ITGroup = Get-MgGroup -Filter "displayName eq 'IT Department-Automation'"

$policy = @{
    displayName = "Enforce MFA for IT Department"
    state = "enabled"
    conditions = @{
        users = @{
            includeGroups = @($ITGroup.Id)
        }
        clientAppTypes = @("browser","mobileAppsAndDesktopClients")
    }
    grantControls = @{
        operator = "AND"
        builtInControls = @("mfa")
    }
}

New-MgIdentityConditionalAccessPolicy -BodyParameter $policy
✔ Enforces MFA
✔ Targets the IT dynamic group
✔ Mirrors your UI configuration

🧪 5. Conditional Access Simulation (Graph What‑If)
Evaluate-CA-Policy.ps1
powershell
Connect-MgGraph -TenantId "11d4f510-c7f2-43ad-b9f3-c08f6dda6e12" -Scopes "Policy.Read.All"

$testUser = Get-MgUser -UserId "alice.vance@Examsandbox.onmicrosoft.com"

$body = @{
    principalId = $testUser.Id
    resourceId = "00000003-0000-0000-c000-000000000000"
    ipAddress = "40.77.182.32"
}

Invoke-MgEvaluateIdentityConditionalAccessPolicy -BodyParameter $body
✔ Equivalent to the Entra ID “What If” tool
✔ Confirms MFA enforcement

📈 Automation Workflow Summary
Step	Script	Purpose
1	Import-Users.ps1	Bulk user provisioning
2	Create-DynamicGroups.ps1	Attribute‑based group automation
3	Create-CAPolicies.ps1	MFA enforcement via Conditional Access
4	Evaluate-CA-Policy.ps1	Validate policy behavior
