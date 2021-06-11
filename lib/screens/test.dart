import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:orbital_app/models/order.dart';
import 'package:orbital_app/services/database.dart';
import 'package:orbital_app/shared/app_drawer.dart';
import 'package:orbital_app/shared/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:orbital_app/shared/app_drawer.dart';
import 'package:orbital_app/shared/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:orbital_app/shared/loading.dart';
import 'package:place_picker/place_picker.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';



class OrderTesting extends StatefulWidget {

  @override
  _OrderTestingState createState() => _OrderTestingState();
}

class _OrderTestingState extends State<OrderTesting> {
  String usr = FirebaseAuth.instance.currentUser.uid;
  final serv = DatabaseService(uid: FirebaseAuth.instance.currentUser.uid);

  void showPlacePicker() async {
    LocationResult result = await Navigator.of(context).push(MaterialPageRoute(
        builder: (context) =>
            PlacePicker(dotenv.env['PLACES_KEY'])));

    print(result.toString());
  }

  @override
  Widget build(BuildContext context) {
      return StreamBuilder(
        stream: serv.orderData,
        builder:(BuildContext context, AsyncSnapshot<List<Order>> snapshot) {
          if (!snapshot.hasData) return Loading();
          return Scaffold(
            appBar: AppBar(title: Text('texting'),),
            drawer: AppDrawer(),
            backgroundColor: primaryColor,
            resizeToAvoidBottomInset: false,
            body: SingleChildScrollView(
              child: Column(
              children: <Widget>[
                ListView(
                  children: snapshot.data.map((doc) {
                    return new ListTile(
                      title: Text(doc.to + '\n' + doc.from),
                      subtitle: Text(doc.orderId.toString()),
                      trailing: IconButton(
                        icon: Icon(Icons.home),
                        onPressed: () async {
                          serv.acceptOrderData(doc.orderId);
                        },
                      ),
                      leading: IconButton(
                        icon: Icon(Icons.hearing_outlined),
                        onPressed: () async {
                          serv.deleteOrderData(doc.orderId);
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
                TextButton(
                  onPressed: () {
                    showPlacePicker();
                  },
                  child: Text("Pick a place"),
                )
              ],
            ),)
          );
        }
      );


  }
}