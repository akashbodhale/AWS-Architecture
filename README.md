# Go-Green-Project
This project showcases the AWS infrastructure solution designed for **GoGreen Insurance Company** to migrate their on-premise CRM application to the cloud using **Terraform**.

## Project Overview

- Migrates web, app, and database tiers to AWS.
- Ensures high availability using multi-AZ setup.
- Uses **Amazon EC2**, **RDS**, **S3**, **Auto Scaling**, **Load Balancer**, **IAM**, and **KMS**.
- Implements security, encryption, and lifecycle policies.

## Architecture Highlights

- **Web Tier**: Stateless EC2 instances behind an Application Load Balancer.
- **App Tier**: EC2 instances in private subnets with NAT gateways.
- **Database Tier**: MySQL RDS with read replicas for high availability.
- **Storage**: S3 with lifecycle rules and Glacier for long-term storage.

## Security & Access

- IAM groups for Admins, DBAs, and Monitoring.
- MFA and strict password policies.
- KMS encryption for data at rest and in transit.

## Deployment

In order  to run this project make sure you have terraform and amazon CLI installed on your system. After these pre-requisites are satisfied run the following commands
```bash
terraform init
terraform plan
terraform apply

These commands will automatically deploy the architecture defined in the code to your AWS account.
