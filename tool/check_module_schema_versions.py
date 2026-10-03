#!/usr/bin/env python3
"""Assert that committed migrations are in sync with the resolved modules.

Serverpod does not apply a module's own migrations at runtime. Instead,
`serverpod create-migration` merges the schema of every dependent module (taken
from that module's latest committed migration) into the *project's* migration,
and records the module's version in `serverpod_migrations` when the project
migration is applied.

That makes the project's migration chain a snapshot of the module schema as it
was at generation time. When the module ships a newer migration, the generated
Dart model declares columns the committed SQL never creates, and inserts fail
at runtime with a Postgres `undefined_column` error (the startup integrity
check only turns that into a hard failure in `development` run mode).

This script fails when the module version recorded by the latest project
migration is not one the module package on disk actually ships, which is the
signal to re-run `serverpod create-migration`.

Usage:
    tool/check_module_schema_versions.py <migrations-dir> <package-config> <module-server-pkg>

    migrations-dir     e.g. gewerber_backend_server/migrations
    package-config     e.g. .dart_tool/package_config.json
    module-server-pkg  e.g. gewerber_backend_commercial_server
"""

import json
import re
import sys
from pathlib import Path
from urllib.parse import urlparse
from urllib.parse import urlunparse

MIGRATION_DIR = re.compile(r'^\d{17}')


def die(message: str) -> None:
    print(message, file=sys.stderr)
    raise SystemExit(1)


def package_root(package_config: Path, package_name: str) -> Path:
    """Resolve a package name to its on-disk root via the pub package config."""
    config = json.loads(package_config.read_text())
    base = package_config.parent.resolve().as_uri() + '/'
    for package in config['packages']:
        if package['name'] != package_name:
            continue
        root_uri = package['rootUri']
        # rootUri is either a `file:` URI or a path relative to `.dart_tool/`.
        absolute = urlunparse(urlparse(url=base + root_uri)) if '://' not in root_uri else root_uri
        path = Path(urlparse(url=absolute).path)
        if not path.is_dir():
            die(f'::error::resolved package root does not exist: {path}')
        return path
    die(f'::error::{package_name} is not resolved — did `dart pub get` run?')
    raise AssertionError  # unreachable, keeps the return type honest


def main(argv: list[str]) -> int:
    if len(argv) != 4:
        die(__doc__ or 'wrong number of arguments')

    migrations_dir = Path(argv[1])
    package_config = Path(argv[2])
    module_package = argv[3]

    versions = sorted(
        path for path in migrations_dir.iterdir()
        if path.is_dir() and MIGRATION_DIR.match(path.name)
    )
    if not versions:
        die(f'::error::no project migrations found in {migrations_dir}')
    latest = versions[-1]

    definition_path = latest / 'definition.json'
    if not definition_path.is_file():
        die(f'::error::missing {definition_path}')
    definition = json.loads(definition_path.read_text())

    # The DB module name is the server package name without its `_server` suffix.
    module_name = module_package.removesuffix('_server')
    recorded = {
        entry['module']: entry['version']
        for entry in definition.get('installedModules', [])
        if entry['module'] == module_name
    }
    if not recorded:
        print(f'{module_name} is not installed in {latest.name}; nothing to check.')
        return 0

    shipped = {
        path.name for path in package_root(package_config, module_package).joinpath('migrations').iterdir()
        if path.is_dir() and MIGRATION_DIR.match(path.name)
    }

    stale = [
        f'{module_name}={version} (module ships: {", ".join(sorted(shipped)) or "none"})'
        for version in recorded.values()
        if version not in shipped
    ]
    if stale:
        print('\n'.join(stale))
        die(
            '::error::the latest project migration records a module schema version the '
            'resolved module does not ship, so the committed SQL is a stale copy of the '
            'module schema. Run `serverpod generate` and `serverpod create-migration` '
            'against the current module, then commit the result.'
        )

    print(f'{latest.name} records {module_name}={next(iter(recorded.values()))}, which the module ships.')
    return 0


if __name__ == '__main__':
    raise SystemExit(main(sys.argv))
