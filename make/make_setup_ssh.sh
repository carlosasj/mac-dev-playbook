#!/usr/bin/env bash
set -euo pipefail

# === Config ===
EMAIL="${1:-$(git config user.email || echo "carlosaschjr@gmail.com")}"
DATE="$(date +%Y%m%d)"
KEY_FILE="$HOME/.ssh/id_ed25519_${DATE}"

# === Generate SSH key ===
if [ -f "$KEY_FILE" ]; then
  echo "✅ SSH key already exists for today: $KEY_FILE"
else
  echo "🔑 Generating new SSH key for $EMAIL on $DATE..."
  ssh-keygen -t ed25519 -C "${EMAIL}_${DATE}" -f "$KEY_FILE" -N ""
fi

# === Start ssh-agent ===
eval "$(ssh-agent -s)"

# === Add key to agent (only if not already added) ===
if ssh-add -l | grep -q "$DATE" ; then
  echo "🔒 Key already loaded in ssh-agent."
else
  ssh-add --apple-use-keychain "$KEY_FILE"
  echo "🔑 Key added to ssh-agent."
fi

# === Copy public key to clipboard ===
pbcopy < "${KEY_FILE}.pub"
echo "📋 Public key copied to clipboard."

# === Helpful links ===
echo "👉 Add this key to your accounts:"
echo "   • GitHub:    https://github.com/settings/keys"
echo "   • GitLab:    https://gitlab.com/-/profile/keys"
echo "   • Bitbucket: https://bitbucket.org/account/settings/ssh-keys/"
