import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:orbital_app/models/order.dart';
import 'package:orbital_app/services/geolocation_service.dart';
import 'service_locator.dart';
import 'auth_service.dart';
import 'package:geoflutterfire/geoflutterfire.dart';

class OrderService {

  final geo = Geoflutterfire();
  static final AuthService _auth = serviceLocator<AuthService>();
  static final GeolocationService _geolocationService = serviceLocator<GeolocationService>();

  String getUID() {
    return _auth.getUID();
  }

  final CollectionReference orders = FirebaseFirestore.instance.collection('Orders');
  final CollectionReference users = FirebaseFirestore.instance.collection('User');

  Future<String> uidToName(String id) async {
    DocumentSnapshot temp = await users.doc(id).get();
    return temp['Username'];
  }

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

    String currentUID = getUID();

    DocumentSnapshot toGet = await temp.doc('fixed').get();
    int orderId = toGet['id'];
    temp.doc('fixed').update({'id' : orderId + 1});

    String from = await uidToName(currentUID);

    await users.doc(currentUID).update({
      'SubmittedOrder' : orderId,
    });

    return await orders.doc(orderId.toString()).set({
      'To' : '',
      'ToName' : '',
      'FromName' : from,
      'From': currentUID,
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
        toName: (x.data() as Map)['ToName'] ?? '',
        fromName: (x.data() as Map)['FromName'] ?? '',
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
        toName: (x.data() as Map)['ToName'] ?? '',
        fromName: (x.data() as Map)['FromName'] ?? '',
      );
      return two;
    }).toList();
  }

  Stream<List<Order>> filteredByLocation(GeoFirePoint center) {
    return geo.collection(collectionRef: orders)
    .within(center: center, radius: 2.0, field: 'Restaurant')
    .map(_orderFromFilter)
    .map((list) => list.where((order) => order.to == '' && order.from != getUID()).toList()
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

  Stream<List<Order>> filterByFrom() {
      Stream<QuerySnapshot> res = orders.where('From', isEqualTo: getUID()).snapshots();
      return res.map(_orderFromSnapshot);
  }

  Stream<List<Order>> filterByTo () {
    Stream<QuerySnapshot> res = orders.where('To', isEqualTo: getUID()).snapshots();
      return res.map(_orderFromSnapshot);
  }


  Future<void> acceptOrderData(int orderid) async {
    String currentUID = getUID();

    await users.doc(currentUID).update({
      'TakenOrder' : orderid,
    });

    return await orders.doc(orderid.toString()).update({'To': currentUID});
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

  Future<void> completeOrderData(int orderid) async {
    await orders.doc(orderid.toString()).update({
      'Done' : true,
    });
  }

   Future cancelOrderData(int orderid) async {
     await orders.doc(orderid.toString()).update({
       'To' : FieldValue.delete(),
       'ToName' : FieldValue.delete(),
    });
   }


  Stream<List<Order>> userOrder() {
    return orders.where('From', isEqualTo: getUID()).snapshots().map(_orderFromSnapshot);
  }
}