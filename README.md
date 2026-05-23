# ShopFlow — Production-Grade DevOps Platform

End-to-end DevOps platform for a 3-microservice e-commerce application. Code commit to production with zero manual steps, full observability, and automatic rollback.

## Microservices

| Service | Language | Port |
|---|---|---|
| order-service | Python/Flask | 5000 |
| inventory-service | Node.js | 3000 |
| notification-service | Go | 8080 |

## Tech Stack

| Layer | Tools |
|---|---|
| CI/CD | GitHub Actions |
| Container Registry | Amazon ECR |
| GitOps | ArgoCD |
| Kubernetes | Minikube / EKS |
| Package Manager | Helm |
| Infrastructure | Terraform |
| Cloud | AWS (eu-north-1) |
| Secrets | HashiCorp Vault |
| Metrics | Prometheus + Grafana |
| Alerting | Alertmanager |

## CI/CD Flow

Developer pushes code → GitHub Actions tests → Docker image built → Pushed to ECR → ArgoCD deploys to Kubernetes → Zero manual steps

## Key Features

- GitOps — Git is single source of truth
- Zero downtime rolling deployments
- Full observability — metrics, logs, alerts
- HashiCorp Vault — zero hardcoded credentials
- Terraform — all AWS infra as code
- Prometheus metrics on all 3 services

## Quick Start

git clone https://github.com/podder-arnab/shopflow.git
helm install shopflow ./helm/shopflow
kubectl get pods
