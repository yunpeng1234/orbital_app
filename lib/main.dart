import 'package:flutter/material.dart';
import 'package:orbital_app/models/user.dart';
import 'package:orbital_app/routes/drawerRoute.dart';
import 'package:orbital_app/screens/drawer/profilepage.dart';
// import 'package:orbital_app/screens/home/home.dart';
import 'package:orbital_app/screens/wrapper.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:orbital_app/services/auth.dart';
import 'package:orbital_app/services/locator.dart';
import 'package:provider/provider.dart';
import 'routes/route_generator.dart';
import 'package:orbital_app/services/locator.dart';

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
          home: Wrapper(),
          initialRoute: 'login',
          onGenerateRoute: RouteGenerator.generateRoute,
      ),
    );
  }
}

