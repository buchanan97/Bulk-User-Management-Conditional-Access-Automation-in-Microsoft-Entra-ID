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
attachment:ZjTRTZr94W3RS1hb6jNX7.png

✔ The CSV file was uploaded successfully.

🔍 3. Post‑Upload Verification
After the import completes:

Review bulk operation logs

Validate user attributes

Confirm department values (critical for dynamic group rules)

📸 Screenshot: Bulk Operation Results
attachment:TvoeeEE86avfbNCiQivay.png

All users were created successfully.

👥 4. Dynamic Group Membership Rules
Dynamic groups automatically assign users based on attributes such as department.

IT Department Dynamic Group Rule
txt
(user.department -eq "IT")
📸 Screenshot: IT Dynamic Group Rule
attachment:juQ2cBc15fHSHUq2TsJr9.png

HR Department Dynamic Group Rule
txt
(user.department -eq "HR")
📸 Screenshot: HR Dynamic Group Rule
attachment:QBRCwbgz9jQ38JMYnGb4W.png

📸 Screenshot: Creating the HR Dynamic Group
attachment:xY6tptZS9pdLe6oh33Yti.png

📸 Screenshot: IT Department Group Properties
attachment:UnPzkAGRJXZGw3vEMnhtg.png

🛡️ 5. Conditional Access Policy Configuration
Conditional Access enforces Zero Trust principles by requiring MFA, compliant devices, or specific conditions before granting access.

This lab includes a policy that enforces MFA for all targeted users.

📸 Screenshot: Conditional Access Policy (MFA Enforcement)
attachment:hS22HDeWrHY18d64N6mr8.png

🎯 6. Targeting Imported Users
Policies can target:

Dynamic groups (recommended)

Individual users

Directory roles

Guest/external users

📸 Screenshot: Policy Targeting Groups
attachment:LXLmev4GegoVsczuTbU7r.png

📱 7. Configuring Device Platform Conditions
Conditional Access allows filtering by device platform (Windows, macOS, iOS, Android, etc.).

📸 Screenshot: Device Platform Condition
attachment:B1wFChu8n7ztBVnjRm289.png

🔐 8. MFA Enforcement
MFA significantly reduces credential‑based attacks.

“Organizations enforcing MFA experience over 99.9% reduction in credential-based attacks.” — from the PowerPoint

🧪 9. Validating Policies with the ‘What If’ Tool
The What If tool simulates sign‑in scenarios to test Conditional Access policies before deployment.

📸 Screenshot: What If Tool Showing MFA Policy Applied
attachment:7mgQqFuiUcc5Sqy7y77us.png

This confirms that the MFA policy applies correctly to the imported users.
