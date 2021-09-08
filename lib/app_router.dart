import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:ibenefit_interview_test/bloc/init_device_bloc.dart';
import 'package:ibenefit_interview_test/bloc/logout_bloc.dart';
import 'package:ibenefit_interview_test/repo/login_repo.dart';
import 'package:ibenefit_interview_test/screens/home_screen.dart';
import 'package:ibenefit_interview_test/screens/login_screen.dart';
import 'package:ibenefit_interview_test/screens/splash_screen.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hive/hive.dart';
import 'package:ibenefit_interview_test/widget/store_device_code.dart';
import 'bloc/login_bloc.dart';

class AppRouter {
  //BasketRepository _basketRepository;
  Route onGenerateRoute(RouteSettings routeSettings) {
    // LoginRepository loginRepository = LoginRepository(httpClient: http.Client());

    LoginRepository loginRepository =
        LoginRepository(httpClient: http.Client());
    LoginBloc loginBloc = LoginBloc(
      loginRepository: loginRepository,
    );
    InitDeviceBloc initDeviceBloc = InitDeviceBloc(
      loginRepository: loginRepository,
    );
    LogoutBloc logoutBloc = LogoutBloc(loginRepository: loginRepository);
    switch (routeSettings.name) {
      case '/':
        return MaterialPageRoute(
            builder: (_) => BlocProvider<InitDeviceBloc>.value(
                  value: initDeviceBloc,
                  child: SplashScreen(),
                ));
      case '/login_screen':
        return MaterialPageRoute(
          builder: (_) => BlocProvider<LoginBloc>.value(
            value: loginBloc,
            child: LoginScreen(),
          ),
        );
      case '/home_screen':
        final args = routeSettings.arguments;
        return MaterialPageRoute(
            settings: RouteSettings(arguments: args),
            builder: (_) => BlocProvider<LogoutBloc>.value(
                  value: logoutBloc,
                  child: HomeScreen(),
                ));
      default:
        return MaterialPageRoute(
          builder: (_) => BlocProvider<LoginBloc>.value(
            value: loginBloc,
            child: LoginScreen(),
          ),
        );
    }
  }
}
