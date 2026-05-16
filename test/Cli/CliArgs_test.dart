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

            test('--dry-run is no longer accepted', ()
                {
                    final CliArgs args = CliArgs.parse(<String>['--dry-run', 'A.dart']);

                    expect(args.errorMessage, isNotNull);
                }
            );

            test('-n is no longer accepted', ()
                {
                    final CliArgs args = CliArgs.parse(<String>['-n', 'A.dart']);

                    expect(args.errorMessage, isNotNull);
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

            test('--pipe is no longer accepted', ()
                {
                    final CliArgs args = CliArgs.parse(<String>['--pipe']);

                    expect(args.errorMessage, isNotNull);
                }
            );

            test('--check sets isCheck', ()
                {
                    final CliArgs args = CliArgs.parse(<String>['--check', 'A.dart']);

                    expect(args.isCheck, isTrue);
                }
            );

            test('-c is the short alias for --check', ()
                {
                    final CliArgs args = CliArgs.parse(<String>['-c', 'A.dart']);

                    expect(args.isCheck, isTrue);
                }
            );

            test('Bare `-` is preserved as a positional (stdin marker)', ()
                {
                    final CliArgs args = CliArgs.parse(<String>['-']);

                    expect(args.fileNames, equals(<String>['-']));
                    expect(args.errorMessage, isNull);
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

            test('--check-version sets checkVersion', ()
                {
                    final CliArgs args = CliArgs.parse(<String>['--check-version']);

                    expect(args.checkVersion, isTrue);
                    expect(args.errorMessage, isNull);
                }
            );

            test('Without --check-version checkVersion defaults to false', ()
                {
                    final CliArgs args = CliArgs.parse(<String>['A.dart']);

                    expect(args.checkVersion, isFalse);
                }
            );

            test('Unknown long options are silently dropped (forward-compat)', ()
                {
                    final CliArgs args = CliArgs.parse(<String>['--future-flag', '--web']);

                    expect(args.errorMessage, isNull);
                    expect(args.isWebService, isTrue);
                }
            );

            test('Unknown long option with =value form is silently dropped', ()
                {
                    final CliArgs args = CliArgs.parse(<String>['--future-flag=v', '--web']);

                    expect(args.errorMessage, isNull);
                    expect(args.isWebService, isTrue);
                }
            );

            test('--log-to-temp-file sets logToTempFile', ()
                {
                    final CliArgs args = CliArgs.parse(<String>['--log-to-temp-file']);

                    expect(args.logToTempFile, isTrue);
                    expect(args.errorMessage, isNull);
                }
            );

            test('--log-to-temp-file=true sets logToTempFile', ()
                {
                    final CliArgs args = CliArgs.parse(<String>['--log-to-temp-file=true']);

                    expect(args.logToTempFile, isTrue);
                }
            );

            test('--log-to-temp-file=false sets logToTempFile=false', ()
                {
                    final CliArgs args = CliArgs.parse(<String>['--log-to-temp-file=false']);

                    expect(args.logToTempFile, isFalse);
                }
            );

            test('--no-log-to-temp-file sets logToTempFile=false', ()
                {
                    final CliArgs args = CliArgs.parse(<String>['--no-log-to-temp-file']);

                    expect(args.logToTempFile, isFalse);
                }
            );

            test('Without --log-to-temp-file logToTempFile defaults to false', ()
                {
                    final CliArgs args = CliArgs.parse(<String>['A.dart']);

                    expect(args.logToTempFile, isFalse);
                }
            );

            test('--port=70000 is rejected', ()
                {
                    final CliArgs args = CliArgs.parse(<String>['--port=70000']);

                    expect(args.errorMessage, isNotNull);
                }
            );

            test('--port=-1 is rejected', ()
                {
                    final CliArgs args = CliArgs.parse(<String>['--port=-1']);

                    expect(args.errorMessage, isNotNull);
                }
            );

            test('--port=65535 is accepted', ()
                {
                    final CliArgs args = CliArgs.parse(<String>['--port=65535']);

                    expect(args.errorMessage, isNull);
                    expect(args.port, 65535);
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

            test('Unknown long flag is silently dropped (forward-compat with newer plugins)', ()
                {
                    final CliArgs args = CliArgs.parse(<String>['--unknown-flag']);

                    expect(args.errorMessage, isNull);
                }
            );

            test('--exclude collects a single value', ()
                {
                    final CliArgs args = CliArgs.parse(<String>['--exclude=**/*.g.dart', 'A.dart']);

                    expect(args.excludes, equals(<String>['**/*.g.dart']));
                }
            );

            test('--exclude repeats and collects in order', ()
                {
                    final CliArgs args = CliArgs.parse(<String>['--exclude=**/*.g.dart', '--exclude=**/build/**', 'A.dart']);

                    expect(args.excludes, equals(<String>['**/*.g.dart', '**/build/**']));
                }
            );

            test('-x is the short alias for --exclude', ()
                {
                    final CliArgs args = CliArgs.parse(<String>['-x', '**/*.g.dart', 'A.dart']);

                    expect(args.excludes, equals(<String>['**/*.g.dart']));
                }
            );

            test('No --exclude leaves excludes empty', ()
                {
                    final CliArgs args = CliArgs.parse(<String>['A.dart']);

                    expect(args.excludes, isEmpty);
                }
            );

            test('--port=<n> sets port', ()
                {
                    final CliArgs args = CliArgs.parse(<String>['--web', '--port=8080']);

                    expect(args.port, equals(8080));
                }
            );

            test('--port with non-integer value is rejected', ()
                {
                    final CliArgs args = CliArgs.parse(<String>['--web', '--port=N']);

                    expect(args.errorMessage, isNotNull);
                }
            );

            test('No --port leaves port null (server picks)', ()
                {
                    final CliArgs args = CliArgs.parse(<String>['--web']);

                    expect(args.port, isNull);
                }
            );

            test('--config-file=<path> sets configFile', ()
                {
                    final CliArgs args = CliArgs.parse(<String>['--config-file=cfg.json', 'A.dart']);

                    expect(args.configFile, equals('cfg.json'));
                }
            );

            test('No --config-file leaves configFile null', ()
                {
                    final CliArgs args = CliArgs.parse(<String>['A.dart']);

                    expect(args.configFile, isNull);
                }
            );

            test('--config and --config-file together set errorMessage', ()
                {
                    final CliArgs args = CliArgs.parse(<String>['--config={"K":"V"}', '--config-file=cfg.json']);

                    expect(args.errorMessage, isNotNull);
                }
            );
        }
    );
}
