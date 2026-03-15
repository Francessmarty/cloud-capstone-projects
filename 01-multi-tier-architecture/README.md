### Project 1: VNet Multi Tier Architecture with Access Control

----

### Overview

In this project, I deployed a multi tier architecture in Azure using Azure CLI scripts and version control in GitHub.

The goal:

	Create a segmented network (Web, App, DB)
	Deploy Linux VMs in each subnet
	Control traffic between them using NSGs
	Verify that only the correct communication is allowed
	Automate everything using Bash scripts

Everything was deployed using CLI. No manual resource creation in the Azure Portal.

----


### Technologies Used

	• Microsoft Azure
	• Azure CLI
	• Bash scripting
	• Virtual Networks (VNet)
	• Network Security Groups (NSG)
	• Linux Virtual Machines
	• GitHub for version control

----


### Architecture Diagram

——
                Internet
                   │
                   ▼
           Web Tier (Web VM)
           Subnet: 10.10.1.0/24
           Port: 8080
                   │
                   ▼
           App Tier (App VM)
           Subnet: 10.10.2.0/24
           Port: 5432
                   │
                   ▼
           Database Tier (DB VM)
           Subnet: 10.10.3.0/24
—-

The architecture enforces strict tier separation:

• Internet traffic reaches only the **Web Tier**
• The **Web Tier** communicates with the **App Tier**
• The **App Tier** communicates with the **Database Tier**
• Direct **Web → Database** communication is blocked by NSG rules


----


### Network Setup

The environment includes:

	1 Virtual Network

	Subnets:
		1 Web subnet (10.10.1.0/24)
		1 App subnet (10.10.2.0/24)
		1 DB subnet (10.10.3.0/24)
    Each subnet has its own NSG attached.

    Virtual Machines:
		1 Linux VM in Web subnet
		1 Linux VM in App subnet
		1 Linux VM in DB subnet


----

### Access Control Design

Traffic is restricted intentionally:

	Web to App (port 8080): Allowed
	App to DB (port 5432): Allowed
	Web to DB: Blocked

This enforces proper tier separation.

The verification script confirms that these rules behave exactly as expected.

----

### NSG Rules Summary

| Source   | Destination   | Port | Action |
|----------|-----------———-|——————|————————|
| Internet |   Web Tier    | 8080 | Allow  |
| Web Tier |   App Tier    | 8080 | Allow  |
| App Tier | Database Tier | 5432 | Allow  |
| Web Tier | Database Tier | 5432 | Deny   |
|   Any    | Other traffic | Any  | Deny   |


----


### What This Project Demonstrates

This project shows:

	•	How to create a segmented VNet with multiple subnets
	•	How to provision Linux VMs using Azure CLI
	•	How to enforce layered access control using NSGs
	•	How to verify connectivity rules between tiers
	•	How to automate deployment and cleanup using Bash scripts

----

### Scripts

All deployment steps are automated using Bash scripts.

	•	00-config.sh: Configuration variables
    •	01-deploy-network.sh: Creates VNet and subnets
	•	02-deploy-nsg.sh: Creates and configures NSGs
	•	03-deploy-vms.sh: Deploys Linux VMs
    •	04-deploy-all.sh: Runs full deployment
	•	05-verify.sh: Tests connectivity between tiers
	•	06-cleanup.sh: Deletes the resource group

There is also a deploy-all script to automate the full setup.

----

### How to Deploy

From Cloud Shell:
chmod +x scripts/*.sh
scripts/04-deploy-all.sh

---- 

### Verification

Connectivity rules were validated using an automated verification script 05-verify.sh.

The script uses Azure Run Command to remotely execute connectivity tests inside each VM and confirm that NSG rules are properly enforced.

Expected results:

	WEB to APP (Port 8080) = PASS  
	WEB to DB (Port 5432) = FAIL  
	APP to DB (Port 5432) = PASS  

These results confirm correct multi tier network segmentation and enforced access control (Web to App to DB only).

Screenshots of the verification output are included in the screenshots/ folder.

----

### Cleanup

To remove all deployed resources:
scripts/06-cleanup

This deletes the entire resource group to avoid unnecessary Azure costs.

---

### Final Notes

This project focuses on:

	Network segmentation
	Enforced access control
	Scripted deployment
	Validation through connectivity testing
	Proper cleanup after use

----
## Repository Structure

	01-multi-tier-architecture/
		screenshots/
		scripts/
		README.md

----
## Auther

Frances Ehinor