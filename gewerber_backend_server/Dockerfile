# Build from the project root with:
# docker build -f gewerber_backend_server/Dockerfile .

# Build stage
FROM dart:3.13.4 AS build

# git is needed to fetch the commercial module packages during `dart pub get`.
RUN apt-get update \
  && apt-get install -y --no-install-recommends git \
  && rm -rf /var/lib/apt/lists/*

# Create a minimal workspace for the server package.
WORKDIR /app
COPY gewerber_backend_server gewerber_backend_server
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
# GEWERBER_DEP_REF: default develop is the compatible OSS/staging train;
# deploy main explicitly retargets main. Incompatible targets must fail rather
# than fall back. Branch deploys pass the branch they build (develop →
# staging) so the commercial module dependency is consumed from that branch
# of gewerber-backend-commercial (via the stubs URL), end-to-end testable on
# staging before release.
ARG GEWERBER_DEP_REF=develop
RUN --mount=type=secret,id=git_token \
  sh gewerber_backend_server/tool/retarget_gewerber_refs.sh "$GEWERBER_DEP_REF" \
  && if [ -f /run/secrets/git_token ]; then \
    git config --global url."https://x-access-token:$(cat /run/secrets/git_token)@github.com/Gewerber/gewerber-backend-commercial".insteadOf "https://github.com/Gewerber/gewerber-backend-stubs"; \
    git config --global url."https://x-access-token:$(cat /run/secrets/git_token)@github.com/".insteadOf "https://github.com/"; \
  fi \
  && dart pub get \
  && rm -f ~/.gitconfig

# Compile the server executable.
WORKDIR /app/gewerber_backend_server
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
