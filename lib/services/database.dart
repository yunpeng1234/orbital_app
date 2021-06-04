import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:orbital_app/models/user.dart';

class DatabaseService {

  final String uid;
  DatabaseService({this.uid});
  //Collection reference
  final CollectionReference users = FirebaseFirestore.instance.collection('Restaurants');

  Future updateUserData(String name, GeoPoint coord) async {
    return await users.doc(uid).set({
      'Username' : name,
      'Location' : coord,
    });
  } // things that are tied to the user themselves
  

  IndividualData _dataFromSnapshot(DocumentSnapshot snapshot) {
    return IndividualData(
      uid: uid,
      name: (snapshot.data() as DocumentSnapshot)['Username'],
      location: (snapshot.data() as DocumentSnapshot)['Location'],
    );
  }

  Stream<IndividualData> get userData {
    return users.doc(uid).snapshots()
      .map(_dataFromSnapshot);
  }
}