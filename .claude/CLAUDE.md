@~/.claude/coding-conventions.md
@~/.claude/dart-and-flutter-conventions.md

# dart_format

`dart_format` is a configurable Dart source-code formatter, published on pub.dev as an alternative to the built-in `dart format` / `dartfmt`. The same package powers a JetBrains plugin (IntelliJ IDEA, Android Studio) and a VS Code extension; those IDE clients talk to it over a small localhost HTTP service so a single long-running process can format many files quickly.

Three invocation modes are dispatched from `bin/dart_format.dart`:

- **File mode** (`DefaultHandler`): reads files, formats, writes back — or to `<name>.formatted.dart` with `--dry-run`.
- **Pipe mode** (`PipeHandler`): reads source from stdin, writes formatted source to stdout. Used by IDE plugins for one-off invocations.
- **Web service** (`WebServiceHandler`, `--web`): HTTP server on `127.0.0.1`, random free port by default (announced in the JSON line printed to stdout); pin a specific port with `--port=N`. `POST /format` takes a multipart body with `Config` (JSON) + `Text` (Dart source) parts. `GET /`, `/status`, `/quit`, `/favicon.ico` exist for diagnostics. Used by long-running IDE plugins to avoid repeated process startup.

## Project context

- Stability: feature-stable.
- Breaking changes: none within a major version.
- Public API surface: low priority. Direct pub.dev usage is minimal (~11 likes); real consumers are the JetBrains and VS Code plugins. Treat the **CLI flags** and **HTTP wire protocol** as the actual public API — changes to either require plugin updates in lockstep.
- Performance: web-service mode is on the IDE-plugin hot path; formatting latency is user-perceptible. Avoid adding allocations or re-parses in `FormatState` / `FormatVisitor` without measuring.

## Architecture

**The formatter is a streaming AST walker.** It re-emits the original source text token-by-token in declaration order, never re-prints from the AST alone. That's why every formatter must consume every child entity of its node — anything skipped becomes a "Missed some text" runtime error.

`lib/src/` is grouped as: `Format/` (pipeline — `Formatter`, `FormatVisitor`, `FormatState`, `FormatErrorReporter`), `Output/` (text-emission primitives — `IndentedOutput`, `StringBufferEx`), `Formatters/` (96 per-node formatters), `Handlers/` (the three CLI invocation modes), `Debug/` (dev-only helpers), plus `Cli/`, `Constants/`, `Data/`, `Enums/`, `Exceptions/`, `Text/`, `Tools/`. `test/` mirrors this layout (e.g. `test/Format/Formatter/`, `test/Output/IndentedOutput/`).

### Pipeline (`lib/src/Format/Formatter.dart`)

`Formatter.format(String source)`:

1. Strips `\r` (CRLF → LF normalization).
2. `parseString(throwIfDiagnostics: false)` — gets the AST even with diagnostics, then rejects the input if `parseResult.errors` is non-empty (so semantically invalid Dart never reaches the visitor in production).
3. Builds `FormatState` over the parse result.
4. `compilationUnit.accept(FormatVisitor)` walks the AST.
5. Post-passes via `TextTools`: collapse runs of empty lines per `maxEmptyLines`, ensure trailing newline.
6. `_verifyResult` re-parses the output as a safety net.

### Per-node dispatch (`lib/src/Format/FormatVisitor.dart`)

`FormatVisitor` extends the analyzer's `AstVisitor`. It holds one `late final` instance per node-kind formatter (~90 of them, all under `lib/src/Formatters/`) and overrides each `visitXxx` to delegate to the matching `IFormatter`. Anything without a dedicated formatter falls through to `DefaultFormatter`.

**Fall-through risk:** when upgrading the `analyzer` dependency, new AST node types in `package:analyzer/src/dart/ast/ast.dart` silently fall through to `DefaultFormatter` and may format wrong. Check the analyzer changelog for new node classes on every upgrade and add a dedicated formatter where needed.

### Per-node formatters (`lib/src/Formatters/*.dart`)

