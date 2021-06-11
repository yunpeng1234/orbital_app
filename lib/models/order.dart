import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:geoflutterfire/geoflutterfire.dart';
import 'package:orbital_app/services/database.dart';

class Order {
  final String from;
  final String to;
  final bool done;
  final int orderId;
  //final GeoFirePoint deliverTo ;

  Order({this.from, this.to, this.done, this.orderId});

}