import 'base_config.dart';
import 'environment.dart';

class StagingConfig implements BaseConfig {
  String get type => Environment.STAGING;

  String get apiHost => "https://dev.wizoria.ua/wizapi";

  bool get reportErrors => true;

  bool get trackEvents => true;

  bool get useHttps => true;
}
