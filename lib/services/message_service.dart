import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:orbital_app/models/contact.dart';
import 'package:orbital_app/services/database.dart';
import 'service_locator.dart';
import 'auth_service.dart';
import 'package:orbital_app/models/message.dart'; 
import 'package:orbital_app/models/user.dart';
import 'package:material/material.dart';

class MessageService {
  final String first = 'Messages';
  final String second = 'Contacts';
  final String third = 'Texts';
  final String greeting = 'Hello, I have taken your order';

  
  static final AuthService _auth = serviceLocator<AuthService>();
  static final DatabaseService _databaseService = serviceLocator<DatabaseService>();

  String getUID() {
    return _auth.getUID();
  }

  final CollectionReference messages = FirebaseFirestore.instance.collection('Messages');
  final CollectionReference local = FirebaseFirestore.instance.collection('Messages').doc(_auth.getUID()).collection('Contacts');
  final CollectionReference contact = FirebaseFirestore.instance.collection('Contacts');
  final CollectionReference contactLocal = FirebaseFirestore.instance.collection('Contacts').doc(_auth.getUID()).collection('Latest');

  Future<void> sendMessage(String uid, String message) async {
    String from = _auth.getUID();
    String to = uid;
    Timestamp temp = Timestamp.now();

    await contactLocal.doc(to).update({
      'Time' : temp,
      'Message' : message,
    });

    await contact.doc(to).collection('Latest').doc(from).update({
      'Time' : temp,
      'Message' : message,
    });

    /// Adds to the other user's message collection
    await messages.doc(to).collection('Contacts').doc(from).collection('Texts').add({
      'To' : to,
      'From' : from,
      'Message' : message,
      'Time' : temp,
    });

    /// Adds to own message collection
    return await local.doc(to).collection('Texts').add({
      'To' : to,
      'From' : from,
      'Message' :message,
      'Time' : temp,
    });
  }

  Future<void> startConversation(String uid) async {
    String from = _auth.getUID();
    String to = uid;
    Timestamp temp = Timestamp.now();

    await contactLocal.doc(to).set({
      'Time' : temp,
      'Message' : '',
    });

    await contact.doc(to).collection('Latest').doc(from).set({
      'Time' : temp,
      'Message' : '',
    });

    /// Adds to the other user's message collection
    await messages.doc(to).collection('Contacts').doc(from).collection('Texts').add({
      'To' : to,
      'From' : from,
      'Message' : greeting,
      'Time' : temp,
    });

    /// Adds to own message collection
    return await local.doc(to).collection('Texts').add({
      'To' : to,
      'From' : from,
      'Message' :greeting,
      'Time' : temp,
    });
  }

  List<Message> _messagesFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((x) {
      return Message(
        from: (x.data() as Map)['From'] ?? '',
        to: (x.data() as Map)['To'] ?? '',
        message: (x.data() as Map)['Message'] ?? '',
        time: (x.data() as Map)['Time'] ?? null,
      );
    }
    ).toList();
  } 
  
  ///Get the list of messages for one person
  Stream<List<Message>> message(String uid) {
    return local.doc(uid).collection('Texts').orderBy('Time').snapshots().map(_messagesFromSnapshot);
  }

  // List<Contact> _contactFromSnapshot(QuerySnapshot snapshot) {
  //   return snapshot.docs.map((x) {
  //     return Contact(
  //       senderUID: x.id,
  //       time: (x.data() as Map)['From'],
  //       message: (x.data() as Map)['From'],
  //     )
  //   }).toList();
  // }

  List<Contact> _contactFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((x) {
      return Contact(
        sender: x.id,
        message: (x.data() as Map)['Message'] ?? '',
        time: (x.data() as Map)['Time'] ?? null,
      );
    }
    ).toList();
  }

  Stream<List<Contact>> get contacts {
    print(contactLocal.snapshots().map((x) {
      print(x);
    }).toString());
    return contactLocal.snapshots().map(_contactFromSnapshot);

  }

  // Future<Contact> mapToContact(String uid) async {
  //   IndividualData user = await _databaseService.getSenderData(uid);
  //   List<Message> list = await message(getUID()).first;
  //   Message text = list[0];
  //   DateTime time = DateTime.fromMillisecondsSinceEpoch(text.time * 1000);

  //   return Contact(message: text.message, sender: user, time: time);
  // }
}