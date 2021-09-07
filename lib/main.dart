import 'package:flutter/material.dart';
import 'package:ibenefit_interview_test/app_router.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final AppRouter _appRouter = AppRouter();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      onGenerateRoute: _appRouter.onGenerateRoute,
      title: 'Flutter Demo',
    );
  }
}
