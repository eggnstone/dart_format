import 'package:dart_format/dart_format.dart';

class TestConfig
{
    final Config config;
    final String? expectedText;
    final String? restText;
    final String name;

    TestConfig([this.expectedText, this.restText])
        : config = Config.all(), name = 'Default';

    TestConfig.none([this.expectedText, this.restText])
        : config = Config.none(), name = 'None';

    TestConfig.breakSetOrMapLiterals([this.expectedText, this.restText])
        : config = Config.all(breakSetOrMapLiterals: true), name = 'BreakSetOrMapLiterals';
}
