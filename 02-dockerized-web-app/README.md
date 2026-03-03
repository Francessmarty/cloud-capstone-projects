## Project 2: Dockerized 3 Tier Web Application with CI/CD

----

## Project Overview

This project demonstrates the design, containerization and deployment of a three tier web application using Docker and Docker Compose, deployed on a Linux Virtual Machine in Microsoft Azure.

The application architecture consists of:

    Frontend: Nginx based web interface
    Backend: Node.js REST API
    Database: MySQL

The project also integrates with Docker Hub and includes a CI/CD pipeline using GitHub Actions.

----

## Architecture

User to Frontend (Nginx) to Backend (Node.js API) to Database (MySQL)

## Components

Layer	        Technology	Purpose

Frontend:   	Nginx	Serves static content and proxies API calls
Backend:	    Node.js	Handles API logic
Database:	    MySQL	Stores application data


----

## Containerization

Each service has its own Dockerfile:

    frontend/Dockerfile
    backend/Dockerfile

The services are orchestrated together using: docker-compose.yml

Docker Compose handles:

    Service networking
    Port mapping
    Environment variables
    Dependency management

----


## Docker Hub Images

Both images were built and pushed to Docker Hub with version tags:

    dockerized-web-app-frontend:v2
    dockerized-web-app-backend:v2

This allows reproducible deployments across environments.

----

## Cloud Deployment

A Linux VM was provisioned in Microsoft Azure.

Deployment steps included:

1.	SSH into the VM
2.	Clone repository
3.	Run:docker compose up -d
4.	Application exposed publicly via: http://<VM_PUBLIC_IP>:8080

All services were verified running using: docker ps


----


## CI/CD Pipeline (GitHub Actions)

A GitHub Actions workflow was implemented to:
	•	Build Docker images
	•	Tag images
	•	Push images to Docker Hub

This ensures automated builds on every commit to main.

----

## Proof of Deployment

Screenshots included in the repository demonstrate:

    Docker containers running
    Public application access
    Docker Hub images
    GitHub Actions successful pipeline run

----

## How to Run Locally

1. Clone repository: git clone <repo-url> cd 02-dockerized-web-app

2. Build and run: docker compose up --build

3. Access application: http://localhost:8080


----

## Key Skills Demonstrated
	•	Docker image creation
	•	Multi container orchestration
	•	Docker networking
	•	Cloud VM deployment
	•	CI/CD automation
	•	Container lifecycle management
	•	Version tagging strategy

----

## Lessons Learned
	•	Importance of container isolation
	•	Networking between services inside Docker
	•	Cloud security group configuration
	•	Automated image versioning
	•	Deployment validation and cleanup

----

## Cleanup

After verification and screenshot capture, the Azure VM and associated resources were deleted to prevent additional cloud costs.

----

## Repository Structure

    02-dockerized-web-app/
        backend/
            Dockerfile
        db/
            Dockerfile
        frontend/   
            Dockerfile
        docker-compose.yml
        README.md


----

## Author

Frances Ehinor



