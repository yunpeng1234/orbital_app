import 'package:flutter/material.dart';
import 'package:orbital_app/shared/drawer.dart';

class ProfilePage extends StatefulWidget {
  static const String routeName = '/profile';
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
       appBar: AppBar(
         title: Text("My Profile"),
       ),
       drawer: AppDrawer(),
       body: Center(child: Text("This is profile page")));
 }
}