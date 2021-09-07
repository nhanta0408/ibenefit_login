import 'dart:async';
import 'dart:io';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ibenefit_interview_test/events/login_events.dart';
import 'package:ibenefit_interview_test/model/login_response.dart';
import 'package:ibenefit_interview_test/model/response_package.dart';
import 'package:ibenefit_interview_test/repo/login_repo.dart';
import 'package:ibenefit_interview_test/state/login_states.dart';
import 'package:ibenefit_interview_test/value/constants.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginRepository loginRepository;
  LoginBloc({required this.loginRepository})
      : super(LoginStateInitial(
          isUsernameErr: false,
          isPasswordErr: false,
          isShow: true,
        ));
  @override
  Stream<LoginState> mapEventToState(LoginEvent loginEvent) async* {
    if (loginEvent is LoginEventChecking) {
      bool _isUsernameErr = true, _isPasswordErr = true;
      String? errorTextUsername = null;
      _isUsernameErr =
          loginEvent.username.length < Constants.minLengthUsername ||
              !loginEvent.username.contains("@");
      _isPasswordErr = loginEvent.password.length < Constants.minLengthPassword;
      if (_isUsernameErr) {
        errorTextUsername = !loginEvent.username.contains("@")
            ? "Email không hợp lệ"
            : "Tên đăng nhập phải dài hơn " +
                "${Constants.minLengthUsername} ký tự";
      }
      yield LoginStateFormatChecking(
          isUsernameErr: _isUsernameErr,
          isPasswordErr: _isPasswordErr,
          errorTextUsername: errorTextUsername);
    } else if (loginEvent is LoginEventToggleShow) {
      bool newIsShow = !loginEvent.isShow;
      yield LoginStateToggleShow(isShow: newIsShow);
    } else if (loginEvent is LoginEventLoginClicked) {
      yield LoginStateLoadingRequest();
      try {
        final response = await loginRepository.loginRequest(
            loginEvent.username, loginEvent.password, loginEvent.deviceCode);
        if (response is LoginResponse) {
          yield LoginStateLoginSuccessful(
              timestamp: loginEvent.timestamp, loginResponse: response);
        } else if (response is ResponsePackage) {
          yield LoginStateLoginFailure(
              timestamp: loginEvent.timestamp, responsePackage: response);
        }
      } on SocketException {
        yield LoginStateLoginFailure(
            timestamp: loginEvent.timestamp,
            responsePackage: ResponsePackage(errors: "SocketException"));
      } on TimeoutException {
        yield LoginStateLoginFailure(
            timestamp: loginEvent.timestamp,
            responsePackage: ResponsePackage(errors: "TimeoutException"));
      } catch (e) {
        yield LoginStateLoginFailure(
            timestamp: loginEvent.timestamp,
            responsePackage: ResponsePackage(errors: "Somethings went wrong"));
      }
    }
  }
}
