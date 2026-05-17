# Changelog

## 2.2.1

...

## 2.2.0

Security pass on the web service used by the IDE plugins. No plugin changes needed.

**CLI**

- `--check-version` opt-in; CLI no longer hits the network by default.
- `--log-to-temp-file` is a real flag (off by default).
- Directory recursion and globs skip symlinks.
- `--config-file` requires `.json`/`.dart_format` and ≤ 1 MiB.
- Web mode binds a random free port by default; pin with `--port=N`.

**Web service**

- Startup JSON adds structured fields (`Protocol`, `Address`, `Port`, `ProcessId`, `LogFilePath`, `LogFileName`); `Message` kept for back-compat.
- Rejects oversize POSTs, non-loopback `Host`, and requests over 60 s. Format-time budget covers every phase.
- Internal errors no longer echo `e.toString()` over the wire; the full stack stays in the local log.
- Stale `dart_format_*.log` files in the system temp directory are deleted on startup after 30 days.

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
