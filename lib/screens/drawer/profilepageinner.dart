import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:orbital_app/services/database.dart';
import 'package:orbital_app/shared/constants.dart';
import 'package:provider/provider.dart';
import 'package:orbital_app/models/user.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserDataDisplay extends StatefulWidget {

  @override
  _UserDataDisplayState createState() => _UserDataDisplayState();
}

class _UserDataDisplayState extends State<UserDataDisplay> {
  String toUpdate = '';
  
  @override
  Widget build(BuildContext context) {
    final info = Provider.of<IndividualData>(context);
    final DatabaseService user  = DatabaseService(uid: FirebaseAuth.instance.currentUser.uid);


    

    String username = info.name;

    return Column(
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
            print(toUpdate);
            user.updateUserData(toUpdate);
          },
          child: Text("Submit"),
          ),
      ],
      );
  }
}