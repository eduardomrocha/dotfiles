#!/usr/bin/env bash
SECRETS_FILE="$HOME/.config/sops/secrets.yaml"
KEY_FILE="$HOME/.config/sops/age/keys.txt"

if [ ! -f "$SECRETS_FILE" ]; then
  echo "[SECRETS] ERROR: Secrets file not found in $SECRETS_FILE"
  return 1
fi

if [ ! -f "$KEY_FILE" ]; then
  echo "[SECRETS] ERROR: Keys file not found in $KEY_FILE"
  return 1
fi

export $(sops --decrypt "$SECRETS_FILE" | grep -v "sops:" | awk -F ': ' '{print $1 "=" $2}' | tr -d '"' | xargs)
