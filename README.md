# Bulk-User-Management-Conditional-Access-Automation-in-Microsoft-Entra-ID
This project demonstrates a complete workflow for bulk user onboarding, dynamic group automation, and Conditional Access policy configuration within Microsoft Entra ID. It includes CSV datasets, screenshots, and documentation outlining how to efficiently manage users at scale while enforcing modern Zero Trust security controls.
Watch me build this lab here! https://www.loom.com/share/075e945b42e04de192fb67e2336b96c1
Also here is a presentation of how this is done as well: https://docs.google.com/presentation/d/13plL8oJUnhl0lsL6VIrshJrWo10i65YvEBj5mNTl2s8/edit?usp=sharing.

📂 Repository Contents
File	Description
Corrected_Entra_Import_50.csv	Cleaned and validated CSV file used for bulk user import.
Entra_Bulk_Import_Examsandbox.csv	Original CSV import file used in the Entra ID sandbox environment.
Overview of Bulk User Management and Conditional Access Configuration in Entra ID Portal.pptx	Slide deck explaining the full workflow end-to-end.

📌 Project Overview
This repository provides a hands-on demonstration of:

Bulk user creation using Entra ID’s CSV import process

Dynamic group membership rules based on user attributes

Conditional Access policy configuration (including MFA enforcement)

Policy validation using the What If simulation tool

🚀 1. Bulk User Upload in Entra ID
Bulk upload enables administrators to create dozens or hundreds of users at once.

Preparing the CSV File
The CSV must include required fields such as:

userPrincipalName

displayName

passwordProfile

department

usageLocation

“The CSV file must include required columns like user principal name, display name, and additional attributes for Entra ID.”
(from the PowerPoint)



📥 2. Executing the Bulk Upload
Uploading the CSV File
Navigate to:

Entra ID → Users → Bulk Operations → Bulk Create

Upload the CSV and validate the results.


All users in the sample file were successfully created.

🔍 3. Post‑Upload Verification
After the import completes:

Review logs

Validate user attributes

Confirm department values (critical for dynamic groups)

👥 4. Dynamic Group Membership Rules
Dynamic groups automatically assign users based on attributes such as department.

Example: IT Department Dynamic Group
txt
(user.department -eq "IT")



Example: HR Department Dynamic Group
txt
(user.department -eq "HR")


🛡️ 5. Conditional Access Policy Configuration
Conditional Access policies enforce Zero Trust principles by requiring MFA, compliant devices, or specific conditions before granting access.


This policy enforces MFA for all targeted users.

🎯 6. Targeting Imported Users
You can target:

Dynamic groups (recommended)

Specific users

Directory roles

Guest/external users


📱 7. Configuring Device Platform Conditions
Conditional Access allows filtering by device platform.



🔐 8. MFA Enforcement
MFA drastically reduces credential-based attacks.

“Organizations enforcing MFA experience over 99.9% reduction in credential-based attacks.”
(from the PowerPoint)

🧪 9. Validating Policies with the ‘What If’ Tool
The What If tool simulates sign-in scenarios to test Conditional Access policies before deployment.


This simulation confirms that the MFA policy applies correctly.

📈 Benefits of This Approach
Scalability: Onboard 50+ users instantly

Security: Enforce MFA and Zero Trust controls

Automation: Dynamic groups reduce manual admin work

Accuracy: CSV validation prevents misconfigured accounts

Visibility: What If tool ensures policies behave as expected
