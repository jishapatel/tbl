import 'base_config.dart';

class StagingConfig implements BaseConfig {
  @override
  String get apiHost => "https://api.thebeerlibrary.in/";

  @override
  bool get httpLogs => true;

  @override
  String get apiVersion => "";

}