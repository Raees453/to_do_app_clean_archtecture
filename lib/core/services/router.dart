import 'package:flutter/cupertino.dart';
import 'package:to_do_app/src/auth/presentation/views/login_screen.dart';
import 'package:to_do_app/src/auth/presentation/views/signup_screen.dart';
import 'package:to_do_app/src/home/presentation/views/home_screen.dart';

import '../../src/home/presentation/views/create_task_screen.dart';

Route<dynamic> onGenerateRoute(RouteSettings settings) {
  switch (settings.name) {
    case SignupScreen.routeName:
      return _pageBuilder((_) => const SignupScreen());
    case LoginScreen.routeName:
      return _pageBuilder((_) => const LoginScreen());
    case HomeScreen.routeName:
      return _pageBuilder((_) => const HomeScreen());
    case CreateTaskScreen.routeName:
      return _pageBuilder((_) => const CreateTaskScreen());

    default:
      return _pageBuilder((_) => const LoginScreen());
  }
}

Route<dynamic> _pageBuilder(Widget Function(BuildContext) pageBuilder) {
  return PageRouteBuilder(
    pageBuilder: (_, __, ___) => pageBuilder(_),
  );
}
