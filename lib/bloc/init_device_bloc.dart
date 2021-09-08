import 'dart:async';
import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ibenefit_interview_test/events/init_device_events.dart';
import 'package:ibenefit_interview_test/model/init_response.dart';
import 'package:ibenefit_interview_test/model/response_package.dart';
import 'package:ibenefit_interview_test/repo/login_repo.dart';
import 'package:ibenefit_interview_test/state/init_device_state.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hive/hive.dart';
import 'package:ibenefit_interview_test/widget/func.dart';

class InitDeviceBloc extends Bloc<InitDeviceRequestEvent, InitDeviceState> {
  LoginRepository loginRepository;
  InitDeviceBloc({required this.loginRepository})
      : super(InitDeviceLoadingState());

  @override
  Stream<InitDeviceState> mapEventToState(InitDeviceRequestEvent event) async* {
    if (event is InitDeviceRequestEvent) {
      //await StoreDeivceCode.openBox();
      yield InitDeviceLoadingState();
      try {
        String deviceCode = await StoreDeivceCode.getDeviceCode();
        if (deviceCode != "" && deviceCode != "Error") {
          yield InitDeviceSuccessfulState(deviceCode: deviceCode);
        } else {
          throw Exception();
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
