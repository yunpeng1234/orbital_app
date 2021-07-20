import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:io';


class StorageService {
  final string = FirebaseAuth.instance.currentUser.uid;
  FirebaseStorage store = FirebaseStorage.instanceFor(bucket: dotenv.env['BackEndUrl']);

  Future uploadFile(PickedFile file) async {
    String userID = string + DateTime.now().toString();

    Reference storageRef = store.ref().child('user/profile/${userID}');
    UploadTask wait = storageRef.putFile(File(file.path));
    var completed = await wait;
    return completed.ref.getDownloadURL();
  }

  Future reuploadFile(PickedFile file) async {
    String userID = string + DateTime.now().toString();

    Reference storageRef = store.ref().child('user/profile/${userID}');
    await storageRef.delete();
    try{
    UploadTask wait = storageRef.putFile(File(file.path));
    
    } catch(e) {
      print(e);
      print('kek');
    }
    
    return storageRef.getDownloadURL();
  }
}