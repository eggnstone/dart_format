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

## To run dart_format from the command line:
- Follow the instructions at https://pub.dev/packages/dart_format/install

```
Usage: dart_format [args]
    <dart file> [<dart file> ...]    Formats the specified dart file(s)
    --config=<config JSON>           Specifies the configuration
    --dry-run, -dr                   Writes output to "<original filename>.formatted.dart"
    --errors-as-json                 Writes errors as JSON to stderr
    --log-to-console                 Logs to console
    --pipe                           Formats stdin and writes to stdout
    --skip-version-check             Skips version check on start-up
    --web[service]                   Starts in web service mode
```
