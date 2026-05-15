import 'package:dart_format/src/Cli/CliArgs.dart';
import 'package:test/test.dart';

import '../TestTools/TestTools.dart';

void main()
{
    TestTools.init();

    group('CliArgs.parse', ()
        {
            test('--help sets showHelp', ()
                {
                    final CliArgs args = CliArgs.parse(<String>['--help']);

                    expect(args.showHelp, isTrue);
                    expect(args.errorMessage, isNull);
                }
            );

            test('-h sets showHelp', ()
                {
                    final CliArgs args = CliArgs.parse(<String>['-h']);

                    expect(args.showHelp, isTrue);
                }
            );

            test('--version sets showVersion', ()
                {
                    final CliArgs args = CliArgs.parse(<String>['--version']);

                    expect(args.showVersion, isTrue);
                    expect(args.errorMessage, isNull);
                }
            );

            test('-V sets showVersion', ()
                {
                    final CliArgs args = CliArgs.parse(<String>['-V']);

                    expect(args.showVersion, isTrue);
                }
            );

            test('Empty args sets isEmpty=true', ()
                {
                    final CliArgs args = CliArgs.parse(<String>[]);

                    expect(args.isEmpty, isTrue);
                }
            );

            test('Single file name is collected', ()
                {
                    final CliArgs args = CliArgs.parse(<String>['A.dart']);

                    expect(args.fileNames, equals(<String>['A.dart']));
                }
            );

            test('Multiple file names are collected in order', ()
                {
                    final CliArgs args = CliArgs.parse(<String>['A.dart', 'B.dart', 'C.dart']);

                    expect(args.fileNames, equals(<String>['A.dart', 'B.dart', 'C.dart']));
                }
            );

            test('--dry-run sets isDryRun', ()
                {
                    final CliArgs args = CliArgs.parse(<String>['--dry-run', 'A.dart']);

                    expect(args.isDryRun, isTrue);
                    expect(args.fileNames, equals(<String>['A.dart']));
                }
            );

            test('-n sets isDryRun', ()
                {
                    final CliArgs args = CliArgs.parse(<String>['-n', 'A.dart']);

                    expect(args.isDryRun, isTrue);
                }
            );

            test('-dr is rejected as unknown', ()
                {
                    final CliArgs args = CliArgs.parse(<String>['-dr', 'A.dart']);

                    expect(args.errorMessage, isNotNull);
                }
            );

            test('--config=<JSON> is collected', ()
                {
                    final CliArgs args = CliArgs.parse(<String>['--config={"K":"V"}', 'A.dart']);

                    expect(args.configText, equals('{"K":"V"}'));
                }
            );

            test('--errors-as-json sets errorsAsJson', ()
                {
                    final CliArgs args = CliArgs.parse(<String>['--errors-as-json']);

                    expect(args.errorsAsJson, isTrue);
                }
            );

            test('--pipe sets isPipe', ()
                {
                    final CliArgs args = CliArgs.parse(<String>['--pipe']);

                    expect(args.isPipe, isTrue);
                }
            );

            test('--web sets isWebService', ()
                {
                    final CliArgs args = CliArgs.parse(<String>['--web']);

                    expect(args.isWebService, isTrue);
                }
            );

            test('--webservice still sets isWebService (hidden alias)', ()
                {
                    final CliArgs args = CliArgs.parse(<String>['--webservice']);

                    expect(args.isWebService, isTrue);
                }
            );

            test('--skip-version-check sets skipVersionCheck', ()
                {
                    final CliArgs args = CliArgs.parse(<String>['--skip-version-check']);

                    expect(args.skipVersionCheck, isTrue);
                }
            );

            test('--log-to-console sets logToConsole=true', ()
                {
                    final CliArgs args = CliArgs.parse(<String>['--log-to-console']);

                    expect(args.logToConsole, isTrue);
                }
            );

            test('--log-to-console=true sets logToConsole=true', ()
                {
                    final CliArgs args = CliArgs.parse(<String>['--log-to-console=true']);

                    expect(args.logToConsole, isTrue);
                }
            );

            test('--log-to-console=false sets logToConsole=false (current bug fixed)', ()
                {
                    final CliArgs args = CliArgs.parse(<String>['--log-to-console=false']);

                    expect(args.logToConsole, isFalse);
                }
            );

            test('Unknown long flag sets errorMessage', ()
                {
                    final CliArgs args = CliArgs.parse(<String>['--unknown-flag']);

                    expect(args.errorMessage, isNotNull);
                }
            );

            test('--pipe and --web together set errorMessage', ()
                {
                    final CliArgs args = CliArgs.parse(<String>['--pipe', '--web']);

                    expect(args.errorMessage, isNotNull);
                }
            );
        }
    );
}
