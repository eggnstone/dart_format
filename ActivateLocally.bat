@echo off
del /q .dart_tool\pub\bin\dart_format\dart_format.dart-*.snapshot 2>nul
call dart pub upgrade
call dart pub global activate --source path . --overwrite
