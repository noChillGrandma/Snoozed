


import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:smarttodo/authentication/screens/authentication_page.dart';
import 'package:smarttodo/homepage.dart';

class AuthenticationWrapper69 extends StatelessWidget {
  const AuthenticationWrapper69({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final firebaseUser = context.watch<User?>();

    if (firebaseUser != null) {
      return const HomePage();
    }
    return const AuthenticationPage();
  }
}