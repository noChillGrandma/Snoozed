import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

class AppUser {
  final String uid;
  final String username;
  
  
  AppUser({
    required this.uid,
    required this.username,
    });


  factory AppUser.fromDocument(BuildContext context, DocumentSnapshot doc) {
    var user = Provider.of<User>(context, listen: false);
    return AppUser(
      username: doc['username'] ?? '', 
      uid: user.uid,
    );
  }
}