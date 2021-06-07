import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:orbital_app/models/order.dart';
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

  final CollectionReference orders = FirebaseFirestore.instance.collection('Orders');

  Future createOrderData(String item) async {
    return await orders.doc(DateTime.now().toString()).set({
      'To' : '',
      'From': uid,
      'Done' : false,
      'item' : item
    });
  } 

  List<Order> _orderFromSnapshot (QuerySnapshot ss) {
    return ss.docs.map((x) {
      return Order(
        to: x.get('To'),
        from: x.get('From'),
        done: x.get('Done'),
        item: x.get('Item'),
      );
    });
  }

  Stream<List<Order>> get orderData {
    return orders.snapshots().map(_orderFromSnapshot);
  }
}