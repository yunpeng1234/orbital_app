import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:orbital_app/models/order.dart';
import 'package:orbital_app/models/user.dart';
import 'package:orbital_app/services/storage.dart';
import 'package:orbital_app/shared/app_drawer.dart';
import 'package:orbital_app/shared/loading.dart';
import 'package:orbital_app/shared/widgets/avatar.dart';
import "package:provider/provider.dart";
import "package:orbital_app/services/database.dart";
import "package:cloud_firestore/cloud_firestore.dart";
import 'package:orbital_app/shared/constants.dart';
import 'package:firebase_storage/firebase_storage.dart';

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
        if (!snapshot.hasData) { return Loading();}
        String username = snapshot.data.name;
        return Scaffold(
            appBar: AppBar(title: Text('texting'),),
            drawer: AppDrawer(),
            backgroundColor: primaryColor,
            resizeToAvoidBottomInset: false,
            body: Column(
              children: <Widget>[
                Avatar(
                  avatarUrl: snapshot.data.picUrl,
                  onTap: () async {
                    PickedFile image = await ImagePicker().getImage(
                      source: ImageSource.gallery);
                    
                    String dlUrl = await StorageService().uploadFile(image);
                    await user.updateUserPic(dlUrl);
                    setState(() {});
                  }
                ),
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