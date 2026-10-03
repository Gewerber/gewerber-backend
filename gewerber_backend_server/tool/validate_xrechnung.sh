#!/usr/bin/env bash
#
# validate_xrechnung.sh — validate the committed XRechnung golden fixtures
# against the official KoSIT validator (XRechnung 3.0.2 configuration).
#
# This is the spec-conformance net: it proves the emitted documents pass the
# EN 16931 / XRechnung schematron rules. The byte-identity golden test
# (test/unit/xrechnung_golden_test.dart) is the separate regression net.
#
# Usage:
#   tool/validate_xrechnung.sh            # from gewerber_backend_server/
#   <any path>/tool/validate_xrechnung.sh # also works, root is self-resolved
#
# Environment:
#   XR_VALIDATOR_CACHE   download/cache directory
#                        (default: ${XDG_CACHE_HOME:-$HOME/.cache}/xrechnung-validator;
#                         CI should mount/persist this directory)
#   XR_VALIDATOR_REPORTS report output directory (default: $XR_VALIDATOR_CACHE/reports)
#
# Requirements: bash, curl, unzip, python3, and `java` (JRE 11+) on PATH
# (CI provides Temurin 21). Fail-closed: both downloaded artifacts are
# sha256-pinned and the validator is never run on an unverified artifact.
# The script writes only inside the cache and reports directories.
set -euo pipefail

# --- pinned artifacts --------------------------------------------------------

VALIDATOR_JAR_NAME='validator-1.6.3-standalone.jar'
VALIDATOR_JAR_URL='https://repo1.maven.org/maven2/org/kosit/validator/1.6.3/validator-1.6.3-standalone.jar'
VALIDATOR_JAR_SHA256='799e64befca97d4080e03608c80b85dd5a5ecc5f4ae4f35d1116ec2855b9a7c9'

# --- helpers -----------------------------------------------------------------

die() {
  echo "validate_xrechnung: $*" >&2
  exit 1
}

# verify_and_fetch <url> <sha256> <dest-name>
#
# Downloads <url> into the cache only if <dest-name> is absent, then verifies
# the sha256 of the file that is (or would be) used — always, even for a warm
# cache — and aborts before any validation on mismatch.
verify_and_fetch() {
  local url="$1" want="$2" name="$3"
  local dest="$CACHE_DIR/$name" tmp

  if [ ! -f "$dest" ]; then
    echo "validate_xrechnung: downloading $url"
    tmp="$(mktemp "$CACHE_DIR/.$name.XXXXXX.part")"
    # Clean up a failed/partial download; a finished-but-corrupt file is
    # caught by the hash check below.
    trap 'rm -f "$tmp"' RETURN
    curl -fsSL --retry 3 -o "$tmp" "$url" \
      || { rm -f "$tmp"; die "download failed: $url"; }
    mv "$tmp" "$dest"
    trap - RETURN
  fi

  local got
  got="$(sha256sum "$dest" | awk '{print $1}')"
  if [ "$got" != "$want" ]; then
    rm -f "$dest"
    die "sha256 mismatch for $name (cached artifact is corrupt, tampered with, or stale; deleted it — rerun to fetch again)
    expected: $want
    actual:   $got"
  fi
}

# --- locate package root (script lives at <root>/tool/) -----------------------

SCRIPT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" >/dev/null 2>&1 && pwd)"
ROOT="$(dirname -- "$SCRIPT_DIR")"
FIXTURE_DIR="$ROOT/test/fixtures/xrechnung"
[ -d "$FIXTURE_DIR" ] || die "fixture directory not found: $FIXTURE_DIR"

# --- tooling checks ------------------------------------------------------------

for tool in curl unzip sha256sum python3 java; do
  command -v "$tool" >/dev/null 2>&1 || die \
    "$tool is required but not on PATH. Java: install a JRE 11+ (CI uses Temurin 21, e.g. via actions/setup-java). Others ship with the base images."
done

# --- cache layout --------------------------------------------------------------

CACHE_DIR="${XR_VALIDATOR_CACHE:-${XDG_CACHE_HOME:-$HOME/.cache}/xrechnung-validator}"
CONFIG_DIR="$CACHE_DIR/configuration-xrechnung-2026-08-31"
REPORTS_DIR="${XR_VALIDATOR_REPORTS:-$CACHE_DIR/reports}"
mkdir -p "$CACHE_DIR" "$REPORTS_DIR"

# --- fetch + verify artifacts ---------------------------------------------------

