import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hive/hive.dart';
import 'package:ibenefit_interview_test/app_router.dart';
import 'package:ibenefit_interview_test/widget/store_device_code.dart';

void main() async {
  await Hive.initFlutter();
  await StoreDeivceCode.openBox();
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
