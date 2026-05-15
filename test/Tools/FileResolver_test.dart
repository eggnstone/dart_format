import 'dart:io';

import 'package:dart_format/src/Exceptions/DartFormatException.dart';
import 'package:dart_format/src/Tools/FileResolver.dart';
import 'package:test/test.dart';

import '../TestTools/TestTools.dart';

void main()
{
    TestTools.init();

    group('FileResolver.resolve', ()
        {
            test('Explicit .dart file passes through', ()
                {
                    final String root = _setupTempTree(<String, String>
                        {
                            'A.dart': ''
                        }
                    );

                    final List<String> resolved = FileResolver.resolve(inputs: <String>['$root/A.dart']);

                    expect(resolved, equals(<String>['$root/A.dart']));
                }
            );

            test('Directory expands to its .dart descendants and skips non-dart files', ()
                {
                    final String root = _setupTempTree(<String, String>
                        {
                            'A.dart': '',
                            'B.dart': '',
                            'C.txt': '',
                            'sub/D.dart': '',
                            'sub/E.md': ''
                        }
                    );

                    final List<String> resolved = FileResolver.resolve(inputs: <String>[root]);

                    expect(resolved, equals(<String>['$root/A.dart', '$root/B.dart', '$root/sub/D.dart']));
                }
            );

            test('Glob in a positional matches expected files', ()
                {
                    final String root = _setupTempTree(<String, String>
                        {
                            'lib/A.dart': '',
                            'lib/B.dart': '',
                            'test/C.dart': ''
                        }
                    );

                    final List<String> resolved = FileResolver.resolve(inputs: <String>['$root/lib/*.dart']);

                    expect(resolved, equals(<String>['$root/lib/A.dart', '$root/lib/B.dart']));
                }
            );

            test('--exclude="**/*.g.dart" strips generated files during directory recursion', ()
                {
                    final String root = _setupTempTree(<String, String>
                        {
                            'A.dart': '',
                            'B.g.dart': '',
                            'sub/C.dart': '',
                            'sub/D.g.dart': ''
                        }
                    );

                    final List<String> resolved = FileResolver.resolve(
                        inputs: <String>[root],
                        userExcludes: <String>['**/*.g.dart']
                    );

                    expect(resolved, equals(<String>['$root/A.dart', '$root/sub/C.dart']));
                }
            );

            test('--exclude="**/build/**" strips a folder', ()
                {
                    final String root = _setupTempTree(<String, String>
                        {
                            'A.dart': '',
                            'build/B.dart': '',
                            'build/sub/C.dart': ''
                        }
                    );

                    final List<String> resolved = FileResolver.resolve(inputs: <String>[root]);

                    expect(resolved, equals(<String>['$root/A.dart']));
                }
            );

            test('--exclude=<file> strips a single explicit file path', ()
                {
                    final String root = _setupTempTree(<String, String>
                        {
                            'A.dart': '',
                            'B.dart': '',
                            'C.dart': ''
                        }
                    );

                    final List<String> resolved = FileResolver.resolve(
                        inputs: <String>[root],
                        userExcludes: <String>['**/B.dart']
                    );

                    expect(resolved, equals(<String>['$root/A.dart', '$root/C.dart']));
                }
            );

            test('Default excludes skip .dart_tool/, build/, and hidden dirs', ()
                {
                    final String root = _setupTempTree(<String, String>
                        {
                            'A.dart': '',
                            '.dart_tool/B.dart': '',
                            'build/C.dart': '',
                            '.git/D.dart': '',
                            '.idea/E.dart': ''
                        }
                    );

                    final List<String> resolved = FileResolver.resolve(inputs: <String>[root]);

                    expect(resolved, equals(<String>['$root/A.dart']));
                }
            );

            test('Default excludes skip codegen suffixes (core)', ()
                {
                    final String root = _setupTempTree(<String, String>
                        {
                            'A.dart': '',
                            'B.g.dart': '',
                            'C.freezed.dart': '',
                            'D.mocks.dart': ''
                        }
                    );

                    final List<String> resolved = FileResolver.resolve(inputs: <String>[root]);

                    expect(resolved, equals(<String>['$root/A.dart']));
                }
            );

            test('Default excludes skip codegen suffixes (extended)', ()
                {
                    final String root = _setupTempTree(<String, String>
                        {
                            'A.dart': '',
                            'B.gr.dart': '',
                            'C.config.dart': '',
                            'D.gen.dart': '',
                            'E.chopper.dart': '',
                            'F.pb.dart': '',
                            'G.pbenum.dart': '',
                            'H.pbjson.dart': '',
                            'I.pbgrpc.dart': '',
                            'J.swagger.dart': ''
                        }
                    );

                    final List<String> resolved = FileResolver.resolve(inputs: <String>[root]);

                    expect(resolved, equals(<String>['$root/A.dart']));
                }
            );

            test('Explicit path bypasses default excludes', ()
                {
                    final String root = _setupTempTree(<String, String>
                        {
                            'A.g.dart': ''
                        }
                    );

                    final List<String> resolved = FileResolver.resolve(inputs: <String>['$root/A.g.dart']);

                    expect(resolved, equals(<String>['$root/A.g.dart']));
                }
            );

            test('Explicit path still honours user excludes', ()
                {
                    final String root = _setupTempTree(<String, String>
                        {
                            'A.dart': ''
                        }
                    );

                    final List<String> resolved = FileResolver.resolve(
                        inputs: <String>['$root/A.dart'],
                        userExcludes: <String>['**/A.dart']
                    );

                    expect(resolved, isEmpty);
                }
            );

            test('Duplicates collapse when matched via multiple inputs', ()
                {
                    final String root = _setupTempTree(<String, String>
                        {
                            'A.dart': ''
                        }
                    );

                    final List<String> resolved = FileResolver.resolve(inputs: <String>[root, '$root/A.dart']);

                    expect(resolved, equals(<String>['$root/A.dart']));
                }
            );

            test('Results are sorted lexicographically', ()
                {
                    final String root = _setupTempTree(<String, String>
                        {
                            'C.dart': '',
                            'A.dart': '',
                            'B.dart': ''
                        }
                    );

                    final List<String> resolved = FileResolver.resolve(inputs: <String>[root]);

                    expect(resolved, equals(<String>['$root/A.dart', '$root/B.dart', '$root/C.dart']));
                }
            );

            test('Non-.dart explicit path is rejected with DartFormatException', ()
                {
                    final String root = _setupTempTree(<String, String>
                        {
                            'A.txt': ''
                        }
                    );

                    expect(() => FileResolver.resolve(inputs: <String>['$root/A.txt']),
                        throwsA(isA<DartFormatException>()));
                }
            );

            test('Non-existent path is rejected with DartFormatException', ()
                {
                    expect(() => FileResolver.resolve(inputs: <String>['/no/such/path/A.dart']),
                        throwsA(isA<DartFormatException>()));
                }
            );

            test('Dot input "." picks up .dart files (not falsely excluded as hidden dirs)', ()
                {
                    final String root = _setupTempTree(<String, String>
                        {
                            'lib/A.dart': '',
                            'test/B.dart': ''
                        }
                    );

                    final Directory previousCwd = Directory.current;
                    Directory.current = root;
                    addTearDown(() => Directory.current = previousCwd);

                    final List<String> resolved = FileResolver.resolve(inputs: <String>['.']);

                    expect(resolved.length, equals(2));
                    expect(resolved.any((String p) => p.endsWith('lib/A.dart')), isTrue);
                    expect(resolved.any((String p) => p.endsWith('test/B.dart')), isTrue);
                }
            );

            test('All paths in result use forward slashes', ()
                {
                    final String root = _setupTempTree(<String, String>
                        {
                            'sub/A.dart': ''
                        }
                    );

                    final List<String> resolved = FileResolver.resolve(inputs: <String>[root]);

                    for (final String path in resolved)
                        expect(path.contains(r'\'), isFalse, reason: 'Path should not contain backslash: $path');
                }
            );
        }
    );
}

String _setupTempTree(Map<String, String> files)
{
    final Directory tempDir = Directory.systemTemp.createTempSync('dart_format_resolver_test_');
    addTearDown(()
        {
            if (tempDir.existsSync())
                tempDir.deleteSync(recursive: true);
        }
    );

    for (final MapEntry<String, String> entry in files.entries)
    {
        final File f = File('${tempDir.path}/${entry.key}');
        f.parent.createSync(recursive: true);
        f.writeAsStringSync(entry.value);
    }

    return tempDir.path.replaceAll(r'\', '/');
}