CONFIG_ZIP_NAME='xrechnung-3.0.2-validator-configuration-2026-08-31.zip'
CONFIG_ZIP_URL='https://github.com/itplr-kosit/validator-configuration-xrechnung/releases/download/v2026-08-31/xrechnung-3.0.2-validator-configuration-2026-08-31.zip'
CONFIG_ZIP_SHA256='2530cd107c414511c5d0462ec10f886910395abfca820db82e83d70bf01221a8'

verify_and_fetch "$VALIDATOR_JAR_URL" "$VALIDATOR_JAR_SHA256" "$VALIDATOR_JAR_NAME"
verify_and_fetch "$CONFIG_ZIP_URL" "$CONFIG_ZIP_SHA256" "$CONFIG_ZIP_NAME"

# The configuration zip holds scenarios.xml + resources/ (+ docs, README,
# CHANGELOG) at its root; extract into a stable subdirectory of the cache.
# Freshness is guaranteed by the sha256 verification above, so extracting
# once is enough.
if [ ! -f "$CONFIG_DIR/scenarios.xml" ]; then
  echo "validate_xrechnung: unpacking configuration into $CONFIG_DIR"
  rm -rf "$CONFIG_DIR"
  mkdir -p "$CONFIG_DIR"
  unzip -q "$CACHE_DIR/$CONFIG_ZIP_NAME" -d "$CONFIG_DIR"
fi

# --- run the validator -----------------------------------------------------------

shopt -s nullglob
FIXTURES=("$FIXTURE_DIR"/*.xml)
shopt -u nullglob
[ "${#FIXTURES[@]}" -gt 0 ] || die "no fixtures found in $FIXTURE_DIR"

rm -rf "$REPORTS_DIR"
mkdir -p "$REPORTS_DIR"

echo "validate_xrechnung: validating ${#FIXTURES[@]} fixture(s) with KoSIT validator (XRechnung 3.0.2 configuration)"
jar_rc=0
java -jar "$CACHE_DIR/$VALIDATOR_JAR_NAME" \
  -s "$CONFIG_DIR/scenarios.xml" \
  -r "$CONFIG_DIR" \
  -o "$REPORTS_DIR" \
  "${FIXTURES[@]}" || jar_rc=$?

# --- judge the reports -------------------------------------------------------------
#
# The validator writes <fixture>-report.xml per document and does not itself
# exit non-zero for invalid inputs, so parse the reports. Fail if any document
# has valid="false" or any rep:message at level="error"; print rule id/code and
# text for each rejected document.

python3 - "$REPORTS_DIR" "${FIXTURES[@]}" <<'PYEOF' || python_rc=$?
import os
import sys
import xml.etree.ElementTree as ET

REP = "{http://www.xoev.de/de/validator/varl/1}"

reports_dir = sys.argv[1]
fixtures = sys.argv[2:]
failures = []
missing = []

for fixture in fixtures:
    name = os.path.basename(fixture)
    # The validator names reports after the file stem: "standard.xml" ->
    # "standard-report.xml".
    stem = os.path.splitext(name)[0]
    report = os.path.join(reports_dir, stem + "-report.xml")
    if not os.path.isfile(report):
        missing.append(name)
        continue
    root = ET.parse(report).getroot()
    if root.get("valid") == "true":
        continue
    messages = [
        msg
        for msg in root.iter(REP + "message")
        if (msg.get("level") or "").lower() == "error"
    ]
    failures.append((name, messages))

if missing:
    print("no validation report produced for: " + ", ".join(missing), file=sys.stderr)
for name, messages in failures:
    print(f"REJECTED {name}", file=sys.stderr)
    if messages:
        for msg in messages:
            code = msg.get("code") or msg.get("id") or "?"
            text = " ".join((msg.text or "").split())
            print(f"  [{code}] {text}", file=sys.stderr)
    else:
        print("  report marked the document invalid without error-level messages; inspect the report XML", file=sys.stderr)

if missing or failures:
    sys.exit(1)
PYEOF
python_rc=${python_rc:-0}

# --- summary --------------------------------------------------------------------------

total=${#FIXTURES[@]}
if [ "$jar_rc" -ne 0 ] || [ "$python_rc" -ne 0 ]; then
  echo "validate_xrechnung: FAILED — XRechnung validation errors (reports: $REPORTS_DIR)" >&2
  exit 1
fi
echo "validate_xrechnung: OK — $total/$total fixture(s) passed XRechnung validation (reports: $REPORTS_DIR)"
