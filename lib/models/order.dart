import 'package:cloud_firestore/cloud_firestore.dart';

class Order {
  final String from;
  final String to;
  final bool done;
  final int orderId;

  Order({this.from, this.to, this.done, this.orderId});

}