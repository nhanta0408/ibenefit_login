class ResponsePackage {
  bool? success;
  dynamic data;
  String? msg;
  dynamic errors;
  int? code;

  ResponsePackage({this.success, this.data, this.msg, this.errors, this.code});

  ResponsePackage.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    data = json['data'];
    msg = json['msg'];
    errors = json['errors'];
    code = json['code'];
  }
}
