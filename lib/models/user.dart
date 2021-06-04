import 'package:cloud_firestore/cloud_firestore.dart';

class Individual {
  final String uid;
  Individual({this.uid});
}

class IndividualData {
  final String uid;
  final String name;
  final GeoPoint location;
  final String role;

  IndividualData({this.uid, this.name, this.location, this.role});

  Map<String, dynamic> toJson() => {
    'name': name,
    'location' : location,
    'role' : role,
  };
}