import 'dart:async';
import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ibenefit_interview_test/events/init_device_events.dart';
import 'package:ibenefit_interview_test/model/response_package.dart';
import 'package:ibenefit_interview_test/repo/login_repo.dart';
import 'package:ibenefit_interview_test/state/init_device_state.dart';
import 'package:ibenefit_interview_test/widget/store_device_code.dart';

class InitDeviceBloc extends Bloc<InitDeviceRequestEvent, InitDeviceState> {
  LoginRepository loginRepository;
  InitDeviceBloc({required this.loginRepository})
      : super(InitDeviceLoadingState());

  @override
  Stream<InitDeviceState> mapEventToState(InitDeviceRequestEvent event) async* {
    if (event is InitDeviceRequestEvent) {
      ///chỉ có 1 sự kiện duy nhất
      yield InitDeviceLoadingState();
      try {
        //Lấy code từ cache, trong hàm này tự check hạn của cache
        String deviceCode = await StoreDeivceCode.getDeviceCode();
        if (deviceCode != "" && deviceCode != "Error") {
          yield InitDeviceSuccessfulState(deviceCode: deviceCode);
        } else {
          //throw thì bên dưới sẽ catch và xử lí
          throw Exception();
        }
      } on SocketException {
        //Mát kết nối
        yield InitDeviceFailedState(
            responsePackage: ResponsePackage(errors: "SocketException"));
      } on TimeoutException {
        //timeout
        yield InitDeviceFailedState(
            responsePackage: ResponsePackage(errors: "TimeoutException"));
      } catch (e) {
        yield InitDeviceFailedState(
            responsePackage: ResponsePackage(
                errors: "Somethings went wrong", msg: e.toString()));
      }
    }
  }
}
