import 'package:firebase_auth/firebase_auth.dart';

class AuthService {

  final FirebaseAuth _auth = FirebaseAuth.instance;

  //Sign in anon
  Future signTester() async {
    try {
      UserCredential res =  await _auth.signInAnonymously();
      User user = res.user;
      return user;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  //Sign in with email and pw
  Future signInNative(String email, String password) async {
    try {
      UserCredential res = await _auth.signInWithEmailAndPassword(email: email, password: password);
      User user = res.user;
      return user;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
  //Register with email and pw

  //Sign out

  //Sign in with Google
      /*
  Future signInGoogle(String email, String password) async {

    try {
      UserCredential res = await _auth.sign
      User user = res.user;
      return user;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }*/
}