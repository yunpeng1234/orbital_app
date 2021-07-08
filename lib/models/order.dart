import 'package:cloud_firestore/cloud_firestore.dart';


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
  final String fee;

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
    this.restaurantName,
    this.fee,
  });

  String newComment() {
    return comments == "" ? "NIL" : comments;
  }

  String newAddressDetails() {
    return userAddressDetails == "" ? "NIL" : userAddressDetails;
  }
}