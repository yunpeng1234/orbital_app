import 'package:flutter/material.dart';
import 'package:orbital_app/shared/app_drawer.dart';

class ProfilePageView extends StatefulWidget {
  static const String routeName = '/profile';
  @override
  _ProfilePageViewState createState() => _ProfilePageViewState();
}

class _ProfilePageViewState extends State<ProfilePageView> {
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