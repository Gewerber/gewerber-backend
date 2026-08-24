# gewerber_backend_server

Serverpod server for the Gewerber open-source core (auth, invoicing, time tracking, basic accounting, guidance).

Part of the [`gewerber-backend`](../README.md) Dart workspace. See the workspace [`AGENTS.md`](../AGENTS.md) for agent/tooling conventions.

## Running

The server is normally driven through the Serverpod MCP (see [`AGENTS.md`](../AGENTS.md)). To run it manually, from this directory:

    serverpod start

Press `Q` to stop the server.

## Layout

- `lib/server.dart` — server bootstrap
- `lib/src/` — endpoints and models (`*.spy.yaml`)
- `lib/src/generated/` — generated code (do not edit by hand)
- `config/` — per-environment configuration
- `migrations/` — database migrations
