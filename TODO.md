TODO
====
- Error "Missed some text" does not fully carry over to the plugin when the text contains "<" or ">"
  - e.g. <DartFormatException>.
  - e.g. offset < lastConsumedPosition
- Integration tests for indentation=-1
- Integration tests for maxEmptyLines
- maxEmptyLines can only work when removeLeadingWhitespace does not already remove all empty lines.
- Block comments: keep indentation
- Own lint rule: don't return Futures in a try-catch block.
- Own lint rule: don't call unawaited stuff in a try-catch block.
- Own lint rule: don't return Future<void>s.
- Indent interpolations?
- Force line break after if/else/...
- Add/remove spaces
- Fix too big block indentation after "if () // comment\n"
- Spaces: "a . b"
- Do not remove trailing commas from end-of-line comments
- Force empty line between methods
- Option to sort imports
- Option to sort methods

DONE
====
- Ensure DEBUG is off when publishing (PublishPackageToPubDev.ps1 now refuses to publish if any DEBUG flag in Constants.dart is left on).
- else\nif
- Safety: WebServiceHandler now catches `Error` (UnimplementedError, StateError, …) in both `_handlePostFormat` and `_handleRequest` so a thrown Error returns `X-DartFormat-Result: Fail` (or HTTP 500) instead of letting the plugin write an empty/half-built body to the user's file.
- No blank lines after `{` and before `}` (TextTools.tidyBlankLines, gated on maxEmptyLines >= 0).
- No blank lines at the start of the file (TextTools.tidyBlankLines).
- No blank lines at the end of the file, just the trailing newline (TextTools.tidyBlankLines).
- Tests for FormalParameterListFormatter and ArgumentListFormatter covering preservation/removal of trailing comma (single-line and multi-line, both `removeTrailingCommas=true` and `false`).
- Multi-line layout not supported (no `pushLevel`) for: `RecordLiteral`, `RecordTypeAnnotation`, `RecordTypeAnnotationNamedFields`, `TypeArgumentList` (and `RecordPattern`, part of issue #11). Elements no longer end up at column 0; closing bracket sits at outer level.
- `TypeParameterList`: closing `>` is incorrectly indented when the list spans multiple lines.
- Add space after `=` in factory redirect: `factory C() =_C;` → `factory C() = _C;` (analog of the `=` fix in `ConstructorFieldInitializer`).
- Add space after `,` in `VariableDeclarationList` (e.g. `var a=0,b=1` → `var a=0, b=1`).
- Method params: indent when multiline with "(" and "({"
- WebService: Shut down if calling process dies.
- Quit doesn't work anymore
- Simplify TestAstVisitor
- Don't add line break between "}" and ";"
- Don't add line break between "}" and ","
- Indent assignments when multiline
- Important: Undetected change from "€" to "?". Maybe change of encoding? Is this the cause for the problem undetectable changes, too?
- Indent triple quoted strings
- favicon.ico does not work when called from plugin.
- Keep "{}" if it doesn't contain line breaks.
- Indent "((){});" if contains line breaks.
