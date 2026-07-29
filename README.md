# 🧩 Gewerber Backend Core

The [Serverpod](https://serverpod.dev) backend for the **Gewerber** open-source core: auth, invoicing (without payments), time tracking, basic accounting, and the guidance system.

Part of the [Gewerber GitHub organization](https://github.com/Gewerber). This is the open-source core — commercial modules (banking, tax/ELSTER, employees, subscriptions, AI assistant) live in private repositories.

---

## 🧱 Stack

- **Serverpod** `4.x` — backend framework
- **PostgreSQL** — database
- **Dart SDK** `^3.10.3`

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

## 🧭 Related

- [App](https://github.com/Gewerber/gewerber-app)
- [Documentation](https://github.com/Gewerber/gewerber-docs)
- [Contributing Guide](https://github.com/Gewerber/.github/blob/main/CONTRIBUTING.md)
- [Organization Structure](https://github.com/Gewerber/.github/blob/main/ORGANIZATION.md)

---

## 📄 License

Licensed under the [MIT License](LICENSE).
