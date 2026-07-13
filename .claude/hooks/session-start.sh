#!/bin/bash
# SessionStart hook for Claude Code on the web. Managed by /project-sync.
#
# A fresh cloud container has no Dart/Flutter toolchain and an empty ~/.claude,
# so this does three things:
#   1. Wires the sibling `Claude` config repo into ~/.claude, so every
#      `@~/.claude/…` import in a CLAUDE.md actually resolves. Without this the
#      imports dangle SILENTLY and the session runs with no conventions at all.
#   2. Bridges the eggnstone_conventions analyzer plugin, whose path in
#      analysis_options.yaml is relative to the owner's local disk layout.
#   3. Installs Flutter and warms the pub caches + codegen.
#
# Web only: on a local checkout CLAUDE_CODE_REMOTE is unset and this exits
# immediately — a developer's machine already has all of the above.
#
# Repos arrive as SIBLINGS (selected in the web repo-picker), so everything here
# is derived from $CLAUDE_PROJECT_DIR's parent. Nothing is hardcoded.
set -euo pipefail

if [ "${CLAUDE_CODE_REMOTE:-}" != "true" ]; then
  exit 0
fi

PROJECT_DIR="${CLAUDE_PROJECT_DIR:-$(cd "$(dirname "${BASH_SOURCE[0]}")/../.." && pwd)}"
SIBLINGS="$(dirname "$PROJECT_DIR")"
FLUTTER_DIR="${FLUTTER_HOME:-$HOME/flutter}"

# ---------------------------------------------------------------------------
# 1. Global Claude config — link the sibling `Claude` repo into ~/.claude.
#    Link FILE BY FILE, never the directory: the harness owns ~/.claude and keeps
#    its own state there, so replacing the dir would clobber it. Existing files
#    are left alone (ln -sfn only where the target is absent or already a link).
# ---------------------------------------------------------------------------
CLAUDE_REPO=""
for candidate in "$SIBLINGS/Claude" "$SIBLINGS/claude"; do
  [ -f "$candidate/CLAUDE.md" ] && CLAUDE_REPO="$candidate" && break
done

if [ -n "$CLAUDE_REPO" ]; then
  mkdir -p "$HOME/.claude/commands"
  # Link a file only if the target is absent, or is itself a stale symlink.
  # A real file already there is the harness's — leave it.
  link_file()
  {
    local src="$1" target="$2"
    [ -f "$src" ] || return 0
    if [ -e "$target" ] && [ ! -L "$target" ]; then
      return 0
    fi
    ln -sfn "$src" "$target"
  }

  for f in "$CLAUDE_REPO"/*.md; do
    link_file "$f" "$HOME/.claude/$(basename "$f")"
  done
  for f in "$CLAUDE_REPO"/commands/*.md; do
    link_file "$f" "$HOME/.claude/commands/$(basename "$f")"
  done
  if [ -d "$CLAUDE_REPO/templates" ] && [ ! -e "$HOME/.claude/templates" ]; then
    ln -sfn "$CLAUDE_REPO/templates" "$HOME/.claude/templates"
  fi
  echo "SessionStart: global Claude config linked from $CLAUDE_REPO"
else
  echo "SessionStart: WARNING — no sibling 'Claude' repo found." >&2
  echo "  Every '@~/.claude/…' import in this project's CLAUDE.md will resolve to" >&2
  echo "  NOTHING and the session runs without conventions. Add the Claude repo in" >&2
  echo "  the repo picker and restart the session." >&2
fi

# ---------------------------------------------------------------------------
# 2. eggnstone_conventions analyzer plugin. analysis_options.yaml points at
#    ../../…/Packages/pub.local/eggnstone_conventions (the owner's layout);
#    recreate that from the co-checked-out repo. Best-effort — analyze degrades
#    without it, but tests still run.
# ---------------------------------------------------------------------------
CONV_DIR="$SIBLINGS/eggnstone_conventions"
PKG_LOCAL="$(dirname "$SIBLINGS")/Packages/pub.local"
if [ -d "$CONV_DIR/eggnstone_conventions_v12" ]; then
  mkdir -p "$PKG_LOCAL"
  ln -sfn "$CONV_DIR" "$PKG_LOCAL/eggnstone_conventions"
  dart pub get --directory "$CONV_DIR/eggnstone_conventions_v12" || true
  echo "SessionStart: conventions plugin bridged"
fi

# ---------------------------------------------------------------------------
# 3. Flutter SDK — idempotent. The container is cached after the hook completes,
#    so a later session reuses the install instead of re-cloning.
# ---------------------------------------------------------------------------
if command -v flutter >/dev/null 2>&1; then
  FLUTTER_BIN="$(dirname "$(command -v flutter)")"
elif [ -x "$FLUTTER_DIR/bin/flutter" ]; then
  FLUTTER_BIN="$FLUTTER_DIR/bin"
else
  echo "SessionStart: installing Flutter (stable) into $FLUTTER_DIR ..."
  git clone --depth 1 -b stable https://github.com/flutter/flutter.git "$FLUTTER_DIR"
  FLUTTER_BIN="$FLUTTER_DIR/bin"
fi
export PATH="$FLUTTER_BIN:$PATH"
echo "export PATH=\"$FLUTTER_BIN:\$PATH\"" >> "$CLAUDE_ENV_FILE"

# Bootstrap the bundled Dart SDK + host artifacts (downloaded on first run).
flutter --version >/dev/null

# ---------------------------------------------------------------------------
# 4. Warm pub caches + regenerate codegen, so analyze/test are ready. Codegen
#    failure is logged but never aborts session start.
#    The package list at the bottom is filled in by /project-sync: one
#    `warm_package <dir> <dart|flutter>` line per package in this repo, deepest
#    dependency first. A single-package repo gets exactly one line.
#    (Do NOT write the placeholder token anywhere else in this file — the
#     substitution is a plain textual replace and would hit the comment too.)
# ---------------------------------------------------------------------------
warm_package()
{
  local dir="$1" kind="$2"
  [ -f "$dir/pubspec.yaml" ] || return 0

  if [ "$kind" = "flutter" ]; then
    ( cd "$dir" && flutter pub get )
  else
    dart pub get --directory "$dir"
  fi

  if grep -q "build_runner" "$dir/pubspec.yaml"; then
    ( cd "$dir" && dart run build_runner build --delete-conflicting-outputs ) \
      || echo "codegen non-fatal failure in $dir"
  fi
}

warm_package "$PROJECT_DIR" dart

echo "SessionStart: ready."
