import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:orbital_app/models/order.dart';
import 'package:orbital_app/models/user.dart';
import 'service_locator.dart';
import 'auth_service.dart';
import 'package:geoflutterfire/geoflutterfire.dart';

class DatabaseService {

  final String uid;
  static final AuthService _auth = serviceLocator<AuthService>();
  final geo = Geoflutterfire();


  DatabaseService({this.uid});
  //Collection reference
  final CollectionReference users = FirebaseFirestore.instance.collection('User');

  static DatabaseService init() {
    return DatabaseService(uid: _auth.getUID());
  }

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

  Future createOrderData() async {
    CollectionReference temp  = FirebaseFirestore.instance.collection('OrderId');

    DocumentSnapshot toGet = await temp.doc('fixed').get();
    int orderId = toGet['id'];
    temp.doc('fixed').update({'id' : orderId + 1});

    return await orders.doc(orderId.toString()).set({
      'To' : '',
      'From': uid,
      'Done' : false,
      'item' : orderId,
      //'DeliverLoc': deliverTo.data,
    });
  }

  List<Order> _orderFromSnapshot (QuerySnapshot ss) {
    return ss.docs.map((x){
      return Order(
        from: (x.data() as Map)['From'] ?? '',
        to: (x.data() as Map)['To'] ?? '',
        done: (x.data() as Map)['Done'] ?? false,
        orderId: (x.data() as Map)['item']?? 0,
        //deliverTo: (x.data() as Map)['DeliverLoc'],
      );
    }).toList();
  }

  Stream<List<Order>> get orderData {
    return orders.snapshots().map(_orderFromSnapshot);
  }

  List<Order> _orderFromFilter (List<DocumentSnapshot> docSnap) {
    return docSnap.map((x) {
      return Order(
        from: (x.data() as Map)['From'] ?? '',
        to: (x.data() as Map)['To'] ?? '',
        done: (x.data() as Map)['Done'] ?? false,
        orderId: (x.data() as Map)['item']?? 0,
        //deliverTo: (x.data() as Map)['DeliverLoc'],
      );
    });
  }

  // Stream<List<Order>> get filteredByLocation(GeoFirePoint center) {
  //   return geo.collection(collectionRef: orders)
  //   .within(center: center, radius: 2.0, field: 'DeliverTo')
  //   .map(_orderFromFilter);
  // }

  Future acceptOrderData(int orderid) async {
    return await orders.doc(orderid.toString()).update({'To': uid});
  }

  Future deleteOrderData(int orderid) async {
    return await orders.doc(orderid.toString()).delete();
  }
}