import 'package:cloud_firestore/cloud_firestore.dart';
import 'service_locator.dart';
import 'auth_service.dart';
import 'package:orbital_app/models/message.dart';

class MessageService {
  final String first = 'Messages';
  final String second = 'Contacts';
  final String third = 'Texts';

  
  static final AuthService _auth = serviceLocator<AuthService>();

  String getUID() {
    return _auth.getUID();
  }

  final CollectionReference messages = FirebaseFirestore.instance.collection('Messages');
  final CollectionReference local = FirebaseFirestore.instance.collection('Messages').doc(_auth.getUID()).collection('Contacts');

  Future<void> sendMessage(String uid, String message) async {
    String from = _auth.getUID();
    String to = uid;
    DateTime temp = DateTime.now();


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

  Stream<List<String>> get contacts {
    return local.snapshots().map((x) {
      return x.docs.map((x) {
        return x.id;
      });
    });
  }
}