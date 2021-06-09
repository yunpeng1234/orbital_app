import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:orbital_app/services/database.dart';
import 'package:orbital_app/shared/app_drawer.dart';
import 'package:orbital_app/shared/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:orbital_app/services/service_locator.dart';
import 'package:flutter/material.dart';
import 'package:orbital_app/shared/app_drawer.dart';
import 'package:orbital_app/shared/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';



class OrderTesting extends StatefulWidget {

  @override
  _OrderTestingState createState() => _OrderTestingState();
}

class _OrderTestingState extends State<OrderTesting> {
  final serv = serviceLocator<DatabaseService>();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: FirebaseFirestore.instance.collection('Order').snapshots(),
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
                        title: Text(doc['To']),
                        subtitle: Text(doc['From'])
                    );
                  }).toList(),
                  shrinkWrap: true,
                ),
                TextButton(
                    onPressed: () async {
                      serv.createOrderData();
                    },
                    child: Text('create order'))
              ],
            ),
          );
        }
    );
  }
}