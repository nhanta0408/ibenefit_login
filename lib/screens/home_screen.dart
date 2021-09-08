import 'package:flutter/material.dart';
import 'package:ibenefit_interview_test/value/color.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("HomeScreen"),
        backgroundColor: MyColor.primaryColor,
      ),
      body: Center(
        child: Container(
          child: Text(
            "Đây là HomeScreen",
            style: TextStyle(fontSize: 30),
          ),
        ),
      ),
    );
  }
}
