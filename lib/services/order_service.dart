import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:orbital_app/models/order.dart';
import 'package:orbital_app/services/geolocation_service.dart';
import 'service_locator.dart';
import 'auth_service.dart';
import 'package:geoflutterfire/geoflutterfire.dart';

class OrderService {

  final geo = Geoflutterfire();
  static final AuthService _auth = serviceLocator<AuthService>();
  static final GeolocationService _geolocator = serviceLocator<GeolocationService>();
  String uid;

  String getUID() {
    return _auth.getUID();
  }

  final CollectionReference orders = FirebaseFirestore.instance.collection('Orders');
  final CollectionReference users = FirebaseFirestore.instance.collection('User');
  final CollectionReference history = FirebaseFirestore.instance.collection('History');

  Future<String> uidToName(String id) async {
    DocumentSnapshot temp = await users.doc(id).get();
    return temp['Username'];
  }

  Future<Order> getOrder(String orderId) async {
    Map order = (await orders.doc(orderId).get()).data() as Map;
    return Order(
      from: order['From'] ?? '',
      to: order['To'] ?? '',
      done: order['Done'] ?? false,
      orderId: order['Item']?? 0,
      deliverTo: (order['DeliverTo'] as Map)['geopoint'] ?? null,
      deliverToAddress: order['DeliverToAddress'] ?? '',
      userAddressDetails: order['UserAddressDetails'] ?? '',
      restaurantLocation: (order['Restaurant'] as Map)['geopoint']?? null,
      order: order['Order'] ?? '',
      comments: order['Comments'] ?? '',
      restaurantAddress: order['RestaurantAddress'] ?? '',
      restaurantName: order['RestaurantName'] ?? '',
      toName: order['ToName'] ?? '',
      fromName: order['FromName'] ?? '',
      fee: order['Fee'] ?? '',
    );
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
      String fee,
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
      'Fee' : fee,
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
        fee: (x.data() as Map)['Fee'] ?? '',
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
        fee: (x.data() as Map)['Fee'] ?? '',
      );
      return two;
    }).toList();
  }

  Stream<List<Order>> defaultFilter() {
    GeoFirePoint center = _geolocator.currentPosition();
    return geo.collection(collectionRef: orders)
    .within(center: center, radius: 0.5, field: 'Restaurant')
    .map(_orderFromFilter)
    .map((list) => list.where((order) => order.to == '' && order.from != getUID()).toList())
    .map((list) {
      List<Order> temp = list;
      temp.sort((a,b) {return a.compareTo(b);});
      return temp;
}  );
  }

  Stream<List<Order>> filteredByLocationAndDestination(GeoFirePoint chosenLocation) {
    GeoFirePoint center = _geolocator.currentPosition();
    return geo.collection(collectionRef: orders)
        .within(center: center, radius: 0.5, field: 'Restaurant')
        .map(_orderFromFilter)
        .map((list) => list.where((order) => order.to == '' &&
          chosenLocation.distance(lat: order.deliverTo.latitude, lng: order.deliverTo.longitude) < 0.5))
        .map((list) => list.where((order) => order.to == '' && order.from != getUID()) // distance in km
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
       'To' : '',
       'ToName' : '',
    });
   }

  Stream<List<Order>> userOrder() {
    return orders.where('From', isEqualTo: getUID()).snapshots().map(_orderFromSnapshot);
  }

  Future moveOrder(int orderid) async {
    CollectionReference localHistory = FirebaseFirestore.instance.collection('History').doc(_auth.getUID()).collection('My History');
    DocumentSnapshot temp = await orders.doc(orderid.toString()).get();
    String deliveree = temp['To'];

    localHistory.add(temp.data());
    history.doc(deliveree).collection('My History').add(temp.data());

    return await orders.doc(orderid.toString()).delete();
  }

  Stream<List<Order>> userHistory() {
    CollectionReference localHistory = FirebaseFirestore.instance.collection('History').doc(_auth.getUID()).collection('My History');
    return localHistory.snapshots().map(_orderFromSnapshot);
  }
}