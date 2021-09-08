import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:ibenefit_interview_test/model/init_response.dart';
import 'package:ibenefit_interview_test/model/login_response.dart';
import 'package:ibenefit_interview_test/model/response_package.dart';
import 'package:ibenefit_interview_test/value/constants.dart';

class LoginRepository {
  final http.Client httpClient;
  LoginRepository({required this.httpClient});
  //Lấy device code từ API
  Future initDevice() async {
    Map<String, String> headers = {"Content-type": "application/json"};
    Map<String, dynamic> body = {
      "userName": 2,
    };
    final response = await this
        .httpClient
        .post(Uri.parse(Constants.urlInitDevice),
            headers: headers, body: jsonEncode(body))
        .timeout(Constants.timeOutLimitation);
    final json = jsonDecode(response.body);
    if (response.statusCode == 200) {
      InitResponse initResponse = InitResponse.fromJson(json);
      return initResponse;
    } else {
      return ResponsePackage.fromJson(json);
    }
  }

  //Đăng nhập
  Future loginRequest(
      String userName, String password, String deviceCode) async {
    Map<String, String> headers = {
      "Content-type": "application/json",
      "DEVICE-CODE": deviceCode
    };
    Map<String, String> body = {"email": "$userName", "password": "$password"};
    final response = await this
        .httpClient
        .post(Uri.parse(Constants.urlLogin),
            headers: headers, body: jsonEncode(body))
        .timeout(Constants.timeOutLimitation);
    final json = jsonDecode(response.body);
    final bool isSuccess = json["success"] as bool;
    if (isSuccess) {
      LoginResponse loginResponse = LoginResponse.fromJson(json);
      return loginResponse;
    } else {
      return ResponsePackage.fromJson(json);
    }
  }

  //Đăng xuất
  Future logout(String deviceCode) async {
    Map<String, String> headers = {
      "Content-type": "application/json",
      "DEVICE-CODE": deviceCode
    };
    final response = await this
        .httpClient
        .get(Uri.parse(Constants.urlLogout), headers: headers)
        .timeout(Constants.timeOutLimitation);
    final json = jsonDecode(response.body);

    return ResponsePackage.fromJson(json);
  }
}
