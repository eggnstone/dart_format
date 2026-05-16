# Changelog

## 2.2.0

Security pass on the web service used by the IDE plugins. No plugin changes required to keep working.

**CLI behaviour changes**

- `--check-version` is the new opt-in for the pub.dev release check. CLI invocations no longer hit the network by default. `--skip-version-check` still works. Web mode (= IDE plugins) is unchanged.
- `--log-to-temp-file` is a real flag now (defaults off, accepts `=true`/`=false`). CLI invocations no longer write a log file unless asked. Web mode still force-logs so the IDE plugins can surface the log path.
- Unknown long options are silently dropped with a stderr warning — forward-compat so a future IDE plugin can pass a flag this binary doesn't know yet without bringing the service down. Previously-removed options (`--dry-run`, `--pipe`) and unknown short options still error explicitly.
- Directory recursion no longer descends into symlinked subdirectories, and glob matches that hit a symlink directly are skipped. Prevents accidentally formatting files outside the target tree.
- `--config-file` now requires a `.json` or `.dart_format` suffix and rejects anything larger than 1 MiB. Stops a typo / wrong-path from silently reading a huge unrelated file.
- Web mode no longer tries port 7777 first — it binds a random free port. The port is announced on stdout as before (`{"StatusCode":200,…,"Message":"http://127.0.0.1:NNNN"}`). Pin with `--port=N` if you need a predictable address (e.g. for `curl 127.0.0.1:N/status` or a restart script).

**Web service hardening**

- Rejects oversize POSTs (>4 MiB or no `Content-Length`), non-loopback `Host` headers, and any request that exceeds 60 s wall-clock — instead of OOMing, accepting cross-origin browser traffic, or hanging.
- The format-time budget now applies to every phase (parse, visit, tidy, verify), not just the visit pass.
- Unexpected internal errors (anything that isn't a `DartFormatException`) no longer echo `e.toString()` back over the wire. The wire response is a generic "see the dart_format log" message; the full stack trace stays in the local temp log. Real format errors with line/column info are unaffected.
- Log file rotates at 10 MiB into a sibling `.old` file. A long-running web service is now capped at roughly 20 MiB of log per session instead of growing forever.
- Old `dart_format_*.log` / `.log.old` files in the system temp directory are deleted on startup once they're 30+ days old. Stops a slow accumulation of leftover logs over months of use.

## 2.1.0

- Preserved input line endings when formatting: CRLF stays CRLF, LF stays LF. Previously every run rewrote files to LF-only, leaving git on Windows perpetually warning about renormalisation.
- ~12 % faster on real-world Dart sources.

## 2.0.0

CLI overhaul — see README for the new shape.

**Breaking changes**

- Removed `--pipe`. Stdin is now auto-detected when no positional args are given, and a bare `-` positional also reads from stdin.
- Removed `--dry-run` / `-n` (and the old `-dr`). Use `--check` / `-c` for a no-write preview; CI gets the non-zero exit on diffs for free.
- The previous `--dry-run` behaviour of writing `<name>.formatted.dart` sibling files is gone entirely (no replacement; sibling-file output is not coming back).
- `--webservice` is no longer advertised in help; the canonical spelling is `--web` (`--webservice` keeps working).
- Exit codes are now Black-style 0/1/2: `0` success, `1` failure (parse error, `--check` diff, missing path), `2` usage error. The previous `ERROR = 9` and `SUCCESS_AND_NEW_VERSION_AVAILABLE = -1` are gone — a newer-version notice prints to stdout but no longer changes the exit code.

**New**

- Positional args accept files, directories (recursed into `*.dart`), and glob patterns (e.g. `"lib/**/*.dart"`).
- `--exclude=<GLOB>` / `-x` flag, repeatable: covers file-ending, folder, and specific-file exclusions in one mechanism.
- Default excludes applied during recursion / glob expansion: hidden directories (`.dart_tool/`, `.git/`, `.idea/`, …), `build/`, and the common codegen suffixes (`*.chopper.dart`, `*.config.dart`, `*.freezed.dart`, `*.g.dart`, `*.gen.dart`, `*.gr.dart`, `*.mocks.dart`, `*.pb*.dart`, `*.swagger.dart`). Explicit file paths bypass these.
- `--check` / `-c` mode: no writes, exits non-zero if any file would change. For CI / pre-commit.
- `--help` / `-h` and `--version` / `-V`.
- `--port=<N>` for web service mode. Without it the existing default (try 7777, fall back to a random free port) is preserved; with it the server binds to exactly that port and fails if it is taken, so scripts can rely on a known address.
- `--config-file=<PATH>` to read config JSON from a file. Mutually exclusive with `--config=<JSON>` (the inline form, which stays for the IDE plugins). Easier on shells that fight you over inline JSON quoting.
- Partial config JSON is now accepted — missing fields fall back to defaults. Previously a `{}` or any subset would throw `Null is not a subtype of bool`.

## 1.10.0

- Many indentation fixes for multi-line code (#11, #12).
- Many spacing fixes.
- No blank lines at file edges or adjacent to `{` / `}`.
- More AST coverage (patterns, native bodies, `is` / `as`).

## 1.9.0

- Updated analyzer to 12.1.0.
- Fixed pipe-mode for non-ASCII input.
- Indent / spacing / crash fixes across `augment`, `covariant`, native clauses, type parameters, trailing comments, single-line closures.

## 1.8.0

- Updated analyzer to 10.1.0.

## 1.7.0

- Updated analyzer to 10.0.0.

## 1.6.1

- Updated analyzer to 8.4.0.

## 1.5.0

- Updated analyzer to 8.0.0.

## 1.4.2

- Fixed NullAwareElements.

## 1.4.1

- Updated analyzer to 7.4.0.

## 1.4.0

- Added "Fix spaces" to official config.

## 1.3.3

- Improved fixing of spaces.

## 1.3.0

- Updated analyzer to 7.0.0.

## 1.2.1

- Updated analyzer to 6.9.0.

## 1.2.0

- Added experimental setting "Fix spaces".
 
## 1.1.21

- Better formatting of strings and comments.
 
## 1.1.20

- Many improvements and bug fixes.
 
## 1.1.18

- Adjusted to extended AstVisitor.
 
## 1.1.17

- Improved documentation.
 
## 1.1.14

- Fixed problem with comments.
 
## 1.1.13

- Fixed JSON via web service: empty JSON means default JSON.
 
## 1.1.12

- Fixed JSON config via command line not working.
 
## 1.1.11

- Added default formatter.

## 1.1.8

- Added example. Improved documentation.

## 1.1.6

- Added version check.

## 1.1.4

- Added version to initial JSON reply.

## 1.1.0

- Added "Remove Trailing Commas".

## 1.0.0

- Initial version.
