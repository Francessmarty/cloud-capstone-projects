## Cloud Infrastructure & Automation: Capstone Projects

----

This repository contains my capstone work demonstrating practical cloud engineering, containerization, infrastructure deployment and CI/CD automation using Microsoft Azure, Docker and GitHub Actions.

The capstone consists of two major projects, each focusing on different layers of modern cloud infrastructure.

----

## Repository Structure

cloud-capstone-projects/

    .github/
    01-multi-tier-architecture/
    02-dockerized-web-app/
    README.md

----

## Project 1: VNet Based Multi-Tier Architecture (Infrastructure Focus)

## Objective

Design and deploy a secure multi-tier architecture in Microsoft Azure using:

	    Virtual Network (VNet)
        Subnets (Web, App, DB)
        Linux Virtual Machines
        Network Security Groups (NSGs)
        Controlled communication between tiers


----

## Architecture Logic

Web VM to App VM to DB VM

Security rules enforced:

	    Web to App:Allowed
	    Web to DB: Blocked
	    App to DB: Allowed

This demonstrated network segmentation and access control enforcement.

## Key Skills Demonstrated
	•	Azure CLI scripting
	•	VNet and subnet configuration
	•	NSG rule configuration
	•	SSH verification
	•	Infrastructure automation via Bash scripts
	•	Cloud cost control and cleanup

----

## Project 2: Dockerized 3 Tier Web Application with CI/CD
----

## Objective

Design, containerize and deploy a 3-tier web application using Docker and GitHub CI/CD.

Application stack:

	    Frontend: Nginx
        Backend: Node.js
        Database: MySQL

----

## Application Architecture

User to Frontend (Nginx) to Backend (Node.js API) to MySQL Database

----

## What Was Implemented
	•	Separate Dockerfiles for frontend and backend
	•	Multi service orchestration using Docker Compose
	•	Image version tagging (v2)
	•	Push to Docker Hub
	•	Deployment to Azure Linux VM
	•	Public exposure of frontend
	•	Internal backend verification
	•	Automated image build & push using GitHub Actions

----

## CI/CD Pipeline

GitHub Actions workflow automatically:

	    Builds Docker images
        Tags images
        Pushes to Docker Hub

This ensures reproducible builds and automated container versioning.

----

## Deployment & Verification

For both projects, screenshots are included demonstrating:

    Infrastructure provisioning
    Network rule enforcement
    Running containers
    Public web access
    Successful CI/CD pipeline execution

All cloud resources were cleaned up after validation to prevent unnecessary cost.

----

## Technologies Used
	•	Microsoft Azure
	•	Azure CLI
	•	Linux (Ubuntu)
	•	Docker
	•	Docker Compose
	•	GitHub Actions
	•	MySQL
	•	Node.js
	•	Nginx

----

## What This Capstone Demonstrates

This capstone showcases:

    Infrastructure provisioning and segmentation
    Secure multi tier network design
    Containerization best practices
    CI/CD automation
    Cloud VM deployment
    DevOps lifecycle management
    Responsible cloud cost governance

----

## Outcome

Both projects were successfully implemented, verified and documented.

This repository demonstrates practical cloud engineering skills combining infrastructure, containerization and automation.

----

## Author

Frances Ehinor
Capstone Project: Cloud Infrastructure & Automation

