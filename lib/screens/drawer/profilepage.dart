import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:orbital_app/models/order.dart';
import 'package:orbital_app/models/user.dart';
import 'package:orbital_app/shared/app_drawer.dart';
import "package:provider/provider.dart";
import "package:orbital_app/services/database.dart";
import "package:cloud_firestore/cloud_firestore.dart";
import 'package:orbital_app/shared/constants.dart';

class ProfilePageView extends StatefulWidget {
  static const String routeName = '/profile';
  @override
  _ProfilePageViewState createState() => _ProfilePageViewState();
}

class _ProfilePageViewState extends State<ProfilePageView> {
  final string = FirebaseAuth.instance.currentUser.uid;

  String toUpdate = '';
  final DatabaseService user  = DatabaseService(uid: FirebaseAuth.instance.currentUser.uid);

  

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: user.userData,
      builder:(BuildContext context, AsyncSnapshot<IndividualData> snapshot) {
        String username = snapshot.data.name;
        return Scaffold(
            appBar: AppBar(title: Text('texting'),),
            drawer: AppDrawer(),
            backgroundColor: primaryColor,
            resizeToAvoidBottomInset: false,
            body: Column(
              children: <Widget>[
                Text(username, style: TextStyle(fontSize: 50.0)),
                SizedBox(height: 10.0),
                Form(
                  child: TextFormField(
                    decoration: textBoxDeco.copyWith(hintText: "New Username"),
                    onChanged: (val) {
                      setState(() {
                        toUpdate = val;
                      });
                    },
                  )
                ),
                TextButton(
                  onPressed: () async {
                    user.updateUserData(toUpdate);
                  },
                  child: Text("Submit"),
                  ),
              ],
            )
        );
      
      }
      
      );
 }
}