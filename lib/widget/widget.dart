import 'package:flutter/material.dart';
import 'package:ibenefit_interview_test/value/color.dart';
import 'package:ibenefit_interview_test/value/constants.dart';

class CustomizedButton extends StatelessWidget {
  String text;
  double width, height, radius, fontSize;
  Color bgColor;
  Color fgColor;
  VoidCallback? onPressed;
  CustomizedButton(
      {this.text = "Tên nút",
      this.width = 250,
      this.height = 60,
      this.radius = 60,
      this.bgColor = MyColor.primaryColor,
      this.fgColor = Colors.white,
      this.fontSize = 27,
      this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Container(
        width: width * SizeConfig.ratioWidth!,
        height: height * SizeConfig.ratioHeight!,
        // ignore: deprecated_member_use
        child: RaisedButton(
          disabledColor: Colors.grey,
          color: bgColor,
          shape: RoundedRectangleBorder(
            borderRadius:
                BorderRadius.circular(radius * SizeConfig.ratioWidth!),
          ),
          child: Text(
            text,
            style: TextStyle(
                fontSize: fontSize * SizeConfig.ratioFont!, color: fgColor),
          ),
          onPressed: onPressed,
        ),
      ),
    );
  }
}

class CircularLoading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
              width: 60 * SizeConfig.ratioWidth!,
              height: 60 *
                  SizeConfig.ratioWidth!, //chỗ này là width để nó ra hình vuông
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(MyColor.primaryColor),
                strokeWidth: 6.0,
              )),
          SizedBox(
            height: 30 * SizeConfig.ratioHeight!,
          ),
          Text(
            "Đang tải dữ liệu",
            style: TextStyle(fontSize: 22 * SizeConfig.ratioFont!),
          ),
        ],
      ),
    );
  }
}

class BannerApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image(
            image: AssetImage('lib/assets/banner_ibenefit.png'),
            width: 200 * SizeConfig.ratioWidth!,
          ),
        ]);
  }
}
