import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ibenefit_interview_test/bloc/login_bloc.dart';
import 'package:ibenefit_interview_test/events/login_events.dart';
import 'package:ibenefit_interview_test/state/login_states.dart';
import 'package:ibenefit_interview_test/value/color.dart';
import 'package:ibenefit_interview_test/value/constants.dart';
import 'package:ibenefit_interview_test/widget/dialog.dart';
import 'package:ibenefit_interview_test/widget/func.dart';
import 'package:ibenefit_interview_test/widget/widget.dart';

class LoginScreen extends StatelessWidget {
  String text = "a";
  TextEditingController userController = new TextEditingController();
  TextEditingController passController = new TextEditingController();
  bool _showPass = true;
  bool _isUsernameErr = false;
  bool _isPasswordErr = false;
  String? _errorTextUsername = "";
  @override
  Widget build(BuildContext context) {
    LoadingDialog loadingDialog =
        LoadingDialog(buildContext: context, dismissable: false);
    userController.text = "test@ibenefit.vn";
    passController.text = "abc123456";
    return Scaffold(
      appBar: AppBar(
        backgroundColor: MyColor.primaryColor,
        title: Text(
          'Đăng nhập',
          style: TextStyle(fontSize: 22),
        ),
        actions: [
          Icon(
            Icons.menu,
          )
        ],
      ),
      body: SingleChildScrollView(
        child: BlocConsumer<LoginBloc, LoginState>(
          listener: (context, loginState) async {
            if (loginState is LoginStateLoadingRequest) {
              //loadingDialog.show();
            } else if (loginState is LoginStateLoginSuccessful) {
              //loadingDialog.dismiss();
              Navigator.of(context).popAndPushNamed("/home_screen",
                  arguments: loginState.loginResponse);
            } else if (loginState is LoginStateLoginFailure) {
              //loadingDialog.dismiss();
              if (loginState.responsePackage.code == 400) {
                AlertDialogOneBtnCustomized(
                  context: context,
                  title: "Đăng nhập thất bại",
                  desc: loginState.responsePackage.msg!,
                  textBtn: "Đăng nhập lại",
                ).show();
              } else if (loginState.responsePackage.errors ==
                  "SocketException") {
                AlertDialogOneBtnCustomized(
                  context: context,
                  title: "Mất kết nối đến máy chủ",
                  desc: "Vui lòng xem lại đường truyền internet.",
                ).show();
              } else if (loginState.responsePackage.errors ==
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
                  title: "Đăng nhập thất bại",
                  desc: "Đã xảy ra lỗi,\nvui lòng thử lại.",
                  textBtn: "Đăng nhập lại",
                ).show();
              }
            } else if (loginState is LoginStateInitial) {
              _showPass = loginState.isShow;
              _isUsernameErr = loginState.isUsernameErr;
              _isPasswordErr = loginState.isPasswordErr;
            } else if (loginState is LoginStateFormatChecking) {
              _isUsernameErr = loginState.isUsernameErr;
              _isPasswordErr = loginState.isPasswordErr;
              _errorTextUsername = loginState.errorTextUsername;
            } else if (loginState is LoginStateToggleShow) {
              _showPass = loginState.isShow;
            }
          },
          builder: (context, loginState) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 60 * SizeConfig.ratioHeight!,
                  ),
                  BannerApp(),
                  SizedBox(
                    height: 40 * SizeConfig.ratioHeight!,
                  ),
                  SizedBox(
                    height: 20 * SizeConfig.ratioHeight!,
                  ),
                  Container(
                    width: 300 * SizeConfig.ratioWidth!,
                    child: TextField(
                      controller: userController,
                      keyboardType: TextInputType.emailAddress,
                      maxLength: 20,
                      style: TextStyle(
                          fontSize: 20 * SizeConfig.ratioFont!,
                          color: Colors.black),
                      decoration: InputDecoration(
                          labelText: "Tên đăng nhập",
                          labelStyle: TextStyle(
                            color: Colors.grey[700],
                            fontSize: 20 * SizeConfig.ratioFont!,
                          ),
                          errorText: _errorTextUsername,
                          errorStyle: TextStyle(
                              color: Colors.red,
                              fontSize: 15 * SizeConfig.ratioFont!)),
                      onChanged: (text) {
                        print("Tên đăng nhập là: ${userController.text} ");
                        //Yêu cầu Bloc check dữ liệu username và password
                        BlocProvider.of<LoginBloc>(context).add(
                            LoginEventChecking(
                                username: userController.text,
                                password: passController.text));
                      },
                    ),
                  ),
                  SizedBox(height: 5 * SizeConfig.ratioHeight!),
                  Container(
                    width: 300 * SizeConfig.ratioWidth!,
                    child: Stack(
                        alignment: AlignmentDirectional.centerEnd,
                        children: [
                          TextField(
                            obscureText: _showPass,
                            controller: passController,
                            maxLength: 20,
                            style: TextStyle(
                                fontSize: 20 * SizeConfig.ratioFont!,
                                color: Colors.black),
                            decoration: InputDecoration(
                                fillColor: Colors.red,
                                labelText: "Mật khẩu",
                                labelStyle: TextStyle(
                                  color: Colors.grey[700],
                                  fontSize: 20 * SizeConfig.ratioFont!,
                                ),
                                errorText: _isPasswordErr
                                    ? "Mật khẩu phải dài hơn " +
                                        "${Constants.minLengthPassword} ký tự"
                                    : null,
                                errorStyle: TextStyle(
                                    color: Colors.red,
                                    fontSize: 15 * SizeConfig.ratioFont!)),
                            onChanged: (_) {
                              //Yêu cầu Bloc check dữ liệu username và password
                              BlocProvider.of<LoginBloc>(context).add(
                                  LoginEventChecking(
                                      username: userController.text,
                                      password: passController.text));
                            },
                          ),
                          IconButton(
                              onPressed: () {
                                BlocProvider.of<LoginBloc>(context).add(
                                    LoginEventToggleShow(isShow: _showPass));
                              },
                              icon: Icon(
                                _showPass
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                                color: MyColor.primaryColor,
                              ))
                        ]),
                  ),
                  SizedBox(
                    height: 40 * SizeConfig.ratioHeight!,
                  ),
                  CustomizedButton(
                    text: "Đăng nhập",
                    onPressed: (userController.text == "" ||
                            passController.text == "" ||
                            _isPasswordErr ||
                            _isUsernameErr ||
                            loginState is LoginStateLoadingRequest)
                        ? null
                        : () async {
                            //Code này cho bản full
                            BlocProvider.of<LoginBloc>(context).add(
                                LoginEventLoginClicked(
                                    username: userController.text,
                                    password: passController.text,
                                    timestamp: DateTime.now()));
                            // //Code này cho bản test
                          },
                  ),
                  TextButton(
                      onPressed: () {},
                      child: Text(
                        "Quên mật khẩu?",
                        style: TextStyle(fontSize: 16 * SizeConfig.ratioFont!),
                      ))
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
