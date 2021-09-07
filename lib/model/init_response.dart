import 'data.dart';

class InitResponse {
  bool? success;
  Data? data;
  String? msg;
  dynamic errors;
  int? code;

  InitResponse({this.success, this.data, this.msg, this.errors, this.code});

  InitResponse.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
    msg = json['msg'];
    errors = json['errors'] ?? ""; //nếu null thì gán ""
    code = json['code'];
  }
}
