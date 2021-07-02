import 'package:orbital_app/models/user.dart';
import 'package:material/material.dart';
import 'package:orbital_app/services/database.dart';

class Contact{
  final String sender;
  final DateTime time;
  final String message;

  Contact({this.sender, this.time, this.message});
}