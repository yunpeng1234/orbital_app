import 'package:flutter/material.dart';
import 'package:orbital_app/screens/home/home.dart';
import 'package:orbital_app/screens/authenticate/signin_view.dart';
import 'package:orbital_app/screens/authenticate/password_reset_view.dart';
import 'package:orbital_app/screens/authenticate/register_view.dart';
import 'package:orbital_app/screens/drawer/profilepage.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => Home());
      case 'signIn':
        return MaterialPageRoute(builder: (_) => SignInView());
      case 'forgotPassword':
        return MaterialPageRoute(builder: (_) => PasswordResetView());
      case 'createAccount':
        return MaterialPageRoute(builder: (_) => RegisterView());
      case 'profilePage':
        return MaterialPageRoute(builder: (_) => ProfilePage());
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