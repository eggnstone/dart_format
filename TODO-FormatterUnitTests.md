Formatter unit-test coverage
============================

One unit test file per `lib/src/Formatters/*.dart` (excluding `IFormatter.dart` which is the interface). Tests live in `test/Formatters/<Name>Formatter_test.dart` and use `TestTools.runTestGroupsForFormatter` (see `SwitchPatternCaseFormatter_test.dart` for a small template, or `ArgumentListFormatter_test.dart` for one with multiple `TestGroupConfig`s).

Each test should at minimum:
- cover the happy path (typical input)
- cover any optional/nullable children (e.g. `?` tokens, nullable sub-nodes)
- include both a `TestConfig.none()` and a default (formatting-on) config

Dead-code formatters (no test possible)
---------------------------------------

These formatters have their entire source commented out — no class exists at runtime, and the FormatVisitor either has no `visit*` method for them or routes the AST node to `DefaultFormatter` instead. They need to be implemented before any test can be written.

- AdjacentStringsFormatter — `visitAdjacentStrings` routes to `DefaultFormatter`
- AugmentationImportDirectiveFormatter — no `visit*` method in `FormatVisitor`
- CascadeExpressionFormatter — `visitCascadeExpression` routes to `DefaultFormatter`
- ForEachPartsWithDeclarationFormatter — `visitForEachPartsWithDeclaration` routes to `DefaultFormatter`
- LibraryAugmentationDirectiveFormatter — no `visit*` method in `FormatVisitor`
- StringInterpolationFormatter — `visitStringInterpolation` routes to `DefaultFormatter`
