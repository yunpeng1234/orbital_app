import 'package:cloud_firestore/cloud_firestore.dart';

class Individual {
  final String uid;
  Individual({this.uid});
}

class IndividualData {
  final String uid;
  final String name;

  IndividualData({this.uid, this.name});
}