import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:io';


class StorageService {
  final string = FirebaseAuth.instance.currentUser.uid;
  FirebaseStorage store = FirebaseStorage.instanceFor(bucket: dotenv.env['BackEndUrl']);

  Future uploadFile(PickedFile file) async {
    String userID = string;

    Reference storageRef = store.ref().child('user/profile/${userID}');
    UploadTask wait = storageRef.putFile(File(file.path));
    return storageRef.getDownloadURL();
  }
}