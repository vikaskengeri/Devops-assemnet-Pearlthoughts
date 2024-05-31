# Devops-assement-Pearlthoughts
# Scalable Notification Service Deployment

## Introduction
This project deploys a scalable, reliable, and maintainable notification system on AWS.

## Architecture
- **Notification API**: Receives notification requests and queues them in Amazon SQS.
- **Email Sender**: Processes messages from the queue and sends emails.
- **AWS ECS Fargate**: Used for running the microservices.
- **AWS App Mesh**: Provides service mesh capabilities.
- **AWS Cloud Map**: Facilitates service discovery.
- **Amazon SQS**: Queues messages between services.
- **Amazon CloudWatch**: Monitors the system.

## Deployment Process
1. **Dockerize** the microservices.
2. **Push** Docker images to Amazon ECR.
3. **Provision Infrastructure** using Terraform.
4. **Deploy Services** on AWS ECS Fargate.
5. **Implement Logging** with CloudWatch.
6. **Configure Auto-Scaling** based on CPU usage.
7. **Set up Health Checks** for ECS services.
8. **Test and Verify** the deployment.

## Infrastructure as Code (IaC)
We use Terraform to provision the AWS infrastructure.

## Auto-Scaling Configuration
Auto-scaling is configured to maintain CPU usage at 80%.

## Logging and Monitoring
Logs are sent to Amazon CloudWatch, and metrics are monitored to ensure system reliability.

## Security
IAM roles are configured with least-privilege access, and sensitive information is stored securely using AWS Secrets Manager.

## Bonus Points
- Implemented a CI/CD pipeline using GitHub Actions.
- Strategy for zero-downtime deployments.

## Instructions
1. Clone the repository.
2. Build and test Docker images locally.
3. Push Docker images to Amazon ECR.
4. Initialize and apply Terraform configurations.

## Evaluation
- Quality and maintainability of IaC code.
- Robustness and appropriateness of deployment architecture.
- Use and understanding of AWS services and best practices.
- Clarity and completeness of documentation.

