import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:geoflutterfire/geoflutterfire.dart';
import 'package:orbital_app/services/database.dart';

class Order {
  final String from;
  final String to;
  final String fromName;
  final String toName;
  final bool done;
  final int orderId;
  final String deliverToAddress;
  final String userAddressDetails;
  final GeoPoint deliverTo;
  final GeoPoint restaurantLocation;
  final String order;
  final String comments; 
  final String restaurantName;
  final String restaurantAddress;

  Order({
    this.from,
    this.to,
    this.fromName,
    this.toName,
    this.done,
    this.orderId,
    this.deliverToAddress,
    this.userAddressDetails,
    this.deliverTo,
    this.restaurantLocation,
    this.order,
    this.comments,
    this.restaurantAddress,
    this.restaurantName});

}