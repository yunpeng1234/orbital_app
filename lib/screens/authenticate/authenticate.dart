import 'package:flutter/material.dart';
import 'package:orbital_app/screens/authenticate/registerform.dart';
import 'package:orbital_app/screens/authenticate/signin.dart';

class Authenticate extends StatefulWidget {
  @override
  _AuthenticateState createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {

  bool showSignIn = true;

  void toggle() {
    setState(() => {showSignIn = !showSignIn}
    );
  }

  @override
  Widget build(BuildContext context) {
    if (showSignIn) {
      return SignIn(toggler: toggle);
    } else {
      return RegisterForm(toggler: toggle);
    }

  }
} 