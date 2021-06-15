import 'package:flutter/material.dart';
import 'package:orbital_app/screens/home/home_view.dart';
import 'package:orbital_app/screens/authenticate/signin_view.dart';
import 'package:orbital_app/screens/authenticate/password_reset_view.dart';
import 'package:orbital_app/screens/authenticate/register_view.dart';
import 'package:orbital_app/screens/drawer/profilepage.dart';
import 'package:orbital_app/screens/home/all_locations_view.dart';
import 'package:orbital_app/screens/submit_order_flow/input_order_view.dart';
import 'package:orbital_app/screens/home/order_view.dart';
import 'package:orbital_app/screens/submit_order_flow/location_view.dart';
import 'package:orbital_app/models/dummy_location.dart';
import 'package:orbital_app/models/my_location.dart';
import 'package:orbital_app/models/order.dart';
import 'package:orbital_app/screens/location_testing.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    Widget page;
    switch (settings.name) {
      case '/':
        page = HomeView();
        break;
      case 'signIn':
        page = SignInView();
        break;
      case 'forgotPassword':
        page = PasswordResetView();
        break;
      case 'createAccount':
        page = RegisterView();
        break;
      case 'profilePage':
        page = ProfilePageView();
        break;
      case 'allLocations':
        page = AllLocationsView();
        break;
      case 'order':
        final args = settings.arguments as Order;
        page = OrderView(order: args,);
        break;
      case 'location':
        final args = settings.arguments as MyLocation;
        page = LocationView(location: args);
        break;
      case 'inputOrder':
        final args = settings.arguments as MyLocation;
        page = InputOrderView(location: args);
        break;
      case 'locationTest':
        page = LocationTesting();
        break;
      default:
        page = Scaffold(
          body: Center(
            child: Text('No route defined for ${settings.name}'),
          ),
        );
        break;
    }
    return MaterialPageRoute(builder: (_) => page);
  }
}

// Map<String, WidgetBuilder> routeGenerator = {
//   'signIn' : (context) => SignInView(),
//   '/' : (context) => HomeView(),
//   'forgotPassword' : (context) => PasswordResetView(),
//   'createAccount' : (context) => RegisterView(),
//   'profilePage' : (context) => ProfilePageView(),
// };