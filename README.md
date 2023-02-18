# terraform-modules
Terraform Module: 3-Tier Deployment of Docker Containers using Fargate on ECS in Two Different Regions
This Terraform module deploys a 3-tier application on Amazon ECS Fargate in two different regions. The application consists of the following tiers:

A frontend web application running in a Docker container on ECS Fargate.
A backend API server running in a Docker container on ECS Fargate.
A database running on Amazon RDS.
The module creates all the necessary resources to run the application, including the following:

Amazon VPCs, subnets, and security groups.
Amazon RDS instances.
Amazon ECS clusters, task definitions, and services.
Amazon Application Load Balancers (ALBs).
