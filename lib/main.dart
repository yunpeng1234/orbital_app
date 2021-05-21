import 'package:flutter/material.dart';
import 'package:orbital_app/models/individual.dart';
import 'package:orbital_app/screens/wrapper.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:orbital_app/services/auth.dart';
import 'package:provider/provider.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
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
      ),
    );
  }
}

