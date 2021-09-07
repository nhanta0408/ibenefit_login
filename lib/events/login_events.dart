import 'package:equatable/equatable.dart';

abstract class LoginEvent extends Equatable {}

class LoginEventChecking extends LoginEvent {
  final String username;
  final String password;
  LoginEventChecking({required this.password, required this.username});
  @override
  List<Object> get props => [username, password];
}

class LoginEventToggleShow extends LoginEvent {
  final bool isShow;
  LoginEventToggleShow({required this.isShow});
  @override
  List<Object> get props => [isShow];
}

class LoginEventLoginClicked extends LoginEvent {
  final String username, password, deviceCode;
  final DateTime timestamp;
  LoginEventLoginClicked(
      {required this.username,
      required this.password,
      required this.deviceCode,
      required this.timestamp});
  @override
  List<Object> get props => [username, password, timestamp];
}
