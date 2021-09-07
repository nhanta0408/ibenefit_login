class LoginRequest {
  String email;
  String password;

  LoginRequest({required this.email, required this.password});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> loginRequestJson = new Map<String, dynamic>();
    loginRequestJson['email'] = this.email;
    loginRequestJson['password'] = this.password;
    return loginRequestJson;
  }
}
