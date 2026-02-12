# Microsoft Entra ID: Bulk Management & Conditional Access Automation

> A comprehensive guide to scaling identity lifecycle operations with Zero Trust security controls in Microsoft Entra ID.

---

## 📋 Table of Contents
- [Quick Start](#quick-start)
- [Project Overview](#project-overview)
- [Objectives](#objectives)
- [Tools & Technologies](#tools--technologies)
- [Workflow](#workflow)
- [Security Considerations](#security-considerations)

---

## Quick Start

🎬 **[Watch Me Build This Lab](https://www.loom.com/share/075e945b42e04de192fb67e2336b96c1)** - Full walkthrough video

📊 **[Presentation Slides](https://docs.google.com/presentation/d/13plL8oJUnhl0lsL6VIrshJrWo10i65YvEBj5mNTl2s8/edit?usp=sharing)** - Detailed presentation

---

## Project Overview

This project demonstrates a **complete identity-management workflow** within Microsoft Entra ID. It illustrates how organizations can:

- **Scale identity lifecycle operations** (onboarding, provisioning, group management)
- **Automate security controls** through dynamic grouping and policies
- **Enforce Zero Trust principles** with Conditional Access

The lab uses **CSV datasets, screenshots, and documentation** to guide administrators through implementing modern security practices at scale.

---

## Objectives

This lab covers four key objectives:

1. ✅ Execute bulk user onboarding using CSV import tools
2. ✅ Automate dynamic group memberships based on user attributes
3. ✅ Configure Conditional Access policies for MFA enforcement and Zero Trust controls
4. ✅ Validate security policies using the "What If" simulation tool

---

## Tools & Technologies

| Tool | Purpose |
|------|---------|
| **Microsoft Entra ID** | Primary directory service and identity provider |
| **Microsoft Entra Conditional Access** | Policy engine for Zero Trust enforcement |
| **What If Tool** | Simulation engine for policy validation |
| **CSV/Excel** | Structured bulk data management |

---

## Workflow

### Phase 1: Identity Provisioning via Bulk Upload

Bulk upload enables administrators to create dozens or hundreds of users simultaneously while maintaining efficiency and consistency across the tenant.

#### Required CSV Attributes

| Attribute | Purpose |
|-----------|---------|
| `userPrincipalName` | Unique identifier (e.g., user@domain.com) |
| `displayName` | User's full name |
| `passwordProfile` | Initial login settings |
| `department` | Required for attribute-based grouping |
| `usageLocation` | Needed for license assignments |

#### Step 1: Prepare Your CSV File

Ensure your CSV contains all required attributes. Here's an example structure:

![CSV File Example](https://github.com/buchanan97/Bulk-User-Management-Conditional-Access-Automation-in-Microsoft-Entra-ID/blob/main/here_is_CSV_of_AD_users.png?raw=true)

#### Step 2: Execute Bulk Upload

1. Navigate to **Entra ID → Users → Bulk Operations → Bulk Create**
2. Upload your prepared CSV file
3. Review the operation summary

![Bulk Upload Interface](https://github.com/buchanan97/Bulk-User-Management-Conditional-Access-Automation-in-Microsoft-Entra-ID/blob/main/Bulk_upload_csv_screenshot.png?raw=true)

#### Step 3: Verify Upload Success

Check the operation logs to confirm successful creation of all users and their attributes.

![Success Confirmation](https://github.com/buchanan97/Bulk-User-Management-Conditional-Access-Automation-in-Microsoft-Entra-ID/blob/main/bulk_upload_of_50%20users_success.png?raw=true)

✅ **Result**: 50 users successfully created with all attributes provisioned.

---

### Phase 2: Dynamic Group Automation

Dynamic groups eliminate manual administrative overhead by automatically assigning users to groups based on their attributes.

#### How It Works

Users are automatically sorted into department-based groups using attribute-matching rules. The system continuously evaluates user attributes and updates group memberships accordingly.

#### Example: IT Department Group

**Rule Logic:**
```
(user.department -eq "IT")
```

**What this does**: Automatically includes all users with "IT" in their department field.

![IT Department Rule](https://github.com/buchanan97/Bulk-User-Management-Conditional-Access-Automation-in-Microsoft-Entra-ID/blob/main/dynamic_query_for_IT_Department.png?raw=true)

#### Example: HR Department Group

**Rule Logic:**
```
(user.department -eq "HR")
```

**What this does**: Automatically includes all users with "HR" in their department field.

![HR Department Rule](https://github.com/buchanan97/Bulk-User-Management-Conditional-Access-Automation-in-Microsoft-Entra-ID/blob/main/human_resource_group_query_rules.png?raw=true)

---

### Phase 3: Conditional Access Policy Configuration

Conditional Access is the policy engine that evaluates signals (user identity, device state, location, etc.) before granting access to resources.

#### Multi-Factor Authentication (MFA) Enforcement Policy

A Conditional Access policy is configured to target the dynamic groups created in the previous phase. This ensures:

- ✅ Users in the "IT" group must authenticate with MFA
- ✅ Users in the "HR" group must authenticate with MFA
- ✅ Policy applies regardless of location
- ✅ Can be refined by device platform (Windows, macOS, iOS, Android)

![MFA Policy for IT Users](https://github.com/buchanan97/Bulk-User-Management-Conditional-Access-Automation-in-Microsoft-Entra-ID/blob/main/Enforcing%20MFA%20FOR%20ALL%20IT%20USERS.png?raw=true)

![MFA Policy Configuration Details](https://github.com/buchanan97/Bulk-User-Management-Conditional-Access-Automation-in-Microsoft-Entra-ID/blob/main/mfa_setup_properties.png?raw=true)

---

### Phase 4: Policy Validation with "What If" Tool

Before deploying security policies to production, use the **What If** tool to simulate sign-in scenarios and validate policy behavior.

#### How to Use What If

1. Navigate to **Conditional Access → What If Tool**
2. Select a test user and conditions (device, location, etc.)
3. Review which policies would apply
4. Verify policies behave as expected

#### Validation Outcome

The simulation confirms that:
- ✅ MFA requirement is correctly triggered for imported users
- ✅ End-to-end automation logic works as designed
- ✅ Security controls apply consistently across users

![What If Validation Results](https://github.com/buchanan97/Bulk-User-Management-Conditional-Access-Automation-in-Microsoft-Entra-ID/blob/main/Enforced%20MFA%20for%20all%20users%20and%20groups.png?raw=true)

---

## Security Considerations

### Credential Protection
- Enforcing MFA reduces the risk of credential-based attacks by **over 99.9%**
- Protects against phishing, password reuse, and brute-force attacks

### Data Integrity
- Dynamic group accuracy depends entirely on **source data quality**
- Ensure CSV attributes (especially `department`) are accurate and consistent
- Implement validation procedures before bulk uploads

### Zero Trust Principles Applied
This lab implements **Explicit Verification**, a core Zero Trust pillar:
- Identity is verified for every access attempt
- Device signals are evaluated before granting access
- No implicit trust is granted based on network location
- Continuous assessment of risk and context

---

## Key Takeaways

| Concept | Benefit |
|---------|---------|
| **Bulk Provisioning** | Scale identity operations to hundreds of users |
| **Dynamic Groups** | Reduce administrative overhead with attribute-based automation |
| **Conditional Access** | Enforce security policies consistently across the organization |
| **What If Validation** | Test policies safely before production deployment |
| **Zero Trust** | Shift from perimeter-based to identity-centric security |

---

## Contributing

Feel free to submit issues or suggestions to improve this lab!

---

**Last Updated**: February 2026