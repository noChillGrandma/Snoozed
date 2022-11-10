import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:smarttodo/models/app_user.dart';


class DatabaseService {

  final String uid;
  DatabaseService({ required this.uid });

  // collection reference
  final CollectionReference usersCollection = FirebaseFirestore.instance.collection('users');


  Future<void> updateUserData(
    Timestamp joinDate,
    ) async {
    return await usersCollection.doc(uid).set({
      'joinDate': joinDate,
    });
  }

  // users list from snapshot
  List<AppUser> _usersListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc){
      //print(doc.data);
      return AppUser(
        username: doc.get('username') ?? '', 
        uid: '',
      );
    }).toList();
  }

  // user data from snapshots
  AppUser _userDataFromSnapshot(DocumentSnapshot snapshot) {
    return AppUser(
      uid: uid,
      username: snapshot.get('username'),

    );
  }

  // get brews stream
  Stream<List<AppUser>> get users {
    return usersCollection.snapshots()
      .map(_usersListFromSnapshot);
  }

  // get user doc stream
  Stream<AppUser> get userData {
    return usersCollection.doc(uid).snapshots()
      .map(_userDataFromSnapshot);
  }

}