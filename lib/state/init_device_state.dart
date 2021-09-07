import 'package:equatable/equatable.dart';
import 'package:ibenefit_interview_test/model/response_package.dart';

abstract class InitDeviceState extends Equatable {}

class InitDeviceLoadingState extends InitDeviceState {
  @override
  List<Object?> get props => [];
}

class InitDeviceSuccessfulState extends InitDeviceState {
  final String deviceCode;
  InitDeviceSuccessfulState({required this.deviceCode});
  @override
  List<Object?> get props => [deviceCode];
}

class InitDeviceFailedState extends InitDeviceState {
  final ResponsePackage responsePackage;
  InitDeviceFailedState({required this.responsePackage});
  @override
  List<Object?> get props => [responsePackage];
}
