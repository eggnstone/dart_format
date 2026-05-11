@echo off
del /q .dart_tool\pub\bin\dart_format\dart_format.dart-*.snapshot 2>nul
dart pub upgrade
dart pub global activate --source path . --overwrite
