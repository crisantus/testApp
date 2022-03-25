import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:counttestapp/providers/database.dart';
import 'package:flutter/material.dart';

class Counter with ChangeNotifier {
  var docId;
  Counter.withDoc({required docId});

  Counter();

  int _count = 0;

  int get count => _count;

  CollectionReference users = FirebaseFirestore.instance.collection('users');

  // DatabaseService _database;

  void increment() {
    _count++;
    DatabaseService().updateUserData(value: _count++);
    notifyListeners();
  }

 
}
