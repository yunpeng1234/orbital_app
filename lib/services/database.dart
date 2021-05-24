import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  //Collection reference
  final CollectionReference restaurants = FirebaseFirestore.instance.collection('Restaurants');

  Future updateUserData(String name, ) {} // things that are tied to the user themselves
  
}