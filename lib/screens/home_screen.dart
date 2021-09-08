import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ibenefit_interview_test/bloc/logout_bloc.dart';
import 'package:ibenefit_interview_test/events/logout_events.dart';
import 'package:ibenefit_interview_test/model/login_response.dart';
import 'package:ibenefit_interview_test/state/logout_state.dart';
import 'package:ibenefit_interview_test/value/color.dart';
import 'package:ibenefit_interview_test/value/constants.dart';
import 'package:ibenefit_interview_test/widget/dialog.dart';
import 'package:ibenefit_interview_test/widget/store_device_code.dart';
import 'package:ibenefit_interview_test/widget/widget.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // LoadingDialog loadingDialog =
    //     LoadingDialog(buildContext: context, dismissable: false);
    final loginResponse =
        ModalRoute.of(context)!.settings.arguments as LoginResponse;
    print("User có name là: " + loginResponse.data!.user!.name!);
    return Scaffold(
        appBar: AppBar(
          title: Text("HomeScreen"),
          backgroundColor: MyColor.primaryColor,
        ),
        body: BlocConsumer<LogoutBloc, LogoutState>(
          listener: (context, logoutState) {
            if (logoutState is LogoutBlocStateLoading) {
              //loadingDialog.show();
            } else if (logoutState is LogoutBlocStateSuccessful) {
              //loadingDialog.dismiss();
              Navigator.popAndPushNamed(context, "/login_screen");
            } else {
              //loadingDialog.dismiss();
              logoutState = logoutState as LogoutBlocStateFailure;
              if (logoutState.responsePackage.errors == "SocketException") {
                AlertDialogOneBtnCustomized(
                  context: context,
                  title: "Mất kết nối đến máy chủ",
                  desc: "Vui lòng xem lại đường truyền internet.",
                ).show();
              } else if (logoutState.responsePackage.errors ==
                  "TimeoutException") {
                AlertDialogOneBtnCustomized(
                  context: context,
                  title: "Hệ thống đang gặp lỗi",
                  desc: "Vui lòng thử lại sau",
                ).show();
              } else {
                //Tránh các lỗi lạ
                AlertDialogOneBtnCustomized(
                  context: context,
                  title: "Đăng xuất thất bại",
                  desc: "Đã xảy ra lỗi,\nvui lòng thử lại.",
                  textBtn: "Đồng ý",
                ).show();
              }
            }
          },
          builder: (context, logoutState) {
            return Center(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    FittedBox(
                      child: Text(
                        "Xin chào " + loginResponse.data!.user!.name!,
                        style: TextStyle(fontSize: 30 * SizeConfig.ratioFont!),
                      ),
                    ),
                    SizedBox(height: 30 * SizeConfig.ratioHeight!),
                    CustomizedButton(
                        text: "Logout",
                        onPressed: logoutState is LogoutBlocStateLoading
                            ? null
                            : () async {
                                ScaffoldMessenger.of(context).clearSnackBars();
                                ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                        content: Text("Show Device code: " +
                                            await StoreDeivceCode
                                                .getDeviceCode())));
                                BlocProvider.of<LogoutBloc>(context)
                                    .add(LogoutEvent());
                              })
                  ]),
            );
          },
        ));
  }
}
