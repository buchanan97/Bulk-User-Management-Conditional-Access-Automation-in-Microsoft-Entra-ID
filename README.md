Microsoft Entra ID: Bulk Management & Conditional Access Automation
Project Overview
This project demonstrates an end-to-end identity management and security workflow within Microsoft Entra ID. It focuses on the technical implementation of bulk user lifecycle management, attribute-based dynamic grouping, and the enforcement of Zero Trust security principles through automated Conditional Access policies.

🎬 Watch Me Build This Lab  
https://www.loom.com/share/075e945b42e04de192fb67e2336b96c1

📊 Presentation Walkthrough  
https://docs.google.com/presentation/d/13plL8oJUnhl0lsL6VIrshJrWo10i65YvEBj5mNTl2s8/edit?usp=sharing


1. Identity Provisioning via Bulk Upload
Bulk upload allows administrators to create dozens or hundreds of users at once. This process requires a structured CSV file containing critical identity attributes.

Preparing the CSV File
Your CSV must include required fields such as:

userPrincipalName

displayName

passwordProfile

department

usageLocation

“The CSV file must include required columns like user principal name, display name, and additional attributes for Entra ID.” — from the PowerPoint

![Image Alt](https://github.com/buchanan97/Bulk-User-Management-Conditional-Access-Automation-in-Microsoft-Entra-ID/blob/main/here_is_CSV_of_AD_users.png?raw=true)

Executing the Bulk Upload
Navigate to Entra ID → Users → Bulk Operations → Bulk Create to upload the file.

![Image Alt](https://github.com/buchanan97/Bulk-User-Management-Conditional-Access-Automation-in-Microsoft-Entra-ID/blob/main/Bulk_upload_csv_screenshot.png?raw=true)

✔ The CSV file was uploaded successfully.
![Image Alt](https://github.com/buchanan97/Bulk-User-Management-Conditional-Access-Automation-in-Microsoft-Entra-ID/blob/main/bulk_upload_of_50%20users_success.png?raw=true))

2. Dynamic Group Automation
Dynamic groups automatically assign users based on attributes like department, eliminating manual overhead.

IT Department Rule
txt (user.department -eq "IT")
![Image Alt](https://github.com/buchanan97/Bulk-User-Management-Conditional-Access-Automation-in-Microsoft-Entra-ID/blob/main/dynamic_query_for_IT_Department.png?raw=true)

HR Department Rule
txt (user.department -eq "HR")

![Image Alt](https://github.com/buchanan97/Bulk-User-Management-Conditional-Access-Automation-in-Microsoft-Entra-ID/blob/main/human_resource_group_query_rules.png?raw=true)

3. Conditional Access & MFA Enforcement
Conditional Access enforces Zero Trust principles by requiring MFA or specific conditions before granting access. This lab includes a policy that enforces MFA for all targeted users.

Targeting and Conditions
Policies can target dynamic groups and filter by device platforms such as Windows, macOS, iOS, or Android.

![Image Alt](https://github.com/buchanan97/Bulk-User-Management-Conditional-Access-Automation-in-Microsoft-Entra-ID/blob/main/Enforcing%20MFA%20FOR%20ALL%20IT%20USERS.png?raw=true)
![Image Alt](https://github.com/buchanan97/Bulk-User-Management-Conditional-Access-Automation-in-Microsoft-Entra-ID/blob/main/mfa_setup_properties.png?raw=true)


📸 Screenshot: Device Platform Conditions

4. Verification with the ‘What If’ Tool
The What If tool simulates sign-in scenarios to test Conditional Access policies before deployment. This confirms that the MFA policy applies correctly to the imported users.

![Image Alt](https://github.com/buchanan97/Bulk-User-Management-Conditional-Access-Automation-in-Microsoft-Entra-ID/blob/main/Enforced%20MFA%20for%20all%20users%20and%20groups.png?raw=true)

Security Considerations
MFA Impact: Organizations enforcing MFA experience over a 99.9% reduction in credential-based attacks.

Dynamic Accuracy: Ensure user attributes (like department) are accurately populated in the CSV to ensure correct group placement.



