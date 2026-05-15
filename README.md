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
Usage: dart_format [args]
    <dart file> [<dart file> ...]    Formats the specified dart file(s)
    --config=<JSON>                  Specifies the configuration
    --dry-run, -n                    Formats in memory only; reports would-format files; no filesystem writes
    --errors-as-json                 Writes errors as JSON to stderr
    --help, -h                       Prints this help and exits
    --log-to-console[=true|false]    Logs to console
    --pipe                           Formats stdin (UTF-8) and writes to stdout
    --skip-version-check             Skips version check on start-up
    --version, -V                    Prints the version and exits
    --web                            Starts in web service mode
```
