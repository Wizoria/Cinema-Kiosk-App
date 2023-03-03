import 'prod_config.dart';
import 'staging_config.dart';

import 'base_config.dart';
import 'local_config.dart';

class Environment {
  static Environment? _environment;

  Environment._internal();
  factory Environment() {
    _environment ??= Environment._internal();
    return _environment!;
  }

  static const String LOCAL = 'LOCAL';
  static const String STAGING = 'STAGING';
  static const String PROD = 'PROD';

  BaseConfig config = LocalConfig();

  initConfig(String environment) {
    config = _getConfig(environment);
  }

  BaseConfig _getConfig(String environment) {
    switch (environment) {
      case Environment.PROD:
        return ProdConfig();
      case Environment.STAGING:
        return StagingConfig();
      default:
        return LocalConfig();
    }
  }
}
