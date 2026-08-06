#!/bin/bash
# push.sh — stage, commit, and push this repo without ever persisting a
# GitHub PAT to disk, shell history, or logs.
set -euo pipefail

# --- 0. Sanity checks -------------------------------------------------
if ! git rev-parse --is-inside-work-tree >/dev/null 2>&1; then
  echo "Error: not inside a git repository." >&2
  exit 1
fi

REMOTE_URL="$(git config --get remote.origin.url || true)"
if [ -z "$REMOTE_URL" ]; then
  echo "Error: no 'origin' remote configured." >&2
  exit 1
fi
if [[ "$REMOTE_URL" != https://* ]]; then
  echo "Error: origin remote is not an https:// URL (got: $REMOTE_URL)." >&2
  echo "This script only knows how to inject a token into an https remote." >&2
  exit 1
fi

# --- 1. Stage everything -----------------------------------------------
git add -A

# Nothing to commit? Bail cleanly rather than committing an empty change.
if git diff --cached --quiet; then
  echo "Nothing to commit — working tree matches last commit. Exiting." >&2
  exit 1
fi

# --- 2. Commit message (default: timestamped "update") -----------------
read -r -p "Commit message [update $(date -u +%Y-%m-%dT%H:%M:%SZ)]: " COMMIT_MSG
if [ -z "$COMMIT_MSG" ]; then
  COMMIT_MSG="update $(date -u +%Y-%m-%dT%H:%M:%SZ)"
fi
git commit -m "$COMMIT_MSG"

# --- 3. Prompt for PAT (silent, never echoed, never an argument) -------
read -r -s -p "GitHub PAT (used once, not stored): " GH_TOKEN
echo
if [ -z "$GH_TOKEN" ]; then
  echo "Error: no token entered. Commit was made locally but not pushed." >&2
  exit 1
fi

# Build a token-authenticated URL for this push only. Strip any scheme
# prefix so we can re-add it with the token embedded.
HOST_AND_PATH="${REMOTE_URL#https://}"
AUTHED_URL="https://${GH_TOKEN}@${HOST_AND_PATH}"

# --- 4. Push using the token, then immediately restore the plain URL ---
# The trap guarantees the remote is reset to the plain https URL even if
# the push fails or the script is interrupted — the token must never
# persist in .git/config.
restore_remote() {
  git remote set-url origin "$REMOTE_URL" >/dev/null 2>&1 || true
}
trap restore_remote EXIT

git remote set-url origin "$AUTHED_URL"

if git push origin main; then
  echo "Push succeeded."
else
  PUSH_STATUS=$?
  echo "Error: push failed (exit $PUSH_STATUS)." >&2
  # trap still restores the remote URL on exit; token was never logged.
  exit "$PUSH_STATUS"
fi

# restore_remote runs automatically via the EXIT trap here too.
