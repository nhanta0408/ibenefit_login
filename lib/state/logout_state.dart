import 'package:equatable/equatable.dart';
import 'package:ibenefit_interview_test/model/response_package.dart';

abstract class LogoutState extends Equatable {}

class LogoutBlocStateInitial extends LogoutState {
  @override
  List<Object?> get props => [];
}

class LogoutBlocStateLoading extends LogoutState {
  final DateTime timestamp;
  LogoutBlocStateLoading({required this.timestamp});
  @override
  List<Object?> get props => [timestamp];
}

class LogoutBlocStateSuccessful extends LogoutState {
  @override
  List<Object?> get props => [];
}

class LogoutBlocStateFailure extends LogoutState {
  ResponsePackage responsePackage;
  LogoutBlocStateFailure({required this.responsePackage});
  @override
  List<Object?> get props => [];
}
