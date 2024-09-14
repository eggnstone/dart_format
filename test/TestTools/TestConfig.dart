
import 'package:dart_format/src/Data/Config.dart';

class TestConfig
{
    final Config config;
    final String? expectedText;
    final String? restText;
    final String name;

    TestConfig([this.expectedText, this.restText])
        : config = Config.experimental(), name = 'Default';

    TestConfig.custom(this.name, this.config, [this.expectedText, this.restText]);

    TestConfig.none([this.expectedText, this.restText])
        : config = Config.none(), name = 'None';
}
