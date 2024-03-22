class Token {
  static String? token;
}

///Error code
class HttpCode {
  ///Unknown network error
  static const UNKNOWN_NET_ERROR = 10086;

  ///Network Error
  static const NETWORK_ERROR = -1001;

  ///network timeout
  static const CONNECT_TIMEOUT = -1002;
  static const SEND_TIMEOUT = -1003;
  static const RECEIVE_TIMEOUT = -1004;

  ///Request to cancel
  static const REQUEST_CANCEL = -1005;

  ///JSON parsing exception
  static const PARSE_JSON_ERROR = -1006;

  ///Successful code
  static const SUCCESS = 200;

  ///Timeout duration
  static const TIME_OUT = 25000;
}

enum Method { GET, POST, PUT, DELETE, PATCH }