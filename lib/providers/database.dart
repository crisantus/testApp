import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class DatabaseService {
  CollectionReference users = FirebaseFirestore.instance.collection('users');

  Future<void> updateUserData({value}) {
    // Call the user's CollectionReference to add a new user
    return users
        .add({
          'value': value, // count
        })
        .then((value) => print("Value Added"))
        .catchError((error) => print("Failed to add value: $error"));
  }

 
}
