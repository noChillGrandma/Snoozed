// ignore_for_file: use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:smarttodo/authentication/services/authentication_service.dart';
import 'package:smarttodo/shared/constants.dart';



deleteCompletedTasks(BuildContext context) async {
  QuerySnapshot eventsQuery = 
    await myTasksDBCollection(context)
    .where('isTaskCompleted', isEqualTo: true)
    .get();

  for (var value in eventsQuery.docs) {
    value.reference.delete();
  }
}




logoutConfirmationPrompt(BuildContext context){
  return showCupertinoDialog(
    context: context,
    builder: (_) {
      return CupertinoAlertDialog(
        title: const Text('Are you sure you want to logout?'),
        actions: [
          CupertinoDialogAction(
            child: const Text('Yes, logout',
              style: TextStyle(
                color: CupertinoColors.systemRed,
                fontWeight: FontWeight.bold,
                fontFamily: 'Nunito'
              ),
            ),
            onPressed: () async {
              await context.read<AuthenticationService>().signOut();
              Navigator.of(context, rootNavigator: true).pop();
            },
          ),
          CupertinoDialogAction(
            child: const Text('Cancel',
              style: TextStyle(
                color: CupertinoColors.white,
                fontWeight: FontWeight.bold,
                fontFamily: 'Nunito'
              ),
            ),
            onPressed: () async {
              Navigator.of(context, rootNavigator: true).pop();
            },
          ),
        ]
      );
    },
    barrierDismissible: true,
  );
}