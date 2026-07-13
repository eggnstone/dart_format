# ProjectSync

The contract between this repo and `/project-sync`. One per repo — never one per package.

## Settings

| Key | Value | Notes |
|---|---|---|
| `visibility` | `public` | GitHub `eggnstone/dart_format` + published on pub.dev. **Every file here is read by strangers**: no local paths, no personal or business context, no prose referencing private config. The `@~/.claude/…` import lines are fine — they are directives, not narrative. |
| `asyncGitMode` | `ignored` | **Mandatory for a public repo.** Committing `.async/` would publish raw thought-dumps. `.gitignore` ignores the whole folder, not just `state.json`. Consequence: async state does NOT sync PC↔laptop here — that is the correct trade. |
| `projectType` | `dart-package` | CLI + web service. `example/` is a second package but is not developed against. |
| `packages` | `.` (dart) | `example/` excluded. |

## Deviations

- **The `eggnstone_conventions_v12` plugin is NOT wired here — and must not be.**
  It is a path dependency pointing *outside* the repo
  (`../../pub.local/eggnstone_conventions/…`). That path exists only on the
  owner's machine, so committing it into a **public** repo would (a) leak the
  local directory layout and (b) break the analyzer for anyone who clones the
  repo without that sibling structure. Public repos therefore get lints but no
  structural convention gating.

  **The real fix is to publish `eggnstone_conventions` to pub.dev** and depend on
  it as a normal hosted dev_dependency — then it works everywhere and this
  deviation disappears. Until then, run `/tidy` here manually.

- **No `.async/`.** See `asyncGitMode` above. If one is ever created, it stays
  ignored.
