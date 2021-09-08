import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ibenefit_interview_test/bloc/init_device_bloc.dart';
import 'package:ibenefit_interview_test/events/init_device_events.dart';
import 'package:ibenefit_interview_test/state/init_device_state.dart';
import 'package:ibenefit_interview_test/value/color.dart';
import 'package:ibenefit_interview_test/value/constants.dart';
import 'package:ibenefit_interview_test/widget/dialog.dart';
import 'package:ibenefit_interview_test/widget/store_device_code.dart';

class SplashScreen extends StatelessWidget {
  SplashScreen();
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    BlocProvider.of<InitDeviceBloc>(context).add(InitDeviceRequestEvent());
    return BlocConsumer<InitDeviceBloc, InitDeviceState>(
        listener: (context, initDeviceState) async {
      if (initDeviceState is InitDeviceSuccessfulState) {
        //Phần xử lí nằm trong Bloc
        //Phần này chỉ hiển thị snackbar về device code
        ScaffoldMessenger.of(context).clearSnackBars();
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(
                "Show Device code: " + await StoreDeivceCode.getDeviceCode())));
        Navigator.popAndPushNamed(context, '/login_screen');
      } else if (initDeviceState is InitDeviceFailedState) {
        if (initDeviceState.responsePackage.errors == "SocketException") {
          AlertDialogOneBtnCustomized(
                  context: context,
                  title: "Mất kết nối internet",
                  desc: "Vui lòng kết nối và thử lại")
              .show();
        } else if (initDeviceState.responsePackage.errors ==
            "TimeoutException") {
          AlertDialogOneBtnCustomized(
                  context: context,
                  title: "Không phản hồi",
                  desc: "Vui lòng thử lại")
              .show();
        } else {
          AlertDialogOneBtnCustomized(
                  context: context,
                  title: "Đã có lỗi xảy ra",
                  desc: initDeviceState.responsePackage.msg!)
              .show();
        }
      }
    }, builder: (context, initDeviceState) {
      if (initDeviceState is InitDeviceLoadingState) {
        return Container(
          color: MyColor.primaryColor,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image(
                image: AssetImage('lib/assets/iBenefit_white_banner.png'),
                width: 300 * SizeConfig.ratioWidth!,
              ),
              SizedBox(
                height: 80 * SizeConfig.ratioWidth!,
              ),
              CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                strokeWidth: 2.0,
              ),
              SizedBox(
                height: 20 * SizeConfig.ratioWidth!,
              )
            ],
          ),
        );
      } else {
        return Container();
      }
    });
  }
}
