import 'package:cloud_firestore/cloud_firestore.dart';

class Order {
  final String from;
  final String to;
  final bool done;
  final String item;

  Order({this.from, this.to, this.done, this.item});
}