Each implements `IFormatter.format(AstNode)`. The contract: walk the node's children in the order the analyzer's `@GenerateNodeImpl(childEntitiesOrder: [...])` annotation lists (in `package:analyzer/src/dart/ast/ast.dart`), emitting each via `FormatState.copyEntity` / `acceptList` / `copySemicolon`. Tokens get copied verbatim with spacing rules; sub-AstNodes get re-visited (which recurses through `FormatVisitor`).

### State (`lib/src/Format/FormatState.dart`)

`FormatState` is the streaming text emitter. It tracks `_lastConsumedPosition` in the source buffer, owns an output `StringBufferEx` (with an indentation stack for nested levels), and is the source of the "Missed some text" exception when a formatter advances past tokens it didn't emit. All formatters share one `FormatState` per `Formatter.format` call.

### Config (`lib/src/Data/Config.dart`)

`Freezed`-generated, JSON-serializable. Every option exposes `_DEFAULT` (turned on) and `_NONE` (turned off) constants so callers can build "all-on" or "all-off" configs and override individual flags. The web service receives this as the `Config` multipart part.

### Codegen

`build_runner watch` runs in the background (per user convention — never invoke `build_runner` manually). Generated files: `*.freezed.dart` (Freezed), `*.g.dart` (json_serializable / Freezed), and `lib/src/Constants/Generated/VersionConstants.dart` (built from `pubspec.yaml`'s version). Never edit any of these by hand.

### Tests (`test/`)

`test/` mirrors `lib/src/` — one folder per class, grouped by the same subfolders.

- `test/Formatters/<Name>Formatter_test.dart` — one file per per-node formatter. Uses `TestTools.runTestGroupsForFormatter` to feed a parsed AST fragment through a single formatter and assert the output matches `inputMiddle` (or `TestConfig.expectedText`). `MetaAstVisitor` also verifies every child node the formatter visits matches an expected `TestVisitor`.
- `test/Format/Formatter/`, `test/Format/FormatVisitor/`, `test/Format/FormatState/`, `test/Format/FormatErrorReporter/` — pipeline classes.
- `test/Output/IndentedOutput/`, `test/Debug/DebugDumper/` — emission primitives and dev helpers.
- `test/Combinations/`, `test/ExplicitTests/` — end-to-end fixtures (no lib/src/ counterpart).
- `test/TestTools/AstCreator.dart` — builds AST nodes from source strings via `package:analyzer/dart/analysis/utilities.dart`; see the comment on `createCompilationUnitTolerant` for the one helper that bypasses diagnostic-rejection (only for defensive-coverage tests).

## Recurring tasks

### When adding a new per-node formatter

1. Find the AST class's `@GenerateNodeImpl(childEntitiesOrder: [...])` in the analyzer source — that's the source-order child list.
2. Create `lib/src/Formatters/<Name>Formatter.dart` extending `IFormatter`, copying each listed child in order.
3. Wire it into `FormatVisitor` (field + `visitXxx` override).
4. Add `test/Formatters/<Name>Formatter_test.dart` covering the happy path and any optional children (`?` tokens, `null`-able sub-nodes).

### When upgrading the `analyzer` dependency

1. Read the analyzer changelog for new AST node classes.
2. For each new node class, check whether `FormatVisitor` has a `visitXxx` override; if not, the node falls through to `DefaultFormatter`.
3. Add dedicated formatters per the checklist above for any new nodes that need non-default behavior.
4. Run the full test suite; failures here often surface AST shape changes.

### When debugging "Missed some text"

The current formatter advanced `FormatState._lastConsumedPosition` past tokens it didn't emit. Check the failing formatter against its analyzer `@GenerateNodeImpl(childEntitiesOrder: [...])` and confirm every listed child is being copied. Most often it's a newly-added optional token (`?` modifier, trailing comma, etc.) the formatter doesn't yet handle.

### When the CLI or HTTP wire protocol changes

Changes to CLI flags (`bin/dart_format.dart`), the `POST /format` multipart format, or any endpoint's request/response shape break the JetBrains and VS Code plugins. Update both plugins in lockstep with the package release. No "internal" justification for changes here — both surfaces are public API.