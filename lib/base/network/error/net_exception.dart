/// Network abnormality
class NetWorkException implements Exception {
  int? code;
  String? message;

  NetWorkException(this.code, this.message);

  @override
  String toString() {
    return 'Network  exception {code: $code , message: $message}';
  }
}