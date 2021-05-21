import 'package:flutter/material.dart';
import 'package:orbital_app/services/auth.dart';

class Home extends StatelessWidget {
  final AuthService _auth = AuthService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.red[400],
      appBar: AppBar(
        title: Text("Home Screen"),
        backgroundColor: Colors.red[300],
        actions: <Widget>[
          TextButton.icon(
            icon: Icon(Icons.person),
            label: Text("logout"),
            onPressed: () async{
              await _auth.signOut();
            },
          )
        ],
      ),
    );
  }
}