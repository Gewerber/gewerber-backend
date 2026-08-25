# 🧩 Gewerber Backend

![Serverpod](https://img.shields.io/badge/Serverpod-4.x-blue.svg?style=flat-square)
![Dart](https://img.shields.io/badge/Dart-%5E3.12.0-0175C2.svg?logo=dart&logoColor=white&style=flat-square)
![PostgreSQL](https://img.shields.io/badge/PostgreSQL-336791.svg?logo=postgresql&logoColor=white&style=flat-square)
![License](https://img.shields.io/badge/license-MIT-green.svg?style=flat-square)

The [Serverpod](https://serverpod.dev) backend for the **Gewerber** open-source core: auth, invoicing (without payments), time tracking, basic accounting, and the guidance system.

Part of the [Gewerber GitHub organization](https://github.com/Gewerber). This is the open-source core — commercial modules (banking, tax/ELSTER, employees, subscriptions, AI assistant) live in private repositories.

---

## 🧱 Stack

- **Serverpod** `4.x` — backend framework
- **PostgreSQL** — database
- **Dart SDK** `^3.12.0`

---

## 📁 Structure

This is a Dart **workspace** with two packages:

| Package | Purpose |
|---|---|
| [`gewerber_backend_server`](gewerber_backend_server/) | The Serverpod server (endpoints, models, migrations) |
| [`gewerber_backend_client`](gewerber_backend_client/) | Generated client SDK consumed by the app |

---

## 🚀 Getting Started

### Requirements

- Dart SDK
- Serverpod CLI
- Docker (for PostgreSQL), or a local PostgreSQL

```bash
dart pub global activate serverpod_cli
```

### Run the server

From `gewerber_backend_server/`:

```bash
serverpod start
```

See [`AGENTS.md`](AGENTS.md) for the MCP-driven development workflow used in this repository.

---

## 🚢 Deployment

Continuous deployment mirrors the [website pipeline](https://github.com/Gewerber/gewerber-website):

| Branch | Environment | URL |
|---|---|---|
| `main` | production | `https://api.gewerber.de` |
| `develop` | staging | `https://api.test.gewerber.de` |

On every push, [`.github/workflows/deploy.yml`](.github/workflows/deploy.yml)
builds the server image (`gewerber_backend_server/Dockerfile`), pushes it to
GHCR, then copies [`deploy/`](deploy/) to the VPS and runs `deploy/deploy.sh`,
which starts the per-environment stack via Docker Compose behind the existing
Traefik reverse proxy:

- **server** — the Serverpod API (port 8080 only; the Insights server stays internal)
- **postgres** — PostgreSQL (migrations are applied automatically on startup)
- **redis** — cache + cross-server messaging

Secrets (database/Redis passwords, JWT keys, service secret) are generated
once per environment by `deploy.sh` and persisted on the VPS
(`~/gewerber/backend/<env>/.secrets`), so they survive redeploys.

### Required GitHub configuration

- **Secrets**: `VPS_HOST`, `VPS_USER`, `VPS_SSH_KEY`, `GHCR_TOKEN`
- **Environments**: `production`, `staging`
- **Variables** (optional, defaults match the standard Traefik setup):
  `TRAEFIK_NETWORK`, `WEB_ENTRYPOINT`, `WEBSECURE_ENTRYPOINT`, `CERT_RESOLVER`

### Self-hosting (OSS single-tenant)

Build and run the stack yourself with [`deploy/docker-compose.yml`](deploy/docker-compose.yml):

```bash
cd deploy
cp .env.example .env            # set IMAGE (or build locally), DB_PASSWORD, REDIS_PASSWORD
# provide config/passwords.yaml next to the compose file (see deploy/.env.example)
docker compose up -d --build
```

The container expects a Serverpod `config/passwords.yaml` mounted at
`/app/config/passwords.yaml` (keys: `database`, `serviceSecret`, `redis`,
`emailSecretHashPepper`, `jwtHmacSha512PrivateKey`, `jwtRefreshTokenHashPepper`).

---

## 🧭 Related

- [App](https://github.com/Gewerber/gewerber-app)
- [Documentation](https://github.com/Gewerber/gewerber-docs)
- [Contributing Guide](https://github.com/Gewerber/.github/blob/main/CONTRIBUTING.md)
- [Organization Structure](https://github.com/Gewerber/.github/blob/main/ORGANIZATION.md)

---

## 📄 License

Licensed under the [MIT License](LICENSE).
