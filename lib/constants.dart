import 'dart:math';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';



const _charsABC123 = 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890';
const _chars123 = '1234567890';

final Random _rnd = Random();

String getRandomStringABC123(int length) => String.fromCharCodes(Iterable.generate(
      length, (_) => _charsABC123.codeUnitAt(_rnd.nextInt(_charsABC123.length))));

String getRandomString123(int length) => String.fromCharCodes(Iterable.generate(
      length, (_) => _chars123.codeUnitAt(_rnd.nextInt(_chars123.length))));


String generateTaskDocID() {
  String questionID = getRandomStringABC123(20);
  return questionID;
}

const appVersionNumber = '1.1.2';

const loadingWidget = SpinKitCircle(
  color: CupertinoColors.white,
);

myUID(BuildContext context){
  var user = Provider.of<User>(context, listen: false);
  var myUID = user.uid;

  return myUID;
}