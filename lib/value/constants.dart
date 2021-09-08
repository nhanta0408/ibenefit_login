import 'dart:math';

import 'package:flutter/material.dart';

class Constants {
  ///Số ký tự tối thiểu cho username
  static const int minLengthUsername = 3;

  ///Số ký tự tối thiểu cho password
  static const int minLengthPassword = 6;

  ///URL dùng để lấy device code
  static const String urlInitDevice = "http://a.vipn.net/api/device/init";

  ///URL dùng để lấy login
  static const String urlLogin = "http://a.vipn.net/api/auth/login";

  ///URL dùng để logout
  static const String urlLogout = "http://a.vipn.net/api/auth/logout";

  static const Duration timeOutLimitation = Duration(seconds: 10);
  static const Duration timeOutCache =
      Duration(minutes: 2); //để 1 để test cho nhanh
}

class SizeConfig {
  static MediaQueryData? _mediaQueryData;

  ///Logical pixel của chiều ngang điện thoại đang chạy ứng dụng
  static double? screenWidth;

  ///Logical pixel của chiều dọc điện thoại đang chạy ứng dụng
  static double? screenHeight;

  ///Logical pixel của chiều ngang điện thoại tham chiếu Redmi Note 8 tự tạo
  static double screenWidthSample = 360.0;

  ///Logical pixel của chiều dọc điện thoại tham chiếu Redmi Note 8 tự tạo
  static double screenHeightSample = 732.0;

  ///Tỉ lệ chiều ngang của điện thoại chạy ứng dụng/điện thoại tham chiếu
  static double? ratioWidth;

  ///Tỉ lệ chiều dọc của điện thoại chạy ứng dụng/điện thoại tham chiếu
  static double? ratioHeight;

  static double? ratioFont;
  static double? ratioRadius;

  ///Hàm chạy để khởi tạo các giá trị tỉ lệ, dùng trong trang đầu tiên của ứng dụng
  void init(BuildContext context) {
    _mediaQueryData = MediaQuery.of(context);
    screenWidth = _mediaQueryData!.size.width;
    screenHeight = _mediaQueryData!.size.height;
    print("Screen Width là: " + screenWidth.toString());
    print("Screen Height là: " + screenHeight.toString());
    ratioWidth = screenWidth! / screenWidthSample;
    ratioHeight = screenHeight! / screenHeightSample;
    ratioFont = min(ratioWidth!, ratioHeight!);
    ratioRadius = ratioFont;
    print("Ratio widht và height là: " +
        ratioWidth.toString() +
        "  " +
        ratioHeight.toString());
    print("Screen Height là: " + screenHeight.toString());
  }
}
