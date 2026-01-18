#!/usr/bin/env bash
set -euo pipefail

ENV_FILE=".env"

if [ ! -f "$ENV_FILE" ]; then
  echo ".env file not found"
  exit 1
fi

DART_DEFINES=""

# Read file line by line (handles last line w/o newline)
while IFS= read -r line || [ -n "$line" ]; do
  # Remove Windows CR if present
  line="${line%$'\r'}"

  # Trim leading/trailing whitespace
  line="$(printf '%s' "$line" | sed -e 's/^[[:space:]]*//' -e 's/[[:space:]]*$//')"

  # Skip empty lines and full-line comments
  [[ -z "$line" || "$line" == \#* ]] && continue

  # Allow optional "export "
  line="${line#export }"

  # Must contain '='
  [[ "$line" != *"="* ]] && continue

  key="${line%%=*}"
  value="${line#*=}"

  # Trim whitespace around key/value
  key="$(printf '%s' "$key" | sed -e 's/^[[:space:]]*//' -e 's/[[:space:]]*$//')"
  value="$(printf '%s' "$value" | sed -e 's/^[[:space:]]*//' -e 's/[[:space:]]*$//')"

  # Drop inline comments for unquoted values: KEY=foo # comment
  if [[ "$value" != \"*\" && "$value" != \'*\' ]]; then
    value="${value%%\#*}"
    value="$(printf '%s' "$value" | sed -e 's/[[:space:]]*$//')"
  fi

  # Strip surrounding single/double quotes (common in .env)
  if [[ "$value" == \"*\" && "$value" == *\" ]]; then
    value="${value:1:${#value}-2}"
  elif [[ "$value" == \'*\' && "$value" == *\' ]]; then
    value="${value:1:${#value}-2}"
  fi

  # Skip if key ended up empty
  [[ -z "$key" ]] && continue

  DART_DEFINES+=" --dart-define=$key=$value"
done < "$ENV_FILE"

echo "Building with defines:"
echo "$DART_DEFINES"

flutter build web $DART_DEFINES
