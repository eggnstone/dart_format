# Changelog

## 2.0.0

CLI overhaul — see README for the new shape.

**Breaking changes**

- Removed `--pipe`. Stdin is now auto-detected when no positional args are given, and a bare `-` positional also reads from stdin.
- Removed `-dr` short flag. Dry-run is now `--dry-run` / `-n`.
- `--dry-run` (`-n`) no longer writes `<name>.formatted.dart` sibling files. It parses, formats in memory, and reports — no filesystem writes.
- `--webservice` is no longer advertised in help; the canonical spelling is `--web` (`--webservice` keeps working).

**New**

- Positional args accept files, directories (recursed into `*.dart`), and glob patterns (e.g. `"lib/**/*.dart"`).
- `--exclude=<GLOB>` / `-x` flag, repeatable: covers file-ending, folder, and specific-file exclusions in one mechanism.
- Default excludes applied during recursion / glob expansion: hidden directories (`.dart_tool/`, `.git/`, `.idea/`, …), `build/`, and the common codegen suffixes (`*.chopper.dart`, `*.config.dart`, `*.freezed.dart`, `*.g.dart`, `*.gen.dart`, `*.gr.dart`, `*.mocks.dart`, `*.pb*.dart`, `*.swagger.dart`). Explicit file paths bypass these.
- `--check` / `-c` mode: no writes, exits non-zero if any file would change. For CI / pre-commit.
- `--help` / `-h` and `--version` / `-V`.
- `--port=<N>` for web service mode. Without it the existing default (try 7777, fall back to a random free port) is preserved; with it the server binds to exactly that port and fails if it is taken, so scripts can rely on a known address.

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
