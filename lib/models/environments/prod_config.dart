import 'base_config.dart';
import 'environment.dart';

class ProdConfig implements BaseConfig {
  String get type => Environment.PROD;

  String get apiHost => "https://wizoria.ua/wizapi-v2";

  bool get reportErrors => true;

  bool get trackEvents => true;

  bool get useHttps => true;
}
