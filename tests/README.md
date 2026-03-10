# Integration Tests

Minimal test environment using Podman Compose to run Authentik locally.

## Prerequisites

- [Podman](https://podman.io/) with `podman-compose` (or Docker with `docker compose`)
- [Terraform](https://www.terraform.io/) >= 1.8.0

## Quick Start

```bash
cd tests/

# 1. Start Authentik (PostgreSQL + Redis + Server + Worker)
podman-compose up -d

# 2. Wait for Authentik to become healthy (~30-60s)
#    Check readiness:
curl -s http://localhost:9000/-/health/ready/

# 3. Initialize and apply Terraform
terraform init
terraform plan
terraform apply -auto-approve

# 4. Tear down when done
terraform destroy -auto-approve
podman-compose down -v
```

## Configuration

Edit `.env` to change defaults:

| Variable | Default | Description |
|---|---|---|
| `PG_PASS` | `testing-only-change-me` | PostgreSQL password |
| `AUTHENTIK_SECRET_KEY` | `testing-only-secret-key-...` | Authentik secret key |
| `AUTHENTIK_BOOTSTRAP_TOKEN` | `test-token-for-terraform` | API token for Terraform provider |
| `AUTHENTIK_BOOTSTRAP_PASSWORD` | `testpassword123!` | Admin (akadmin) password |
| `AUTHENTIK_TAG` | `2025.2` | Authentik image tag |
| `COMPOSE_PORT_HTTP` | `9000` | HTTP port mapping |
| `COMPOSE_PORT_HTTPS` | `9443` | HTTPS port mapping |

The bootstrap token is automatically configured as the Terraform provider token in `versions.tf`.

## What Gets Tested

The test config in `authentik.yaml` exercises the currently implemented modules:

- **System Settings** — modifies `default_user_change_username`, `event_retention`
- **Brands** — creates a default brand with custom title
