import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:orbital_app/models/user.dart';

class DatabaseService {

  final String uid;

  DatabaseService({this.uid});
  //Collection reference
  final CollectionReference users = FirebaseFirestore.instance.collection('User');

  Future updateUserData(String name) async {
    return await users.doc(uid).set({
      'Username' : name,
    });
  } // things that are tied to the user themselves
  

  List<IndividualData> _userFromSnapshot (QuerySnapshot ss) {
    return ss.docs.map((doc) {
      return IndividualData(
        name: doc.get('Username')?? '', 
      );
    });
  }
 
  IndividualData _dataFromSnapshot(DocumentSnapshot snapshot) {
    return IndividualData(
      uid: uid,
      name: (snapshot.data() as Map)['Username'],
    );
  }

  Stream<IndividualData> get userData {
    return users.doc(uid).snapshots()
      .map(_dataFromSnapshot);
  }
}