#!/bin/sh
# Kin's PermissionRequest hook for Claude Code.
#
# Claude Code runs this when it is about to ask you for permission to use a tool, with the
# request on standard input. This script hands that input to Kin's own permission hook, which
# is installed on this computer with the Kin app (Mac) or with kin-bridge, and which sends the
# request to your Kin account so you can answer it on your phone or in Kin. If you turned off
# permission prompts in Kin, Kin's hook prints nothing and Claude Code asks you as usual.
#
# This script does nothing, and Claude Code asks you as usual, when:
#   - Kin's own hook is already in your Claude Code settings (Kin puts it there when you turn on
#     permission prompts in Kin), so a request is never sent to Kin twice; or
#   - neither the Kin app nor kin-bridge is installed.
#
# It downloads and installs nothing, reads no credentials, and sends nothing on its own.
# KIN_APP names the Kin app's folder, for testing; it defaults to /Applications/Kin.app.

set -u

for settings in "$HOME/.claude/settings.json" \
    "${CLAUDE_PROJECT_DIR:-.}/.claude/settings.json" \
    "${CLAUDE_PROJECT_DIR:-.}/.claude/settings.local.json"; do
  if [ -f "$settings" ] && grep -q 'kin-permission-hook' "$settings"; then
    exit 0
  fi
done

# The Kin app on a Mac: its own Node.js and Kin's hook, as Kin installs them.
app="${KIN_APP:-/Applications/Kin.app}"
app_node="$app/Contents/Helpers/Kin Local Servers.app/Contents/Helpers/node"
app_hook="$app/Contents/Resources/bridge/kin-permission-hook.js"
if [ -x "$app_node" ] && [ -f "$app_hook" ]; then
  exec "$app_node" "$app_hook" --for claude-code
fi

# kin-bridge: its command is dist/bin.js, with Kin's hook beside it.
bridge=$(command -v kin-bridge 2>/dev/null) || exit 0
target=$bridge
hops=0
while [ -L "$target" ] && [ "$hops" -lt 10 ]; do
  link=$(readlink "$target")
  case $link in
    /*) target=$link ;;
    *) target=$(dirname "$target")/$link ;;
  esac
  hops=$((hops + 1))
done
hook=$(dirname "$target")/kin-permission-hook.js
# npm on Windows writes kin-bridge as a small script beside node_modules, not as a link.
if [ ! -f "$hook" ]; then
  hook=$(dirname "$bridge")/node_modules/kin-bridge/dist/kin-permission-hook.js
fi
if [ -f "$hook" ] && command -v node >/dev/null 2>&1; then
  exec node "$hook" --for claude-code
fi
exit 0
