import 'package:flutter/material.dart';
import 'package:orbital_app/screens/home/home.dart';
import 'package:orbital_app/screens/authenticate/signin2.dart';
import 'package:orbital_app/screens/authenticate/forgot_password.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => Home());
      case 'login':
        return MaterialPageRoute(builder: (_) => SignInView());
      case 'password':
        return MaterialPageRoute(builder: (_) => ForgotPassword());
      default:
        return MaterialPageRoute(builder: (_) {
          return Scaffold(
            body: Center(
              child: Text('No route defined for ${settings.name}'),
            ),
          );
        });
    }
  }
}