import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:geoflutterfire/geoflutterfire.dart';
import 'package:geolocator/geolocator.dart';
import 'package:orbital_app/models/order.dart';
import 'package:orbital_app/services/database.dart';
import 'package:orbital_app/services/service_locator.dart';
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
import 'package:orbital_app/services/geolocation_service.dart';
import 'package:orbital_app/services/service_locator.dart';



class OrderTesting extends StatefulWidget {

  @override
  _OrderTestingState createState() => _OrderTestingState();
}

class _OrderTestingState extends State<OrderTesting> {
  String usr = FirebaseAuth.instance.currentUser.uid;
  final serv = DatabaseService(uid: FirebaseAuth.instance.currentUser.uid);
  GeoFirePoint location;
  GeolocationService pog = serviceLocator<GeolocationService>();
  Future<GeoFirePoint> ss =  serviceLocator<GeolocationService>().position();
  GeoFirePoint lol;


  void showPlacePicker() async {
    LocationResult result = await Navigator.of(context).push(MaterialPageRoute(
        builder: (context) =>
            PlacePicker(dotenv.env['PLACES_KEY'])));

    location = _converter(result);
  }

  GeoFirePoint _converter(LocationResult result) {
    return GeoFirePoint(result.latLng.latitude, result.latLng.longitude);
  }


  @override
  Widget build(BuildContext context) {
    return FutureBuilder<GeoFirePoint>(
      future: ss,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if(!snapshot.hasData) {
          return Loading();
        }
        lol = snapshot.data;
      return StreamBuilder(
        stream: serv.filteredByLocation(lol),
        builder:(BuildContext context, AsyncSnapshot<List<Order>> snapshot) {
                  print(snapshot.hasData.toString() + '1');

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
                    GeoFirePoint curr = lol;
                    GeoFirePoint placeholder = location;
                    serv.createOrderData(curr, placeholder, '' , '');
                    
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
      },
    );
  }
}