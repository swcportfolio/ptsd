
import 'package:vempire_app/data/rest_response.dart';

class BodyDefault{
  String code;
  String message;
  String data;

  BodyDefault({required this.code, required this.message, required this.data});

  factory BodyDefault.fromJson(RestResponseDefault responseBody){
    return BodyDefault(
      code    : responseBody.status['code'] as String ?? '-',
      message : responseBody.status['message'] as String ?? '-',
      data    : responseBody.data as String ?? '-'
    );
  }

  @override
  String toString() {
    return 'DefaultStatus{code: $code, message: $message}';
  }
}

/// When you only need status
class DefaultStatus{
  String? code;
  String? message;

  DefaultStatus({this.code, this.message});

  factory DefaultStatus.fromJson(RestResponseStatus responseBody){
    return DefaultStatus(
      code    : responseBody.status['code'] ,
      message : responseBody.status['message'],
    );
  }

  @override
  String toString() {
    return 'DefaultStatus{code: $code, message: $message}';
  }
}