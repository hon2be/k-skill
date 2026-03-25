#!/usr/bin/env bash
set -euo pipefail

secrets_file="${1:-$HOME/.config/k-skill/secrets.env}"
age_key_file="${SOPS_AGE_KEY_FILE:-$HOME/.config/k-skill/age/keys.txt}"

missing=0

check_cmd() {
  if ! command -v "$1" >/dev/null 2>&1; then
    echo "missing command: $1"
    missing=1
  fi
}

check_cmd sops
check_cmd age
check_cmd age-keygen

if [[ ! -f "$age_key_file" ]]; then
  echo "missing age key file: $age_key_file"
  missing=1
fi

if [[ ! -f "$secrets_file" ]]; then
  echo "missing encrypted secrets file: $secrets_file"
  missing=1
fi

if [[ "$missing" -ne 0 ]]; then
  cat <<EOF
next steps:
  1. follow k-skill-setup / docs/setup.md
  2. register required secrets in ~/.config/k-skill/secrets.env.plain
  3. encrypt it to ~/.config/k-skill/secrets.env with sops
  4. delete the plaintext file
  5. run this check again
EOF
  exit 1
fi

SOPS_AGE_KEY_FILE="$age_key_file" \
  sops exec-env "$secrets_file" 'true'

echo "k-skill setup looks usable"
