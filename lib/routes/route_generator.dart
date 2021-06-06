import 'package:flutter/material.dart';
import 'package:orbital_app/screens/home/home_view.dart';
import 'package:orbital_app/screens/authenticate/signin_view.dart';
import 'package:orbital_app/screens/authenticate/password_reset_view.dart';
import 'package:orbital_app/screens/authenticate/register_view.dart';
import 'package:orbital_app/screens/drawer/profilepage.dart';
import 'package:orbital_app/screens/home/all_locations_view.dart';

// Don't delete yet

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => HomeView());
      case 'signIn':
        return MaterialPageRoute(builder: (_) => SignInView());
      case 'forgotPassword':
        return MaterialPageRoute(builder: (_) => PasswordResetView());
      case 'createAccount':
        return MaterialPageRoute(builder: (_) => RegisterView());
      case 'profilePage':
        return MaterialPageRoute(builder: (_) => ProfilePageView());
      case 'allLocations':
        return MaterialPageRoute(builder: (_) => AllLocationsView());
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

// Map<String, WidgetBuilder> routeGenerator = {
//   'signIn' : (context) => SignInView(),
//   '/' : (context) => HomeView(),
//   'forgotPassword' : (context) => PasswordResetView(),
//   'createAccount' : (context) => RegisterView(),
//   'profilePage' : (context) => ProfilePageView(),
// };