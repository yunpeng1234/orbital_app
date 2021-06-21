import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:orbital_app/models/order.dart';
import 'package:orbital_app/models/user.dart';
import 'package:orbital_app/services/geolocation_service.dart';
import 'service_locator.dart';
import 'auth_service.dart';
import 'package:geoflutterfire/geoflutterfire.dart';

class OrderService {

  final String uid;
  final geo = Geoflutterfire();
  static final AuthService _auth = serviceLocator<AuthService>();
  static final GeolocationService _geolocationService = serviceLocator<GeolocationService>();


  OrderService({this.uid});
  //Collection reference

  static OrderService init() {
    return OrderService(uid: _auth.getUID());
  }


  final CollectionReference orders = FirebaseFirestore.instance.collection('Orders');
  final CollectionReference users = FirebaseFirestore.instance.collection('User');

  Future<void> createOrderData(
      GeoFirePoint deliverTo,
      GeoFirePoint restaurant,
      String order,
      String comments,
      String restaurantName,
      String restaurantAddress,
      String deliverToAddress,
      String userAddressDetails,
      ) async {
    CollectionReference temp  = FirebaseFirestore.instance.collection('OrderId');

    DocumentSnapshot toGet = await temp.doc('fixed').get();
    int orderId = toGet['id'];
    temp.doc('fixed').update({'id' : orderId + 1});

    await users.doc(uid).update({
      'SubmittedOrder' : orderId,
    });

    return await orders.doc(orderId.toString()).set({
      'To' : '',
      'From': uid,
      'Done' : false,
      'Item' : orderId,
      'DeliverTo': deliverTo.data,
      'DeliverToAddress': deliverToAddress,
      'UserAddressDetails': userAddressDetails,
      'Restaurant': restaurant.data,
      'Order': order,
      'Comments': comments,
      'RestaurantName' : restaurantName,
      'RestaurantAddress' : restaurantAddress,
    });
  }

  List<Order> _orderFromSnapshot (QuerySnapshot ss) {
    return ss.docs.map((x){
      var two =  Order(
        from: (x.data() as Map)['From'] ?? '',
        to: (x.data() as Map)['To'] ?? '',
        done: (x.data() as Map)['Done'] ?? false,
        orderId: (x.data() as Map)['Item']?? 0,
        deliverTo: ((x.data() as Map)['DeliverTo'] as Map)['geopoint'] ?? null,
        deliverToAddress: (x.data() as Map)['DeliverToAddress'] ?? '',
        userAddressDetails: (x.data() as Map)['UserAddressDetails'] ?? '',
        restaurantLocation: ((x.data() as Map)['Restaurant'] as Map)['geopoint']?? null,
        order: (x.data() as Map)['Order'] ?? '',
        comments: (x.data() as Map)['Comments'] ?? '',
        restaurantAddress: (x.data() as Map)['RestaurantAddress'] ?? '',
        restaurantName: (x.data() as Map)['RestaurantName'] ?? '',

      );
      return two;
    }).toList();
  }

  Stream<List<Order>> get orderData {
    return orders.snapshots().map(_orderFromSnapshot);
  }

  List<Order> _orderFromFilter (List<DocumentSnapshot> docSnap) {
    return docSnap.map((x) {
      var two =  Order(
        from: (x.data() as Map)['From'] ?? '',
        to: (x.data() as Map)['To'] ?? '',
        done: (x.data() as Map)['Done'] ?? false,
        orderId: (x.data() as Map)['Item']?? 0,
        deliverTo: ((x.data() as Map)['DeliverTo'] as Map)['geopoint'] ?? null,
        restaurantLocation: ((x.data() as Map)['Restaurant'] as Map)['geopoint'] ?? null,
        order: (x.data() as Map)['Order'],
        comments: (x.data() as Map)['Comments'],
        restaurantAddress: (x.data() as Map)['RestaurantAddress'] ?? '',
        restaurantName: (x.data() as Map)['RestaurantName'] ?? '',
        deliverToAddress: (x.data() as Map)['DeliverToAddress'] ?? '',
        userAddressDetails: (x.data() as Map)['UserAddressDetails'] ?? '',
        
      );
      return two;
    }).toList();
  }

  Stream<List<Order>> filteredByLocation(GeoFirePoint center) {
    return geo.collection(collectionRef: orders)
    .within(center: center, radius: 2.0, field: 'Restaurant')
    .map(_orderFromFilter)
    .map((list) => list.where((order) => order.to == '').toList()
    );
  }

  Stream<List<Order>> filteredByLocationAndDestination(GeoFirePoint center, GeoFirePoint chosenLocation) {
    return geo.collection(collectionRef: orders)
        .within(center: center, radius: 2.0, field: 'Restaurant')
        .map(_orderFromFilter)
        .map((list) => list.where((order) => order.to == '' &&
          chosenLocation.distance(lat: order.deliverTo.latitude, lng: order.deliverTo.longitude) < 0.5) // distance in km
        .toList()
    );
  }

  bool _destinationCheck(Order order) {
    GeoPoint destination = order.deliverTo;
    return true;
  }

  Future<void> acceptOrderData(int orderid) async {
    await users.doc(uid).update({
      'TakenOrder' : orderid,
    });

    return await orders.doc(orderid.toString()).update({'To': uid});
  }

  Future deleteOrderData(int orderid) async {
    String deliverer = (await orders.doc(orderid.toString()).get())['To'];
    String deliveree = (await orders.doc(orderid.toString()).get())['From'];

    if(deliverer == '') {
      await users.doc(deliveree).update({
      'SubmittedOrder' : FieldValue.delete(),
    });
    } else {
      await users.doc(deliveree).update({
        'TakenOrder' : FieldValue.delete(),
      });
      await users.doc(deliverer).update({
        'SubmittedOrder' : FieldValue.delete(),
      });
    }
    return await orders.doc(orderid.toString()).delete();
  }

  Future completeOrderData(int orderid) async {
    await orders.doc(orderid.toString()).update({
      'Done' : true,
    });
  }


  Stream<List<Order>> userOrder() {
    return orders.where('From', isEqualTo: uid).snapshots().map(_orderFromSnapshot);
  }
}