import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:orbital_app/models/user.dart';
import 'package:orbital_app/screens/drawer/profilepageinner.dart';
import 'package:orbital_app/shared/app_drawer.dart';
import "package:provider/provider.dart";
import "package:orbital_app/services/database.dart";
import "package:cloud_firestore/cloud_firestore.dart";

class ProfilePageView extends StatefulWidget {
  static const String routeName = '/profile';
  @override
  _ProfilePageViewState createState() => _ProfilePageViewState();
}

class _ProfilePageViewState extends State<ProfilePageView> {
  @override
  Widget build(BuildContext context) {
    final string = FirebaseAuth.instance.currentUser.uid;
    return StreamProvider<IndividualData>.value (
      value: DatabaseService(uid: string).userData,
      initialData: IndividualData(),
      child: Scaffold(
       appBar: AppBar(
         title: Text("My Profile"),
       ),
       drawer: AppDrawer(),
       body: UserDataDisplay(),
       )
    );
 }
}