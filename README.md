Microsoft Entra ID: Bulk Management & Conditional Access Automation
Project Overview
This project demonstrates a comprehensive identity-management workflow within Microsoft Entra ID. The goal is to illustrate how organizations can scale identity lifecycle operations—such as onboarding and grouping—while maintaining a rigorous security posture through Zero Trust controls.

🎬 [Watch Me Build This Lab ](https://www.loom.com/share/075e945b42e04de192fb67e2336b96c1)
📊 [Presentation Walkthrough](https://docs.google.com/presentation/d/13plL8oJUnhl0lsL6VIrshJrWo10i65YvEBj5mNTl2s8/edit?usp=sharing)

Objective
Execute bulk user onboarding using CSV import tools.

Automate dynamic group memberships based on specific user attributes.

Configure Conditional Access policies for MFA enforcement and Zero Trust controls.

Validate security policies using the "What If" simulation tool.

Tools Used
Microsoft Entra ID: Primary directory service and identity provider.

Microsoft Entra Conditional Access: Policy engine for Zero Trust enforcement.

What If Tool: Simulation engine for policy validation.

CSV/Excel: For structured bulk data management.

Process Walkthrough
1. Identity Provisioning via Bulk Upload
Bulk upload allows administrators to create dozens or hundreds of users simultaneously. This phase ensures efficiency and consistency across the tenant by utilizing a structured CSV file.

Required CSV Attributes:

userPrincipalName: Unique identifier.

displayName: User's full name.

passwordProfile: Initial login settings.

department: Required for attribute-based grouping.

usageLocation: Needed for license assignments.

2. Executing the Bulk Create
The file is uploaded through Entra ID → Users → Bulk Operations → Bulk Create. After the process completes, operation logs are reviewed to confirm the successful creation of all users and their respective attributes.

![Image Alt](https://github.com/buchanan97/Bulk-User-Management-Conditional-Access-Automation-in-Microsoft-Entra-ID/blob/main/here_is_CSV_of_AD_users.png?raw=true)

Executing the Bulk Upload
Navigate to Entra ID → Users → Bulk Operations → Bulk Create to upload the file.

![Image Alt](https://github.com/buchanan97/Bulk-User-Management-Conditional-Access-Automation-in-Microsoft-Entra-ID/blob/main/Bulk_upload_csv_screenshot.png?raw=true)

✔ The CSV file was uploaded successfully.
![Image Alt](https://github.com/buchanan97/Bulk-User-Management-Conditional-Access-Automation-in-Microsoft-Entra-ID/blob/main/bulk_upload_of_50%20users_success.png?raw=true)

3. Dynamic Group Automation
Dynamic groups eliminate manual administrative overhead by automatically assigning users to groups based on their department attribute.

Rule Logic
In this lab, users are automatically sorted into departments based on the department value provided during the bulk upload:

IT Department Rule
txt (user.department -eq "IT")
![Image Alt](https://github.com/buchanan97/Bulk-User-Management-Conditional-Access-Automation-in-Microsoft-Entra-ID/blob/main/dynamic_query_for_IT_Department.png?raw=true)

HR Department Rule
txt (user.department -eq "HR")

![Image Alt](https://github.com/buchanan97/Bulk-User-Management-Conditional-Access-Automation-in-Microsoft-Entra-ID/blob/main/human_resource_group_query_rules.png?raw=true)

4. Conditional Access Policy Configuration
Conditional Access serves as the Zero Trust policy engine, evaluating signals (like who the user is and what device they are using) before granting access to resources.

Multi-Factor Authentication (MFA) Enforcement
A policy is configured to target the dynamic groups created in the previous step. This ensures that any user identified as "IT" or "HR" is required to provide MFA, regardless of their location. The policy can also be refined to filter by device platforms like Windows, macOS, iOS, and Android.

![Image Alt](https://github.com/buchanan97/Bulk-User-Management-Conditional-Access-Automation-in-Microsoft-Entra-ID/blob/main/Enforcing%20MFA%20FOR%20ALL%20IT%20USERS.png?raw=true)
![Image Alt](https://github.com/buchanan97/Bulk-User-Management-Conditional-Access-Automation-in-Microsoft-Entra-ID/blob/main/mfa_setup_properties.png?raw=true)


4. Policy Validation with ‘What If’
Before moving a security policy into production, the What If tool is used to simulate sign-in events. This tool analyzes the configured policies and provides a report on which ones would apply to a specific user under specific conditions.

Verification Outcome: The simulation confirms that the MFA requirement is correctly triggered for the imported users, validating the end-to-end automation and security logic.

![Image Alt](https://github.com/buchanan97/Bulk-User-Management-Conditional-Access-Automation-in-Microsoft-Entra-ID/blob/main/Enforced%20MFA%20for%20all%20users%20and%20groups.png?raw=true)

Security Considerations
Credential Protection: Enforcing MFA can reduce the risk of credential-based attacks by over 99.9%.

Data Integrity: The success of dynamic grouping depends entirely on the accuracy of the attributes (like department) within the source CSV file.

Zero Trust Principle: This lab applies "Explicit Verification" by ensuring that identity and device signals are checked for every access attempt.


