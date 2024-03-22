import 'base_config.dart';

class StagingConfig implements BaseConfig {
  @override
  String get apiHost => "https://api.thebeerlibrary.in/";
  //String get apiHost => "https://qaapinode.bullspree.com/";

  @override
  bool get httpLogs => true;

  @override
  String get apiVersion => "";

}