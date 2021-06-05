import 'package:flutter/material.dart';
import 'package:orbital_app/models/user.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:orbital_app/services/auth_service.dart';
import 'package:orbital_app/services/service_locator.dart';
import 'package:provider/provider.dart';
import 'routes/route_generator.dart';
import 'routes/nav_key.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  setupServiceLocator();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return StreamProvider<Individual>.value(
      initialData: null,
      value: AuthService().user,
        child: MaterialApp(
          navigatorKey: NavKey.navKey,
          initialRoute: 'signIn',
          onGenerateRoute: RouteGenerator.generateRoute,
      ),
    );
  }
}

