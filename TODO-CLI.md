# CLI improvements — action plan

Plan for the next round of `dart_format` CLI work: folder/file/wildcard
inputs with exclusions, plus accumulated CLI-hygiene fixes that ride on the
same parser migration. Target version: **2.0.0** (placeholder `2.0.0-dev1`
already present in `pubspec.yaml:4`).

## Order of attack

Picked to minimise re-work: migrate the parser once, then build on top.

### 1. Foundation — migrate to `package:args`

- Replace the hand-rolled parser in `bin/dart_format.dart:72-144` with an
  `ArgParser`. Preserve every current flag's behaviour where not explicitly
  changed below.
- Falls out essentially for free as part of the migration:
  - `--help` / `-h`.
  - `--version` / `-V` wired to the existing
    `InfoTools.writeCopyrightToStdOut`.
  - `--log-to-console=true|false` parsed properly instead of the current
    `contains(...)` bug at `bin/dart_format.dart:16`.
- **Decided.** Advertise `--web` only; `--webservice` keeps working but is
  hidden from `--help` (IDE plugins continue to function unchanged).
- **Decided.** Drop the `-dr` short flag; the dry-run flag becomes
  `-n` / `--dry-run` — the established pair used by `make`, `rsync`, and Git.
- **Decided — behaviour change.** `-n` (formerly `--dry-run`) no longer
  writes `<name>.formatted.dart` sibling files. It just parses, formats
  in memory, and reports — no filesystem writes. The `.formatted.dart`
  output path is removed entirely from `DefaultHandler`.
- Update `README.md` for the new flag spellings.

### 2. Folder / file / wildcard inputs + exclusions

The largest chunk and the user-facing feature work.

- Positional args accept files, directories, **and** glob patterns.
- Directories recurse into `*.dart` files (matches `dart format`).
- Globs matched in-process via `package:glob` (handles cmd.exe / PowerShell
  where the shell does not expand wildcards).
- `--exclude=<glob>` flag, repeatable, short alias `-x`. Single mechanism
  covers all three exclusion shapes:
  - file ending → `--exclude="**/*.g.dart"`
  - folder location → `--exclude="**/build/**"`
  - specific file → `--exclude="lib/legacy/old.dart"`
- Built-in default excludes. Not opt-out-able in v1.
  - **Folders:** `.dart_tool/`, `build/`, and hidden directories
    (`.git/`, `.idea/`, …).
  - **Codegen suffixes (core set):** `*.g.dart`, `*.freezed.dart`,
    `*.mocks.dart` — universal across the Dart/Flutter ecosystem and pure
    generator output, so formatting them is wasted work.
  - **Codegen suffixes (extended, on by default — Decided):** `*.gr.dart`
    (auto_route), `*.config.dart` (injectable), `*.gen.dart` (flutter_gen),
    `*.chopper.dart`, `*.pb.dart` / `*.pbenum.dart` / `*.pbjson.dart` /
    `*.pbgrpc.dart` (protobuf), `*.swagger.dart`.
  - **L10n — Decided: no specific defaults.** Default `flutter gen-l10n`
    output (synthetic mode) lives in `.dart_tool/` and is already covered
    by the folder rule. Non-synthetic gen-l10n (`app_localizations*.dart`),
    `intl_translation` (`messages_*.dart`, `l10n.dart`), and similar tools
    use names that collide too easily with hand-written code to safely
    default-exclude. Project owners can pass `--exclude="lib/l10n/**"` (or
    similar) when they need it.
- **Escape hatch for default excludes:** defaults apply only when files are
  discovered via directory recursion or glob expansion. **Explicit file
  paths bypass defaults** — `dart_format lib/foo.g.dart` formats
  `foo.g.dart` even though `*.g.dart` is default-excluded. Matches
  Prettier / ESLint / Black and avoids needing an opt-out flag.
- New class `lib/src/Tools/FileResolver.dart` owns recursion, glob expansion,
  exclusion matching, dedup, and `.dart` filtering. Single public static
  method `resolve(inputs, excludes) → List<String>`.
- `bin/dart_format.dart` calls the resolver before `DefaultHandler`.
- `lib/src/Handlers/DefaultHandler.dart:16,40-55` simplifies to "accept the
  resolved list".
- `pubspec.yaml`: add `glob: ^2.x` (and `path: ^1.x` if needed).
- Update `README.md` with examples for each exclusion shape.

**Out of scope for v1:** ignore-file support (`.dart_format_ignore`,
gitignore-syntax) and an `--include` flag.

### 3. CI / pre-commit workflow

- **`--check` mode.** Keeps both `-n` and `--check`; related but distinct:
  - `-n` / `--dry-run`: no-write mode, always exits 0 (unless a parse
    error). For previewing.
  - `--check`: implies `-n` and additionally exits non-zero when any file
    would change. For CI / pre-commit. Passing `-n --check` together is
    redundant but harmless. (Black / rustfmt model.)
