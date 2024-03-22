import 'base_config.dart';

class ProdConfig implements BaseConfig {
  @override
  String get apiHost => "https://api.thebeerlibrary.in/";

  @override
  bool get httpLogs => false;

  @override
  String get apiVersion => "";

}