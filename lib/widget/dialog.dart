import 'package:flutter/material.dart';
import 'package:ibenefit_interview_test/value/color.dart';
import 'package:ibenefit_interview_test/value/constants.dart';
import 'package:ndialog/ndialog.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class AlertDialogTwoBtnCustomized {
  BuildContext context;
  String title;
  String desc;
  String textBtn1;
  String textBtn2;
  Color bgBtn1, bgBtn2, fgBtn1, fgBtn2;
  double titleFSize, descFSize;
  VoidCallback? onPressedBtn1, onPressedBtn2, closeFunction;
  AlertDialogTwoBtnCustomized({
    required this.context,
    this.title = "Nhập title",
    this.desc = "Nhập mô tả ",
    this.textBtn1 = "Đồng ý",
    this.textBtn2 = "Hủy bỏ",
    this.bgBtn1 = MyColor.primaryColor,
    this.bgBtn2 = Colors.transparent,
    this.fgBtn1 = Colors.white,
    this.fgBtn2 = MyColor.primaryColor,
    this.onPressedBtn1,
    this.onPressedBtn2,
    this.closeFunction,
    this.descFSize = 18,
    this.titleFSize = 22,
  });
  void show() {
    Alert(
            context: context,
            title: title,
            desc: desc,
            closeFunction: () {
              Navigator.of(context).pop();
              if (closeFunction != null) {
                closeFunction!();
              }
            },
            buttons: [
              DialogButton(
                height: 45 * SizeConfig.ratioHeight!,
                radius: BorderRadius.all(Radius.circular(8)),
                color: bgBtn1,
                child: Text(textBtn1,
                    style: TextStyle(
                        fontSize: 20 * SizeConfig.ratioFont!,
                        color: fgBtn1,
                        fontWeight: FontWeight.bold)),
                onPressed: () {
                  Navigator.of(context).pop();
                  if (onPressedBtn1 != null) {
                    onPressedBtn1!();
                  }
                },
              ),
              DialogButton(
                color: bgBtn2,
                child: Text(textBtn2,
                    style: TextStyle(
                        fontSize: 20 * SizeConfig.ratioFont!,
                        color: fgBtn2,
                        fontWeight: FontWeight.bold)),
                onPressed: () {
                  Navigator.of(context).pop();
                  if (onPressedBtn2 != null) {
                    onPressedBtn2!();
                  }
                },
              )
            ],
            style: AlertStyle(
                descStyle: TextStyle(
                    fontSize: descFSize * SizeConfig.ratioFont!,
                    fontWeight: FontWeight.normal,
                    height: 1.5 * SizeConfig.ratioHeight!),
                titleStyle:
                    TextStyle(fontSize: titleFSize * SizeConfig.ratioFont!)))
        .show();
  }
}

class AlertDialogOneBtnCustomized {
  BuildContext context;
  String title;
  String desc;
  String textBtn;
  Color bgBtn, fgBtn;
  double titleFSize, descFSize;
  VoidCallback? onPressedBtn;
  VoidCallback? closePressed;
  bool onWillPopActive;
  AlertDialogOneBtnCustomized(
      {required this.context,
      this.title = "Nhập title",
      this.desc = "Nhập mô tả ",
      this.textBtn = "Đồng ý",
      this.bgBtn = MyColor.primaryColor,
      this.fgBtn = Colors.white,
      this.onPressedBtn,
      this.descFSize = 18,
      this.titleFSize = 22,
      this.closePressed,
      this.onWillPopActive = true});
  void show() {
    Alert(
            onWillPopActive: onWillPopActive,
            closeFunction: () {
              if (Navigator.canPop(context)) {
                Navigator.of(context).pop();
              }
              if (closePressed != null) {
                closePressed!();
              }
            },
            context: context,
            title: title,
            desc: desc,
            buttons: [
              DialogButton(
                height: 45 * SizeConfig.ratioHeight!,
                radius: BorderRadius.all(Radius.circular(8)),
                color: bgBtn,
                child: Text(textBtn,
                    style: TextStyle(
                        fontSize: 20 * SizeConfig.ratioFont!,
                        color: fgBtn,
                        fontWeight: FontWeight.bold)),
                onPressed: () {
                  if (Navigator.canPop(context)) {
                    Navigator.of(context).pop();
                  }
                  if (onPressedBtn != null) {
                    onPressedBtn!();
                  }
                },
              ),
            ],
            style: AlertStyle(
                descStyle: TextStyle(
                    fontSize: descFSize * SizeConfig.ratioFont!,
                    fontWeight: FontWeight.normal),
                titleStyle:
                    TextStyle(fontSize: titleFSize * SizeConfig.ratioFont!)))
        .show();
  }
}

///Class này không dùng, thay thế bằng LoadingDialog

class LoadingDialog {
  BuildContext buildContext;
  bool
      dismissable; //để khi nhấn ra ngoài thì ko bị dismiss tự động, cái này đôi khi cần, đôi khi ko cần
  ProgressDialog? progressDialog;
  LoadingDialog({required this.buildContext, this.dismissable = true}) {
    progressDialog = ProgressDialog(
      buildContext,
      title: SizedBox(
        width: 0,
        height: 0,
      ),
      message: Padding(
        padding: EdgeInsets.all(5),
        child: Text(
          "Đang tải dữ liệu",
          style: TextStyle(fontSize: 20 * SizeConfig.ratioFont!),
        ),
      ),
      dismissable: dismissable,
      defaultLoadingWidget: Container(
          //Do dialog ko có kích thước, nên dùng chính Container để chỉnh kích thước cho Dialog và padding để ép size Circular
          padding: EdgeInsets.all(15),
          width: 60 * SizeConfig.ratioRadius!,
          height: 60 * SizeConfig.ratioRadius!,
          child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(MyColor.primaryColor),
              strokeWidth: 3)),
    );
  }
  void show() {
    progressDialog!.show();
  }

  void dismiss() {
    progressDialog!.dismiss();
  }
}