- **Stdin handling — Decided. `--pipe` is scrapped entirely.** Replaced by
  two standard mechanisms:
  - **Auto-detect:** when `stdin.hasTerminal` is `false` *and* no positional
    args are given, read from stdin automatically. Lets
    `cat foo.dart | dart_format` work without any flag.
  - **Explicit `-`:** a bare `-` positional means "read from stdin" (the
    cat/grep/git convention). Useful alongside other flags.
  - IDE plugins must switch from `--pipe` to one of the above. Acceptable
    because `--pipe` was introduced recently and the new mechanisms are
    industry-standard.
- Update `README.md` with `--check` and stdin usage examples.

### Output behaviour for `-n` and `--check` *(Decided: both per-file + summary)*

Black-style output:
- One line per file that would change, e.g. `would format lib/foo.dart`.
- A trailing summary line, e.g. `3 files would be reformatted, 17 left
  unchanged`.
- Applies to both `-n` and `--check`; only the exit code differs.

### 4. Papercuts — *deferred to a follow-up iteration*

Kept in the plan for tracking, not part of this round.

- `--config-file=<path>` for humans, alongside `--config=<JSON>` for IDE
  plugins. Inline JSON is painful to quote on Windows shells.
- `--port=<n>` for web service mode so scripted use doesn't have to hunt
  for the fallback random port.

## Implementation details *(decided)*

- **Exit codes** — Black-style 0/1/2:
  - `0` — success: all input formatted, or `--check` found no diffs.
  - `1` — failure: any of `--check` found unformatted files, a file failed
    to parse, or an explicit input path was not a `.dart` file.
  - `2` — usage error from argument parsing.
- **Symlinks** — followed during recursion (matches `dart format`).
- **File order** — files emitted by the resolver are sorted lexicographically
  before being processed, so per-file output is deterministic for CI logs
  and tests.
- **Non-`.dart` explicit paths** — rejected with a clear error. Today's tool
  attempts any file; this is a tightening that avoids surprising behaviour
  on `dart_format README.md`.
- **Windows path handling** — exclude globs always use forward-slash syntax
  (e.g. `**/build/**`). `FileResolver` normalises every discovered file
  path to forward-slash before matching against the exclude list, so user
  globs work identically on Windows and POSIX. (`package:glob` itself is
  forward-slash native; this is just being explicit about the contract.)

## Versioning and release notes

- Target version: **2.0.0**. `pubspec.yaml:4` already carries the placeholder
  `2.0.0-dev1`; bump to `2.0.0` at release.
- Step 1 alone introduces four breaking changes:
  1. `--pipe` removed (replaced by stdin auto-detect and `-`).
  2. `-dr` short flag removed.
  3. `--dry-run` no longer writes `<name>.formatted.dart`.
  4. `--log-to-console=false` now actually disables logging.
- `CHANGELOG.md` entry must enumerate these, plus the new features:
  `--check`, `--exclude`, `--help`, `--version`, directory recursion,
  glob support, default excludes, and `-` stdin marker.

## Verification

- **CLI parsing tests** *(new, under `test/Cli/` or alongside `bin/`):*
  - `--help` / `-h` prints help and exits 0.
  - `--version` / `-V` prints version and exits 0.
  - `--check` exits non-zero on unformatted input, 0 on clean input.
  - `-n` exits 0 on either.
  - `-x` / `--exclude` accepts repeated values.
  - Stdin auto-detect kicks in when stdin is piped and no positional args
    supplied.
  - `-` positional reads from stdin.
  - Argument-parse error exits 2.
- **`FileResolver` tests** *(new, `test/Tools/FileResolver_test.dart`):*
  - explicit file passes through;
  - directory expands to its `.dart` descendants (non-`.dart` skipped);
  - glob in a positional matches expected files;
  - `--exclude="**/*.g.dart"` strips generated files;
  - `--exclude="**/build/**"` strips a folder;
  - `--exclude="lib/x.dart"` strips a single file;
  - default excludes skip `.dart_tool/`, `build/`, hidden dirs, and the
    codegen suffixes;
  - explicit path bypasses default excludes;
  - duplicates collapse;
  - file order is sorted;
  - symlinks are followed.
- **Existing test suite** stays green after each step — the migration in
  step 1 should be behaviour-preserving except for the four documented
  breaking changes.
- **Smoke tests:**
  - `dart run bin/dart_format.dart lib test --exclude="**/*.g.dart" --exclude="**/*.freezed.dart" -n`
    produces per-file lines + summary, no filesystem writes.
  - `dart run bin/dart_format.dart --check lib` returns non-zero when a
    file is unformatted, zero otherwise.
  - `cat lib/foo.dart | dart run bin/dart_format.dart` formats and emits
    to stdout (no flag needed).
  - `dart run bin/dart_format.dart -` does the same with an explicit
    marker.

## Out of scope / fine as-is

- Mode dispatch (file mode / stdin mode / `--web`). After scrapping
  `--pipe`, stdin mode is entered via auto-detect or `-` rather than a
  flag; the conflict checks adapt accordingly.
- `--errors-as-json` for the IDE bridge.
- `--skip-version-check` as an escape hatch.
