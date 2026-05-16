# dart_format

[![Build](https://github.com/eggnstone/dart_format/actions/workflows/dart.yaml/badge.svg)](https://github.com/eggnstone/dart_format/actions)
[![pub package](https://img.shields.io/pub/v/dart_format.svg)](https://pub.dartlang.org/packages/dart_format)
[![GitHub Issues](https://img.shields.io/github/issues/eggnstone/dart_format.svg)](https://github.com/eggnstone/dart_format/issues)
[![GitHub Stars](https://img.shields.io/github/stars/eggnstone/dart_format.svg)](https://github.com/eggnstone/dart_format/stargazers)

## A formatter for Dart.

Like dartfmt.  
But better ;)  
Because it's configurable.

Also available as a plugin for Jetbrains (Android Studio, IntelliJ IDEA, ...)  
https://plugins.jetbrains.com/plugin/21003-dartformat  
Also available as an extension for Visual Studio Code  
https://marketplace.visualstudio.com/items?itemName=eggnstone.DartFormat

## To run dart_format from the command line:
- Follow the instructions at https://pub.dev/packages/dart_format/install

```
Usage: dart_format [args] <file|dir|glob> [<file|dir|glob> ...]
    Positional inputs may be files, directories (recursed into *.dart),
    or glob patterns (e.g. "lib/**/*.dart").
    Pass `-` (or pipe stdin with no positional args) to format stdin to stdout.
    --check, -c                      No writes; exits non-zero if any file would change (for CI)
    --check-version                  Checks pub.dev for a newer dart_format release on start-up
    --config=<JSON>                  Inline configuration JSON (mutually exclusive with --config-file)
    --config-file=<PATH>             Path to a JSON config file (mutually exclusive with --config)
    --errors-as-json                 Writes errors as JSON to stderr
    --exclude=<GLOB>, -x <GLOB>      Excludes files matching the glob (repeatable)
    --help, -h                       Prints this help and exits
    --log-to-console[=true|false]    Logs to console
    --log-to-temp-file[=true|false]  Logs to a file in the system temp directory
    --port=<N>                       Port for web service mode (default: random free port, announced on stdout)
    --skip-version-check             Skips version check on start-up
    --version, -V                    Prints the version and exits
    --web                            Starts in web service mode
```

### Examples

```sh
# Format a single file
dart_format lib/main.dart

# Format every .dart file under lib/ and test/ recursively
dart_format lib test

# Use a glob (handy on Windows where the shell does not expand wildcards)
dart_format "lib/**/*.dart"

# Exclude by file ending (repeatable)
dart_format lib --exclude="**/*.g.dart" --exclude="**/*.freezed.dart"

# Exclude a folder
dart_format lib --exclude="**/legacy/**"

# Exclude a specific file
dart_format lib --exclude="lib/generated_code.dart"

# Check mode (for CI / pre-commit, or just a no-write preview): exits non-zero if any file would change
dart_format --check lib

# Format stdin to stdout (pipe auto-detected when no positional args are given)
cat lib/main.dart | dart_format

# Same, but with an explicit `-` positional marker
dart_format - < lib/main.dart
```

### Default excludes

The following are always skipped during directory recursion and glob
expansion. Pass an explicit file path to format one of them on purpose.

- Folders: `.dart_tool/`, `build/`, and any hidden directory (`.git/`, `.idea/`, …).
- Codegen suffixes: `*.chopper.dart`, `*.config.dart`, `*.freezed.dart`,
  `*.g.dart`, `*.gen.dart`, `*.gr.dart`, `*.mocks.dart`, `*.pb*.dart`,
  `*.swagger.dart`.

## Security model

dart_format is designed for use on a single-user development machine. If
that matches your environment, the defaults are fine. The notes below
cover the cases where it doesn't.

- **Web mode** (`--web`, used by the IDE plugins) binds only to
  `127.0.0.1` and isn't authenticated. Anything running on the same
  machine — including other local user accounts on a multi-seat box —
  can talk to your formatter. The service can't read your files; it can
  only format text the caller sends it. Don't expose it beyond loopback.
- **Browser hardening** (2.2.0): the service rejects requests whose
  Host header isn't a loopback name, caps POST bodies at 4 MiB, and
  enforces a 60 s per-request wall-clock. That blocks the obvious
  DNS-rebinding and OOM-by-CSRF tricks a visited web page could play
  against `127.0.0.1`.
- **Temp logging**: in web mode, dart_format writes a session log to the
  system temp directory (filenames it touched, errors). Rotates at
  10 MiB. Old files (`dart_format_*.log*`) are deleted on startup once
  they're 30+ days old. Disable with `--log-to-temp-file=false`. CLI
  modes don't log unless `--log-to-temp-file` is passed.
- **Snapshot trust**: dart_format is installed via `dart pub global
  activate`, which stores a compiled snapshot under `~/.pub-cache/`.
  Anyone who can write to that directory can replace the binary. Same
  caveat as every other pub-installed CLI.
