Bulk User Management & Conditional Access Automation in Microsoft Entra ID
🎬 Watch Me Build This Lab  
https://www.loom.com/share/075e945b42e04de192fb67e2336b96c1

📊 Presentation Walkthrough  
https://docs.google.com/presentation/d/13plL8oJUnhl0lsL6VIrshJrWo10i65YvEBj5mNTl2s8/edit?usp=sharing

📌 Project Overview
This project demonstrates a complete identity‑management workflow in Microsoft Entra ID, including:

Bulk user onboarding using CSV import

Dynamic group automation based on user attributes

Conditional Access policy configuration (MFA enforcement, platform conditions, Zero Trust controls)

Policy validation using the What If simulation tool

The goal is to show how organizations can scale identity lifecycle operations while maintaining strong security posture.

🚀 1. Bulk User Upload in Entra ID
Bulk upload allows administrators to create dozens or hundreds of users at once.

Preparing the CSV File
Your CSV must include required fields such as:

userPrincipalName

displayName

passwordProfile

department

usageLocation

“The CSV file must include required columns like user principal name, display name, and additional attributes for Entra ID.” — from the PowerPoint

📸 Screenshot:!![Image Alt](https://github.com/buchanan97/Bulk-User-Management-Conditional-Access-Automation-in-Microsoft-Entra-ID/blob/main/here_is_CSV_of_AD_users.png?raw=true)

📥 2. Executing the Bulk Upload
Navigate to:

Entra ID → Users → Bulk Operations → Bulk Create

Upload the CSV and validate the results.

📸 Screenshot: Uploading the CSV File
![Image Alt](https://github.com/buchanan97/Bulk-User-Management-Conditional-Access-Automation-in-Microsoft-Entra-ID/blob/main/Bulk_upload_csv_screenshot.png?raw=true)

✔ The CSV file was uploaded successfully.

🔍 3. Post‑Upload Verification
After the import completes:

Review bulk operation logs

Validate user attributes

Confirm department values (critical for dynamic group rules)

📸 Screenshot: Bulk Operation Results
![Image Alt](https://github.com/buchanan97/Bulk-User-Management-Conditional-Access-Automation-in-Microsoft-Entra-ID/blob/main/bulk_upload_of_50%20users_success.png?raw=true))

All users were created successfully.

👥 4. Dynamic Group Membership Rules
Dynamic groups automatically assign users based on attributes such as department.

IT Department Dynamic Group Rule
txt
(user.department -eq "IT")
📸 Screenshot: IT Dynamic Group Rule
![Image Alt](https://github.com/buchanan97/Bulk-User-Management-Conditional-Access-Automation-in-Microsoft-Entra-ID/blob/main/dynamic_query_for_IT_Department.png?raw=true)

HR Department Dynamic Group Rule
txt
(user.department -eq "HR")
📸 Screenshot: HR Dynamic Group Rule
![Image Alt](https://github.com/buchanan97/Bulk-User-Management-Conditional-Access-Automation-in-Microsoft-Entra-ID/blob/main/human_resource_group_query_rules.png?raw=true)

📸 Screenshot: Creating the HR Dynamic Group
![Image Alt](https://github.com/buchanan97/Bulk-User-Management-Conditional-Access-Automation-in-Microsoft-Entra-ID/blob/main/human_resource_group_setup.png?raw=true)

📸 Screenshot: IT Department Group Properties
![Image Alt](https://github.com/buchanan97/Bulk-User-Management-Conditional-Access-Automation-in-Microsoft-Entra-ID/blob/main/IT_Group_Setup.png?raw=true)
🛡️ 5. Conditional Access Policy Configuration
Conditional Access enforces Zero Trust principles by requiring MFA, compliant devices, or specific conditions before granting access.

This lab includes a policy that enforces MFA for all targeted users.

🎯 6. Targeting Imported Users
Policies can target:

Dynamic groups (recommended)

Individual users

Directory roles

Guest/external users

📸 Screenshot: Policy Targeting Groups
![Image Alt](https://github.com/buchanan97/Bulk-User-Management-Conditional-Access-Automation-in-Microsoft-Entra-ID/blob/main/Enforcing%20MFA%20FOR%20ALL%20IT%20USERS.png?raw=true)

📱 7. Configuring Device Platform Conditions
Conditional Access allows filtering by device platform (Windows, macOS, iOS, Android, etc.).

📸 Screenshot: Device Platform Condition
![Image Alt](https://github.com/buchanan97/Bulk-User-Management-Conditional-Access-Automation-in-Microsoft-Entra-ID/blob/main/mfa_setup_properties.png?raw=true)

🔐 8. MFA Enforcement
MFA significantly reduces credential‑based attacks.

“Organizations enforcing MFA experience over 99.9% reduction in credential-based attacks.” — from the PowerPoint

🧪 9. Validating Policies with the ‘What If’ Tool
The What If tool simulates sign‑in scenarios to test Conditional Access policies before deployment.

📸 Screenshot: What If Tool Showing MFA Policy Applied
![Image Alt](https://github.com/buchanan97/Bulk-User-Management-Conditional-Access-Automation-in-Microsoft-Entra-ID/blob/main/Enforced%20MFA%20for%20all%20users%20and%20groups.png?raw=true)

This confirms that the MFA policy applies correctly to the imported users.
📈 Benefits of This Approach
Benefit	Description
Scalability	Onboard 50+ users instantly
Security	Enforce MFA & Zero Trust controls
Automation	Dynamic groups eliminate manual assignments
Accuracy	CSV validation prevents misconfigured accounts
Visibility	What If tool ensures policies behave as expected


