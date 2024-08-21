
import 'package:dart_format/src/Data/Config.dart';

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
}
