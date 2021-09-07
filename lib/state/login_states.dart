import 'package:equatable/equatable.dart';
import 'package:ibenefit_interview_test/model/login_response.dart';
import 'package:ibenefit_interview_test/model/response_package.dart';

abstract class LoginState extends Equatable {}

class LoginStateFormatChecking extends LoginState {
  final bool isUsernameErr;
  final bool isPasswordErr;
  final String? errorTextUsername;
  LoginStateFormatChecking(
      {this.isPasswordErr = false,
      this.isUsernameErr = false,
      this.errorTextUsername});
  @override
  List<Object> get props => [isUsernameErr, isPasswordErr];
}

class LoginStateToggleShow extends LoginState {
  final bool isShow;
  LoginStateToggleShow({this.isShow = false});
  @override
  List<Object> get props => [isShow];
}

class LoginStateInitial extends LoginState {
  final bool isUsernameErr;
  final bool isPasswordErr;
  final bool isShow;
  LoginStateInitial(
      {required this.isUsernameErr,
      required this.isPasswordErr,
      required this.isShow});
  @override
  List<Object> get props => [isUsernameErr, isPasswordErr, isShow];
}

class LoginStateLoadingRequest extends LoginState {
  LoginStateLoadingRequest();
  @override
  List<Object> get props => [];
}

class LoginStateLoginSuccessful extends LoginState {
  final DateTime timestamp;
  final LoginResponse loginResponse;
  LoginStateLoginSuccessful(
      {required this.timestamp, required this.loginResponse});
  @override
  List<Object> get props => [timestamp];
}

class LoginStateLoginFailure extends LoginState {
  final DateTime timestamp;
  final ResponsePackage responsePackage;
  LoginStateLoginFailure(
      {required this.timestamp, required this.responsePackage});
  @override
  List<Object> get props => [timestamp];
}
