import 'base_config.dart';
import 'environment.dart';

class LocalConfig implements BaseConfig {
  String get type => Environment.LOCAL;

  String get apiHost => "localhost";

  bool get reportErrors => true;

  bool get trackEvents => true;

  bool get useHttps => false;
}
