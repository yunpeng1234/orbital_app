import 'package:firebase_auth/firebase_auth.dart';
import 'package:orbital_app/models/individual.dart';

class AuthService {

  final FirebaseAuth _auth = FirebaseAuth.instance;

  //create local user object
  Individual _userFromFirebase(User user) {
    return user != null ? Individual(uid: user.uid) : null;
  }

  //Sign in anon
  Future signTester() async {
    try {
      UserCredential res =  await _auth.signInAnonymously();
      User user = res.user;
      return _userFromFirebase(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Stream<Individual> get user {
    return _auth.authStateChanges()
      .map(_userFromFirebase);
  }

  //Sign in with email and pw
  Future signInNative(String email, String password) async {
    try {
      UserCredential res = await _auth.signInWithEmailAndPassword(email: email.trim(), password: password);
      User user = res.user;
      return _userFromFirebase(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
  //Register with email and pw
  Future registerNative(String email, String password) async {
    try {
      UserCredential res = await _auth.createUserWithEmailAndPassword(email: email.trim(), password: password);
      User user = res.user;
      return _userFromFirebase(user);
    } catch(e) {
      print(e.toString());
      return null;
    }
  }  

  Future sendPasswordReset(String email) {
    return _auth.sendPasswordResetEmail(email: email);
  }
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
  //Sign out
  Future signOut() async {
    try{
      return await _auth.signOut();
    } catch (e) {
      print(e.toString());
    }
  }
}