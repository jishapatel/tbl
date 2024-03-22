import 'base_config.dart';

class DevConfig implements BaseConfig {

  @override
  //String get apiHost => "https://qaapinode.bullspree.com/";
  String get apiHost => "https://api.thebeerlibrary.in/";

  @override
  bool get httpLogs => true;

  @override
  String get apiVersion => "";

}