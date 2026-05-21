# ShopFlow

Production-grade DevOps platform for a 3-microservice e-commerce application.

## Architecture
- **order-service** — Python/Flask
- **inventory-service** — Node.js
- **notification-service** — Go

## Tech Stack
| Layer | Tools |
|---|---|
| CI/CD | GitHub Actions |
| GitOps | ArgoCD + Helm |
| Infra | Terraform + OCI |
| Kubernetes | OKE + KEDA + Argo Rollouts |
| Secrets | HashiCorp Vault |
| Observability | Prometheus + Grafana + Loki + Jaeger |

## Goal
Code commit to production with zero manual steps, full observability, and automatic rollback.
