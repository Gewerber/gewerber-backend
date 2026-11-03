#!/usr/bin/env python3
"""Assert that committed migrations are in sync with the resolved modules.

Serverpod does not apply a module's own migrations at runtime. Instead,
`serverpod create-migration` merges the schema of every dependent module (taken
from that module's latest committed migration) into the *project's* migration,
and records the module's version in `serverpod_migrations` when the project
migration is applied.

That makes the project's migration chain a snapshot of the module schema as it
was at generation time. When a module ships a newer migration, the generated
Dart model declares tables or columns the committed SQL never creates, and the
server fails at runtime (the startup integrity check only turns that into a
hard failure in `development` run mode).

This script reads the module versions recorded by the latest project migration
and compares each one with the versions the resolved module package actually
ships. A mismatch means the chain is stale and `serverpod create-migration`
must be run again and the result committed.

Usage:
    tool/check_module_schema_versions.py <migrations-dir> <package-config> [module-server-pkg ...]

    migrations-dir     e.g. gewerber_backend_server/migrations
    package-config     e.g. .dart_tool/package_config.json
    module-server-pkg  optional; when omitted, every module recorded by the
                       latest migration is checked. Pass one or more package
                       names (e.g. gewerber_backend_commercial_server) to
                       restrict the check.

Package lookup: a module named `foo` resolves to the `foo_server` package when
that exists (Serverpod's convention for module server packages), otherwise to
`foo`. The project's own module is always skipped: its migrations are the
chain being inspected.
"""

import json
import re
import sys
from pathlib import Path
from urllib.parse import urlparse
from urllib.parse import urlunparse

MIGRATION_DIR = re.compile(r"^\d{17}")


def die(message: str) -> None:
    print(message, file=sys.stderr)
    raise SystemExit(1)


def package_roots(package_config: Path) -> dict[str, Path]:
    """Resolve every package name to its on-disk root via the package config."""
    config = json.loads(package_config.read_text())
    base = package_config.parent.resolve().as_uri() + "/"
    roots: dict[str, Path] = {}
    for package in config["packages"]:
        root_uri = package["rootUri"]
        # rootUri is either a `file:` URI or a path relative to `.dart_tool/`.
        absolute = (
            urlunparse(urlparse(url=base + root_uri))
            if "://" not in root_uri
            else root_uri
        )
        path = Path(urlparse(url=absolute).path)
        if not path.is_dir():
            die(f"::error::resolved package root does not exist: {path}")
        roots[package["name"]] = path
    return roots


def migration_versions(package_dir: Path) -> set[str]:
    migrations = package_dir / "migrations"
    if not migrations.is_dir():
        return set()
    return {
        path.name
        for path in migrations.iterdir()
        if path.is_dir() and MIGRATION_DIR.match(path.name)
    }


def resolve_module_package(module: str, roots: dict[str, Path]) -> str | None:
    for candidate in (f"{module}_server", module):
        if candidate in roots:
            return candidate
    return None


def main(argv: list[str]) -> int:
    if len(argv) < 3:
        die(__doc__ or "wrong number of arguments")

    migrations_dir = Path(argv[1])
    package_config = Path(argv[2])
    requested = argv[3:]

    versions = sorted(
        path
        for path in migrations_dir.iterdir()
        if path.is_dir() and MIGRATION_DIR.match(path.name)
    )
    if not versions:
        die(f"::error::no project migrations found in {migrations_dir}")
    latest = versions[-1]

    definition_path = latest / "definition.json"
    if not definition_path.is_file():
        die(f"::error::missing {definition_path}")
    definition = json.loads(definition_path.read_text())

    project_module = definition.get("moduleName")
    installed = {
        entry["module"]: entry["version"]
        for entry in definition.get("installedModules", [])
        if entry["module"] != project_module
    }
    if not installed:
        print(f"{latest.name} records no module versions; nothing to check.")
        return 0

    roots = package_roots(package_config)

    if requested:
        wanted = set(requested)
        known = set(installed) | {f"{module}_server" for module in installed}
        unknown = wanted - known
        if unknown:
            die(
                "::error::module packages not recorded by "
                f"{latest.name}: {', '.join(sorted(unknown))}"
            )
        modules = {
            module: version
            for module, version in installed.items()
            if f"{module}_server" in wanted or module in wanted
        }
    else:
        modules = installed

    stale: list[str] = []
    for module, recorded in sorted(modules.items()):
        package = resolve_module_package(module, roots)
        if package is None:
            stale.append(
                f"{module}={recorded} (no resolved package; expected "
                f"{module}_server or {module})"
            )
            continue
        shipped = migration_versions(roots[package])
        if not shipped:
            stale.append(
                f"{module}={recorded} (resolved package {package} ships no "
                "migrations, so the recorded version cannot be verified)"
            )
        else:
            latest_shipped = max(shipped)
            if recorded != latest_shipped:
                stale.append(f"{module}={recorded} (module latest: {latest_shipped})")

    if stale:
        print("\n".join(stale))
        die(
            "::error::the latest project migration does not record the latest "
            "migration of every resolved module, so the committed SQL is a "
            "stale copy of the module schema. Run `serverpod generate` and "
            "`serverpod create-migration` against the current modules, then commit "
            "the result."
        )

    checked = ", ".join(f"{module}={modules[module]}" for module in sorted(modules))
    print(f"{latest.name} records the latest migration of: {checked}.")
    return 0


if __name__ == "__main__":
    raise SystemExit(main(sys.argv))
