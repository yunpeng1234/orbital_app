import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:orbital_app/models/user.dart';
import 'package:orbital_app/services/database.dart';

class AuthService {

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = GoogleSignIn();

  //create local user object
  Individual _userFromFirebase(User user) {
    return user != null ? Individual(uid: user.uid) : null;
  }

  String getUID() {
    return _auth.currentUser.uid;
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
  Future<Individual> signInNative(String email, String password) async {
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
  Future<Individual> registerNative(String email, String password) async {
    try {
      UserCredential res = await _auth.createUserWithEmailAndPassword(email: email.trim(), password: password);
      User user = res.user;
      //new doc per new user registered.
      await DatabaseService(uid: user.uid).initialiseUserData("");

      return _userFromFirebase(user);
    } catch(e) {
      print(e.toString());
      return null;
    }
  }  

  Future<void> sendPasswordReset(String email) {
    return _auth.sendPasswordResetEmail(email: email);
  }
  //Sign in with Google

  Future signInGoogle() async {
    try {
      final GoogleSignInAccount googleSignInAccount = await googleSignIn.signIn();
      final GoogleSignInAuthentication googleSignInAuthentication = 
        await googleSignInAccount.authentication;
      
      final AuthCredential credential = GoogleAuthProvider.credential(
        idToken: googleSignInAuthentication.idToken,
        accessToken: googleSignInAuthentication.accessToken,
      );

      UserCredential res = await _auth.signInWithCredential(credential);
      User user = res.user;
      //new doc per new user registered.
      await DatabaseService(uid: user.uid).initialiseUserData("");
      return user;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  //Sign out
  Future signOut() async {
    try{
      return await _auth.signOut();
    } catch (e) {
      print(e.toString());
    }
  }
}