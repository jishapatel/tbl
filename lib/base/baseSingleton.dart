
import 'package:tbl/base/remote/model/home_response.dart';

class MySingleton {
  static final MySingleton _singleton = MySingleton._internal();

  factory MySingleton() {
    return _singleton;
  }

  MySingleton._internal();

  //final String constantData = "Your constant data here";
  HomeResponse? homeResponse;
//BehaviorSubject<HomeResponse>? home = BehaviorSubject<HomeResponse>();
}
