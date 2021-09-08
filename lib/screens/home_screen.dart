import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ibenefit_interview_test/bloc/logout_bloc.dart';
import 'package:ibenefit_interview_test/events/logout_events.dart';
import 'package:ibenefit_interview_test/state/logout_state.dart';
import 'package:ibenefit_interview_test/value/color.dart';
import 'package:ibenefit_interview_test/value/constants.dart';
import 'package:ibenefit_interview_test/widget/dialog.dart';
import 'package:ibenefit_interview_test/widget/widget.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    LoadingDialog loadingDialog =
        LoadingDialog(buildContext: context, dismissable: false);
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
                    Text(
                      "Đây là HomeScreen",
                      style: TextStyle(fontSize: 30),
                    ),
                    SizedBox(height: 30 * SizeConfig.ratioHeight!),
                    CustomizedButton(
                        text: "Logout",
                        onPressed: logoutState is LogoutBlocStateLoading
                            ? null
                            : () {
                                BlocProvider.of<LogoutBloc>(context)
                                    .add(LogoutEvent());
                              })
                  ]),
            );
          },
        ));
  }
}
