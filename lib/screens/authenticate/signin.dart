import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:orbital_app/services/auth.dart';

class SignIn extends StatefulWidget {
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {

  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(249, 203, 156, 1.0),
      appBar: AppBar(
        backgroundColor: Colors.brown[200],
        elevation: 0.0,
        title: Text('Sign In')
        ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
        child: ElevatedButton(
          child: Text('Sign In Anon'),
          onPressed: () async {
            dynamic userres = await _auth.signTester();
            if (userres == null) {
              print('error');
            }
            if (userres != null) {
              print('signed in');
              print(userres);
            }

          },
        ),
      ),
    );
  }
}