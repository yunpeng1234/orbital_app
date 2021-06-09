import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:orbital_app/services/database.dart';
import 'package:orbital_app/shared/app_drawer.dart';
import 'package:orbital_app/shared/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:orbital_app/shared/app_drawer.dart';
import 'package:orbital_app/shared/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';



class OrderTesting extends StatefulWidget {

  @override
  _OrderTestingState createState() => _OrderTestingState();
}

class _OrderTestingState extends State<OrderTesting> {
  String usr = FirebaseAuth.instance.currentUser.uid;
  final serv = DatabaseService(uid: FirebaseAuth.instance.currentUser.uid);

  @override
  Widget build(BuildContext context) {
      return StreamBuilder(
        stream: FirebaseFirestore.instance.collection('Orders').snapshots(),
        builder:(BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) return new Text('Load');
          return Scaffold(
            appBar: AppBar(title: Text('texting'),),
            drawer: AppDrawer(),
            backgroundColor: primaryColor,
            resizeToAvoidBottomInset: false,
            body: Column(
              children: <Widget>[
                ListView(
                  children: snapshot.data.docs.map((doc) {
                    return new ListTile(
                      title: Text(doc['To'] + '\n' + doc['From']),
                      subtitle: Text(doc['item'].toString()),
                      trailing: IconButton(
                        icon: Icon(Icons.home),
                        onPressed: () async {
                          serv.acceptOrderData(doc['item']);
                        },),
                      leading: IconButton(
                        icon: Icon(Icons.hearing_outlined),
                        onPressed: () async {
                          serv.deleteOrderData(doc['item']);
                        },),
                    );
                  }).toList(),
                  shrinkWrap: true,
                ),
                TextButton(
                  onPressed: () async {
                    serv.createOrderData();
                  },
                  child: Text('create order')
                ),
              ],
            ),
          );
        }
      );
  }
}