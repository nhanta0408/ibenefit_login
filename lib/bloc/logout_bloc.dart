import 'dart:async';
import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ibenefit_interview_test/events/logout_events.dart';
import 'package:ibenefit_interview_test/model/response_package.dart';
import 'package:ibenefit_interview_test/repo/login_repo.dart';
import 'package:ibenefit_interview_test/state/logout_state.dart';
import 'package:ibenefit_interview_test/widget/func.dart';

class LogoutBloc extends Bloc<LogoutEvent, LogoutState> {
  LoginRepository loginRepository;
  LogoutBloc({required this.loginRepository}) : super(LogoutBlocStateInitial());
  @override
  Stream<LogoutState> mapEventToState(LogoutEvent event) async* {
    yield LogoutBlocStateLoading(timestamp: DateTime.now());
    try {
      String deviceCode = await StoreDeivceCode.getDeviceCode();
      if (deviceCode != "" && deviceCode != "Error") {
        final ResponsePackage response =
            await loginRepository.logout(deviceCode);
        if (response.success!) {
          yield LogoutBlocStateSuccessful();
        } else {
          yield LogoutBlocStateFailure(responsePackage: response);
        }
      } else {
        throw Exception();
      }
    } on SocketException {
      yield LogoutBlocStateFailure(
          responsePackage: ResponsePackage(errors: "SocketException"));
    } on TimeoutException {
      yield LogoutBlocStateFailure(
          responsePackage: ResponsePackage(errors: "TimeoutException"));
    } catch (e) {
      yield LogoutBlocStateFailure(
          responsePackage: ResponsePackage(errors: "Somethings went wrong"));
    }
  }
}
