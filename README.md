# 🧩 Gewerber Backend

![Serverpod](https://img.shields.io/badge/Serverpod-4.1.0-blue.svg?style=flat-square)
![Dart](https://img.shields.io/badge/Dart-%5E3.13.3-0175C2.svg?logo=dart&logoColor=white&style=flat-square)
![PostgreSQL](https://img.shields.io/badge/PostgreSQL-336791.svg?logo=postgresql&logoColor=white&style=flat-square)
![License](https://img.shields.io/badge/license-MIT-green.svg?style=flat-square)

The [Serverpod](https://serverpod.dev) backend for the **Gewerber** open-source core: auth, invoicing (without payments), time tracking, basic accounting, and the guidance system.

Part of the [Gewerber GitHub organization](https://github.com/Gewerber). This is the open-source core — commercial modules (banking, tax/ELSTER, employees, subscriptions, AI assistant) live in private repositories.

---

## 🧱 Stack

- **Serverpod** `4.1.0` — backend framework
- **PostgreSQL** — database
- **Dart SDK** `^3.13.3`

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
- Serverpod CLI `4.1.0`
- Docker (for PostgreSQL), or a local PostgreSQL

```bash
dart pub global activate serverpod_cli 4.1.0
```

### Run the server

From `gewerber_backend_server/`:

```bash
serverpod start
```

The dev/test PostgreSQL services (`gewerber_backend_server/docker-compose.yaml`) read their
passwords from a local `.env`: run `cp .env.example .env` in `gewerber_backend_server/` before
`docker compose up -d postgres_test`, and keep the `test:` block `database:` value in the
gitignored `config/passwords.yaml` equal to `POSTGRES_TEST_PASSWORD`.

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

- **server** — the Serverpod API (port 8080) plus, only when social sign-in is
  configured, the web server that serves the OAuth callbacks (port 8082, routed
  by Traefik under `/auth/`, never published to the host); the Insights server
  stays internal
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

Invoice PDFs use a fallback font shipped in the image at the CWD-relative path
`assets/fonts/Roboto-Regular.ttf`. Keep `WORKDIR /app` and do not mount a volume
over `/app`, or the font is hidden and invoices silently fall back to Helvetica
(no `€` or `–`); set `GEWERBER_INVOICE_FONT_PATH` to point somewhere else. The
resolved path is logged when the font is first loaded (once per process, on the
first generated invoice).

### Social sign-in (optional)

Google, Apple, Facebook and Microsoft sign-in are opt-in. Each provider is
enabled by adding its keys to the `config/passwords.yaml` section that matches
the run mode (`<mode>:` → provider keys); no code change is required.

| Provider | Keys |
|---|---|
| Google | `googleClientSecret` — the **entire** downloaded `google_client_secret.json` (one YAML string). The document must carry a `web` object with non-empty `client_id`, `client_secret` and a `redirect_uris` list; if any of these are missing or the JSON is malformed, Google is reported as **disabled** and the server still starts. |
| Apple | `appleServiceIdentifier`, `appleBundleIdentifier`, `appleRedirectUri`, `appleTeamId`, `appleKeyId`, `appleKey` (the multi-line `.p8` private key; when deploying via `deploy/deploy.sh`, pass `APPLE_KEY="$(cat AuthKey_XXX.p8)"` so newlines are preserved as a YAML block scalar). Optional: `appleAndroidPackageIdentifier`, `appleWebRedirectUri`. |
| Facebook | `facebookAppId`, `facebookAppSecret`. Facebook logs in with an access token obtained by the app, so it has no server-side callback path. |
| Microsoft | `microsoftClientId`, `microsoftClientSecret`. Optional: `microsoftTenant` (default `common`). |

The server-side OAuth callback paths are fixed by the code and must be
registered with each provider that redirects through the browser:

| Provider | Path | Registered by |
|---|---|---|
| Google, Microsoft | `/auth/callback` | `flutter_web_auth_2` callback route (`lib/src/auth/social_auth_routes.dart`) |
| Apple | `/auth/apple/callback` | Apple web authentication callback |
| Apple | `/auth/apple/revoked` | Apple server-to-server consent-revoked / account-deleted notifications |

They are served by the Serverpod **web server**, not the API server, so the
deployment needs the `webServer` section in `config/<mode>.yaml` and the extra
port routed to it (see [`deploy/README.md`](deploy/README.md), section
“Ports”): the public origin is the same host as the API.

**Disabled vs. broken.** A provider whose required keys are missing or blank is
simply **disabled** — the server still starts and logs one line per provider at
boot, e.g. `[auth] google: disabled (missing googleClientSecret)`. Present but
malformed Google credentials (for example a `googleClientSecret` that is not a
valid JSON object carrying `web.client_id`, `web.client_secret` and
`web.redirect_uris`) are also reported as **not configured** without throwing,
so the Google provider is disabled and the server boots normally; for Apple,
Facebook and Microsoft, any non-blank required string values enable the
provider without throwing at config load. Never commit credentials —
`config/passwords.yaml` is gitignored; the deployment writes it from environment
variables (see `deploy/deploy.sh`).

---

## 🧭 Related

- [App](https://github.com/Gewerber/gewerber-app)
- [Documentation](https://github.com/Gewerber/gewerber-docs)
- [Contributing Guide](https://github.com/Gewerber/.github/blob/main/CONTRIBUTING.md)
- [Organization Structure](https://github.com/Gewerber/.github/blob/main/ORGANIZATION.md)

---

## 📄 License

Licensed under the [MIT License](LICENSE).
