import 'package:counttestapp/Screens/homePage.dart';
import 'package:counttestapp/providers/database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';


class FlutterFireAuthService {
  final FirebaseAuth _firebaseAuth;

  FlutterFireAuthService(this._firebaseAuth);

  Stream<User?> get authStateChanges => _firebaseAuth.idTokenChanges();

  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }

  Future<String> signIn({email, password, context}) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      print("Signed In");
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => MyHomePage(),
        ),
      );
      return "Success";
    } on FirebaseAuthException catch (e) {
      print(e.toString());
      return e.message.toString();
    }
  }

  Future<String> signUp({email, password, context}) async {
    try {
      await _firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);
      
      await DatabaseService().updateUserData(value: 0);
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => MyHomePage(),
        ),
      );
      return "Success";
    } on FirebaseAuthException catch (e) {
      print(e.toString());
      return e.message.toString();
    }
  }
}
