import 'dart:async';
import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ibenefit_interview_test/events/init_device_events.dart';
import 'package:ibenefit_interview_test/model/init_response.dart';
import 'package:ibenefit_interview_test/model/response_package.dart';
import 'package:ibenefit_interview_test/repo/login_repo.dart';
import 'package:ibenefit_interview_test/state/init_device_state.dart';

class InitDeviceBloc extends Bloc<InitDeviceRequestEvent, InitDeviceState> {
  LoginRepository loginRepository;
  InitDeviceBloc({required this.loginRepository})
      : super(InitDeviceLoadingState());

  @override
  Stream<InitDeviceState> mapEventToState(InitDeviceRequestEvent event) async* {
    if (event is InitDeviceRequestEvent) {
      yield InitDeviceLoadingState();
      try {
        final response = await loginRepository.initDevice();
        if (response is InitResponse) {
          print("Load DeviceCode thành công: " + response.data!.deviceCode!);
          yield InitDeviceSuccessfulState(
              deviceCode: response.data!.deviceCode!);
        } else if (response is ResponsePackage) {
          yield InitDeviceFailedState(responsePackage: response);
        }
      } on SocketException {
        yield InitDeviceFailedState(
            responsePackage: ResponsePackage(errors: "SocketException"));
      } on TimeoutException {
        yield InitDeviceFailedState(
            responsePackage: ResponsePackage(errors: "TimeoutException"));
      } catch (e) {
        yield InitDeviceFailedState(
            responsePackage: ResponsePackage(errors: "Somethings went wrong"));
      }
    }
  }
}
