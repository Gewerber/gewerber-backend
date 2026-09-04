# Build from the project root with:
# docker build -f gewerber_backend_server/Dockerfile .

# Build stage
FROM dart:3.12.2 AS build

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
  '  sdk: ^3.10.3' \
  'workspace:' \
  '  - gewerber_backend_server' \
  > pubspec.yaml
# The dependency URLs point at the public stub packages
# (gewerber-backend-stubs). Release builds inject the real private module by
# rewriting the stubs URL to gewerber-backend-commercial via a git insteadOf
# rule; the GitHub token is supplied as a BuildKit secret (id=git_token) and
# the git config is removed afterwards:
#   docker build --secret id=git_token,env=GIT_TOKEN ...
RUN --mount=type=secret,id=git_token \
  if [ -f /run/secrets/git_token ]; then \
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
RUN mkdir -p config migrations

# Final stage
FROM alpine:latest
WORKDIR /app

# Environment variables
ENV runmode=production
ENV serverid=default
ENV logging=normal
ENV role=monolith

# Copy runtime dependencies
COPY --from=build /runtime/ /

# Copy compiled server executable and native libraries
COPY --from=build /app/gewerber_backend_server/build/bundle/ ./

# Copy configuration files and resources
COPY --from=build /app/gewerber_backend_server/config/ config/
COPY --from=build /app/gewerber_backend_server/migrations/ migrations/

# This file is required to enable the endpoint log filter in Insights.
COPY --from=build /app/gewerber_backend_server/lib/src/generated/protocol.yaml lib/src/generated/protocol.yaml

# Expose ports
EXPOSE 8080
EXPOSE 8081
EXPOSE 8082

# Define the entrypoint command
ENTRYPOINT ./bin/server --mode=$runmode --server-id=$serverid --logging=$logging --role=$role
