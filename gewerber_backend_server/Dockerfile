# Build from the project root with:
# docker build -f gewerber_backend_server/Dockerfile .

# Build stage
FROM dart:3.13.6 AS build
ENV PATH="/root/.pub-cache/bin:$PATH"

# git is needed to fetch the commercial module packages during `dart pub get`.
RUN apt-get update \
  && apt-get install -y --no-install-recommends git \
  && rm -rf /var/lib/apt/lists/*

# Create a minimal workspace for the server package.
WORKDIR /app
COPY gewerber_backend_server gewerber_backend_server
# The client package is needed only so `serverpod generate` can load its
# pubspec (`client_package_path: ../gewerber_backend_client` in
# config/generator.yaml — without the directory the generator aborts with
# "Failed to load client pubspec.yaml"). It is deliberately NOT a member of
# the workspace below: nothing in this image resolves or builds it, and the
# resolution guard therefore still judges only the server module. It is
# copied before the retarget/generate layers so `retarget_gewerber_refs.sh`
# sees its pubspec like every other manifest.
COPY gewerber_backend_client gewerber_backend_client
RUN printf '%s\n' \
  'name: _' \
  'environment:' \
  '  sdk: ^3.13.3' \
  'workspace:' \
  '  - gewerber_backend_server' \
  > pubspec.yaml
# The dependency URLs point at the public stub packages
# (gewerber-backend-stubs). Release builds inject the real private module by
# rewriting the stubs URL to gewerber-backend-commercial via a git insteadOf
# rule; the GitHub token is supplied as a BuildKit secret (id=git_token) and
# the git config is removed afterwards:
#   docker build --secret id=git_token,env=GIT_TOKEN ...
#
# The rewrite is verified, not assumed: check_commercial_resolution.dart reads
# the resolution pub just performed and fails the build when the module did not
# come from the private repository, so a missing BuildKit secret can no longer
# produce a silently stubbed image. It judges the fetched package's own
# `repository:` field, because an insteadOf rewrite happens inside git — pub
# names the checkout after the stubs URL it was given, so the path cannot
# distinguish the two. It checks the module packages THIS workspace declares,
# which is the server module only: the module client belongs to
# gewerber_backend_client, which this image does not build.
#
# GEWERBER_DEP_REF: default develop is the compatible OSS/staging train;
# deploy main explicitly retargets main. Incompatible targets must fail rather
# than fall back. Branch deploys pass the branch they build (develop →
# staging) so the commercial module dependency is consumed from that branch
# of gewerber-backend-commercial (via the stubs URL), end-to-end testable on
# staging before release.
ARG GEWERBER_DEP_REF=develop
# REQUIRE_COMMERCIAL: a release image must contain the real closed-source
# module, so the default is true and a build that cannot reach the private
# repository FAILS instead of silently compiling the public stubs.
# Open-source builds that deliberately ship the stubs — the self-hosted example
# in gewerber-examples, which has no private access by definition — opt out
# explicitly with `--build-arg REQUIRE_COMMERCIAL=false`; the resolution guard
# then reports the stubs instead of failing, so the choice stays visible in the
# build log either way.
ARG REQUIRE_COMMERCIAL=true
RUN --mount=type=secret,id=git_token \
  sh gewerber_backend_server/tool/retarget_gewerber_refs.sh "$GEWERBER_DEP_REF" \
  # Fail closed: without this the `if` below would skip the rewrite silently
  # and `dart pub get` would resolve the public stubs.
  && if [ "$REQUIRE_COMMERCIAL" = "true" ] && [ ! -f /run/secrets/git_token ]; then \
    echo 'ERROR: REQUIRE_COMMERCIAL=true but no git_token BuildKit secret was mounted.' >&2; \
    echo '       Release build: pass --secret id=git_token (a token with read access to the private commercial repository).' >&2; \
    echo '       Open-source build: pass --build-arg REQUIRE_COMMERCIAL=false.' >&2; \
    exit 1; \
  fi \
  && if [ -f /run/secrets/git_token ]; then \
    git config --global url."https://x-access-token:$(cat /run/secrets/git_token)@github.com/Gewerber/gewerber-backend-commercial".insteadOf "https://github.com/Gewerber/gewerber-backend-stubs"; \
    git config --global url."https://x-access-token:$(cat /run/secrets/git_token)@github.com/".insteadOf "https://github.com/"; \
  fi \
  && dart pub get \
  # Assert the module actually resolved to the private repository. Same layer
  # as `dart pub get` so it inspects that resolution rather than a later one;
  # this guard is the only thing between a dropped `secrets:` block and a
  # published image with the stub module compiled in.
  && if [ "$REQUIRE_COMMERCIAL" = "true" ]; then \
    dart gewerber_backend_server/tool/check_commercial_resolution.dart --require; \
  else \
    dart gewerber_backend_server/tool/check_commercial_resolution.dart; \
  fi \
  && rm -f ~/.gitconfig

# Generate server code from models (.spy.yaml) before compiling the executable.
#
# The CLI is the `serverpod` executable published by the `serverpod_cli`
# package; the `serverpod` package itself ships no executables, so activating
# it installs nothing runnable and `serverpod` is then "not found".
#
# The CLI version is read from pubspec.lock -- the version pub actually
# resolved -- rather than from a literal or from the caret constraint in
# pubspec.yaml: a range would install whatever newest 4.x exists at build
# time, and a CLI newer than the resolved runtime emits artifacts that
# reference APIs the runtime does not have. The lock read here cannot be
# stale: the workspace lock lives at the workspace root (neither COPYed
# package directory contains one — pubspec.lock is gitignored) and is
# written fresh by the `dart pub get` above. Same logic as
# `.github/workflows/ci.yml` ("Install Serverpod CLI"); the awk program is
# kept on one line because every physical line of a Dockerfile instruction
# needs a trailing backslash for continuation.
WORKDIR /app/gewerber_backend_server
RUN version="$(awk '/^  serverpod:$/ { hit = 1; next } hit && /^    version:/ { gsub(/"/, "", $2); print $2; exit } hit && /^  [a-zA-Z_]/ { exit }' /app/pubspec.lock)" \
  && if [ -z "$version" ]; then \
    echo 'ERROR: could not read the resolved serverpod version from pubspec.lock' >&2; \
    exit 1; \
  fi \
  && echo "Activating serverpod_cli $version (resolved from pubspec.lock)" \
  && dart pub global activate serverpod_cli "$version" \
  # serverpod_cli runs a pre-command environment check
  # (serverpod_command_runner.dart): when it does not detect CI it aborts
  # with "You need to have flutter installed and in your $PATH". GitHub
  # runners set CI=true, so the privacy-guard job has always passed this
  # check without Flutter; this dart-only image sets CI explicitly for the
  # same effect. Generate output does not depend on the flag — the check
  # only gates the Flutter requirement (plus welcome popups/TUI), and this
  # pure-Dart server never invokes Flutter.
  && CI=true serverpod generate --force

# Release images compile the real closed-source module, so the generated model
# declares six `commercial_*` tables that the committed migration chain cannot
# contain: the chain is generated against the public stubs and `ci.yml`'s
# privacy guard forbids private table names in this repository. Serverpod only
# ever applies the project chain and, on a fresh database, only the *latest*
# migration's full definition — so without an image migration a new database
# would start without those tables (the "Table commercial_* is missing"
# warning on deploy).
#
# `create-migration` therefore folds the resolved module into an extra project
# migration that exists only in this image. Its version is the build timestamp,
# so every rebuild produces a new delta; the overlay tool rewrites that delta
# into its `IF [NOT] EXISTS` form so re-applying it to a database that already
# has the tables is a no-op. It also fails the build if the delta touches a
# non-commercial table (the committed chain drifted — regenerate it against the
# stubs) or contains a statement that cannot be made idempotent automatically.
#
# Open-source builds (REQUIRE_COMMERCIAL=false) resolve the stubs, whose schema
# *is* the committed chain, so they skip this step entirely.
RUN if [ "$REQUIRE_COMMERCIAL" = "true" ]; then \
    previous="$(ls -1 migrations | grep -E '^[0-9]{17}' | sort | tail -1)" \
    && CI=true serverpod create-migration --force \
    && dart tool/commercial_migration_overlay.dart \
      --migrations-dir migrations \
      --previous-version "$previous" \
      --require-table-prefix commercial_; \
  else \
    echo 'REQUIRE_COMMERCIAL=false: shipping the committed OSS migration chain.'; \
  fi

# Compile the server executable.
RUN dart build cli --target bin/main.dart --output build
RUN mv build/bundle/bin/main build/bundle/bin/server

# Add a fallback for the copy of possibly missing directories.
RUN mkdir -p config web migrations

# Final stage
FROM alpine:latest
WORKDIR /app

# Runtime configuration. Serverpod reads the uppercase SERVERPOD_* environment
# variables documented at
# https://docs.serverpod.dev/concepts/lookups/configuration-reference. The
# lowercase names (`runmode`, `serverid`, `logging`, `role`) previously set here
# were only ever consumed by the old shell-form ENTRYPOINT expansion and are not
# read by the framework at all. The run mode keeps its image default of
# `production` — exactly as before — and is overridden per environment through
# SERVERPOD_RUN_MODE (see deploy/docker-compose.yml).
ENV SERVERPOD_RUN_MODE=production

# Copy runtime dependencies
COPY --from=build /runtime/ /

# Copy compiled server executable and native libraries
COPY --from=build /app/gewerber_backend_server/build/bundle/ ./

# Copy configuration files and resources
COPY --from=build /app/gewerber_backend_server/config/ config/
COPY --from=build /app/gewerber_backend_server/web/ web/
COPY --from=build /app/gewerber_backend_server/migrations/ migrations/
# Invoice PDF fallback font (issue #70): lands at /app/assets/fonts/Roboto-Regular.ttf,
# matching the loader's default CWD-relative path (see invoice_pdf_font.dart).
# Because that default is relative to the working directory, changing WORKDIR or
# mounting a volume over /app hides the file and silently degrades invoice PDFs
# to the built-in Helvetica, which cannot draw € or –. The path actually resolved
# (and used) is logged on every successful load (issue #88); set
# GEWERBER_INVOICE_FONT_PATH to point at an absolute font location instead.
COPY --from=build /app/gewerber_backend_server/assets/ assets/

# This file is required to enable the endpoint log filter in Insights.
COPY --from=build /app/gewerber_backend_server/lib/src/generated/protocol.yaml lib/src/generated/protocol.yaml

# Expose ports
EXPOSE 8080
EXPOSE 8081
EXPOSE 8082

# Define the entrypoint command (exec form: no /bin/sh wrapper as PID 1, so
# SIGTERM from Docker reaches the server directly and `JSONArgsRecommended` is
# satisfied). The three constant arguments match the Serverpod defaults; the run
# mode is taken from SERVERPOD_RUN_MODE above instead of a `--mode` argument,
# because exec form cannot expand shell variables.
ENTRYPOINT ["/app/bin/server", "--server-id=default", "--logging=normal", "--role=monolith"]
