# A. Go-Green-Project Overview
This project involves the design and implementation of a scalable, secure, and cost-effective cloud infrastructure for GoGreen Insurance Company using AWS services. The infrastructure is deployed using Terraform to ensure Infrastructure as Code (IaC), version control, and reproducibility.

## B. Problem Statement
The GoGreen Insurance Company’s on-premises current infrastructure faces frequent performance bottlenecks, long upgrade cycles, and rising operational costs. With an expected 90% growth in users over three years, GoGreen requires a scalable, secure, and cost-effective cloud solution. This project addresses these issues and migrates their web, application, and database tiers to AWS using Terraform, thus solving reliability, security, and automation issues while meeting compliance requirements for data encryption and long-term storage.

## C. Project Objectives
- Migrate the on-prem application (Web, App, DB) to AWS with high availability.
- Implement a VPC-based architecture with public and private subnets across multiple AZs.
- Automate provisioning using **Terraform**.
- Enable encryption at rest and in transit using **AWS KMS**.
- Enforce best practices for IAM, security groups, and monitoring.
- Ensure scalability, security, and compliance with GoGreen's data handling and access requirements.
- Use managed services **(e.g., RDS, S3)** to reduce operational overhead and cost.

## D. AWS Architecture Overview
![Architecture Diagram](Architecture%20Diagram.png)

###  1. Key Design Features
- **Region:** us-west-1
- **VPC with two Availability Zones** :(AZ-1 and AZ-2).
- **Public Subnets:** For Web-tier instances and NAT Gateways.
- **Private Subnets:** For App-tier instances and RDS databases.
- **NAT Gateway:** Provides outbound internet access for private subnets.
- **Application Load Balancer (ALB):** Distributes incoming traffic to the Web-tier.
- **Auto Scaling Groups:** For Web and App tiers for performance and high availability.
- **Amazon RDS:** MySQL databases with Multi-AZ deployment for high availability.
- **Amazon S3:**For storing application-generated documents and images with lifecycle policies.
- **IAM:** User/group access control with MFA, strong password policies, and roles.
- **Security Groups:** Granular control over network access.

### 2. Components Deployed
| **Tier**         | **Instance Type** | **Count** | **Purpose**                                      |
|------------------|-------------------|-----------|--------------------------------------------------|
| Web Tier         | `m6.large`        | 6         | Hosts Apache Tomcat + PHP on RHEL8              |
| App Tier         | `m6.2xlarge`      | 6         | Hosts Java application on RHEL8                 |
| Database Tier    | `db.m5.large`     | 2         | Amazon RDS MySQL cluster with replication       |

> **Note**: During testing of terraform code we used t2.micro instance due to cost constraints.

## E. Security and Compliance
This section outlines the security measures, IAM configurations, and compliance practices implemented to protect the GoGreen infrastructure on AWS.

### 1. Encryption
- **Data at rest:** Enabled via AWS KMS (S3, RDS, EBS).
- **Data in transit:** Enforced using TLS/HTTPS.

### 2. IAM Configuration
- **System Admins:** Programmatic + Console access with MFA.
- **DB Admins:** Console access for RDS.
- **Monitoring Users:** Limited read-only access.

### 3. Password Policies
- 8+ characters, mixed case, number, special char.
- Rotation every 90 days; no reuse of last 3 passwords.

## F. AWS Services Used
- **Amazon EC2** – To host application and web servers.
- **Amazon RDS (MySQL)** – To implement database layer with Multi-AZ and replicas.
- **Amazon S3 / Glacier** – To acheive File and archive storage with lifecycle rules.
- **Elastic Load Balancer (ALB)** – For Load distribution and  periodic health checks.
- **Auto Scaling Groups** – To auto scale up and down ec2 instances as per demand.
- **IAM** – For Role-based access control.
- **AWS KMS** – To encrypt data at rest.
- **CloudWatch** – For Monitoring and alarms.

## G. Storage Strategy
This section describes the storage architecture, data lifecycle policies, and cost-optimized solutions used to manage documents, images, and backups in the GoGreen environment.

###  1. Amazon S3:
- Stores application files, logs, documents, and pictures.
- S3 Lifecycle Policies move files to Glacier after 90 days and retain them for 5 years.

### 2. Amazon RDS
- High IOPS for consistent DB performance.
- Multi-AZ setup for failover and patch management.

##  H. Project Folder Structure
The repository is organized as follows:
Go-Green-Project/
├── Architecture Diagram.png # AWS Infrastructure Architecture Diagram
├── README.md # Project documentation and usage instructions
└── Terraform Code/ # Terraform configuration files
├── main.tf # Main entry point for Terraform resources
├── variables.tf # Input variable definitions
├── outputs.tf # Output values from the deployment
├── vpc.tf # Virtual Private Cloud (VPC), subnets, routing setup
├── ec2.tf # Web and Application tier EC2 instances
├── rds.tf # Amazon RDS MySQL configuration
├── s3.tf # Amazon S3 bucket and lifecycle policies
├── iam.tf # IAM roles, users, groups, and policies
├── security_groups.tf # Security group definitions for each tier
└── provider.tf # AWS provider configuration

## I. Project Set-up
This section gives the instructions regarding running the project.
### 1. Pre-requisities
Before running this project there are some requirements that needs to be met.They are listed below:
- AWS CLI configured with appropriate IAM credentials.
- Visual Studio Code or IntelliJ Idea(Basically any IDE that supports Terraform)
- Terraform installed (v1.3+).
- AWS Acccount for Testing

### 2. Deployment Steps
Run the following commands one by one in sequence in ordrer to deploy the architecutre on your AWS account.
```bash
# Initialize Terraform
terraform init

# Preview changes
terraform plan

# Apply infrastructure
terraform apply
```
