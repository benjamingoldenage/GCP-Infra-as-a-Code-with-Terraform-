# Learn Terraform - Infrastructure as a code example for Google Cloud Platform. 

This repo contains Terraform configuration files to provision GKE cluster with 6 nodes, GCE instance, 2 different VPCs with subnets (1 for GCE instance and 1 for gke cluster). In addition to compute engine provisionings, a serverless application running on CloudRun can be deployed.

Prereqs:
Created gcp project,
Service coount key generated to access gcp project,
Terraform installation

Terrafom main.tf files: 
There are 2 different main.tf files as main.tf and main.tf.gke. 
Main.tf file contains gce VM instance creation section with a VPC konfiguration. Then Cloud Run application deployment section follows.
Main.tf.gke file contains GKE cluster creation with 6 nodes and a seperate VPC. 


