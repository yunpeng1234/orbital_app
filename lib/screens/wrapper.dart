import 'package:flutter/material.dart';
import 'package:orbital_app/screens/home/home.dart';
import 'package:orbital_app/screens/authenticate/authenticate.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //return either home or authenticate
    return Home();
  }
}