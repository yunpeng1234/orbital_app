import 'package:cloud_firestore/cloud_firestore.dart';

class Message {
  final String message;
  final String from;
  final String to;
  final Timestamp time;

  Message({this.message, this.from, this.to, this.time});
}