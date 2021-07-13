import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:orbital_app/services/auth_service.dart';
import 'package:orbital_app/routes/nav_key.dart';


class VerifyScreen extends StatefulWidget {
  final String name;


  VerifyScreen({
    this.name
  });

  @override
  _VerifyScreenState createState() => _VerifyScreenState();
}

class _VerifyScreenState extends State<VerifyScreen> {
    final GlobalKey<NavigatorState> navKey = NavKey.navKey;

  final auth = AuthService();
  final service = FirebaseAuth.instance;
  User user;
  Timer timer;

  @override
  void initState() {
    user = service.currentUser;

    timer = Timer.periodic(Duration(seconds:3), (timer) {
      checkEmailVerified();
    });
    super.initState();
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Timer kicker = new Timer(Duration(seconds :10), () async {
      auth.signOut();
      await user.delete();
      navKey.currentState.pushReplacementNamed('/');
      });

    return Scaffold(
      body: Center(
        child: Text(
            'An email has been sent to ${user.email} please verify'),
      ),
    );
  }

  Future<void> checkEmailVerified() async {
    user = service.currentUser;
    await user.reload();
    if (user.emailVerified) {
      timer.cancel();
      await auth.createuser(widget.name);
      navKey.currentState.pushReplacementNamed('/');
    }
  }
}