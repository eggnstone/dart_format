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
    --config=<JSON>                  Specifies the configuration
    --dry-run, -n                    Formats in memory only; reports would-format files; no filesystem writes
    --errors-as-json                 Writes errors as JSON to stderr
    --exclude=<GLOB>, -x <GLOB>      Excludes files matching the glob (repeatable)
    --help, -h                       Prints this help and exits
    --log-to-console[=true|false]    Logs to console
    --port=<N>                       Port for web service mode (default: 7777, fallback random)
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

# Dry-run: list which files would change without writing anything
dart_format lib -n

# Check mode for CI / pre-commit: same as -n but exits non-zero if any file would change
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
