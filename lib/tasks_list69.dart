// // ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_slidable/flutter_slidable.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// import 'package:smarttodo/constants.dart';


// class ListOfTasks extends StatefulWidget {
//   ListOfTasks({Key? key}) : super(key: key);

//   @override
//   State<ListOfTasks> createState() => _ListOfTasksState();
// }

// class _ListOfTasksState extends State<ListOfTasks> {
//   @override
//   Widget build(BuildContext context) {
//     return CupertinoPageScaffold(
//       backgroundColor: CupertinoColors.systemGrey6,
//       navigationBar: const CupertinoNavigationBar(
//         middle: Text('taksk list'),

//       ),
//       child: Column(
//         children: [
//           SizedBox(height: 100,),
//           Text('pending tasks'),
//           Container(
//               height: MediaQuery.of(context).size.height * 0.3,
//               child: Padding(
//                 padding: const EdgeInsets.only(top: 8, bottom: 8, left: 0, right: 8),
//                 child: Row(
//                   children: [
//                     Expanded(
//                       child: Padding(
//                         padding: const EdgeInsets.all(8.0),
//                         child: StreamBuilder(
//                           stream: FirebaseFirestore.instance
//                             .collection('users')
//                             .doc(myUID(context))
//                             .collection('myTasks')
//                             // .where('isTaskCompleted', isEqualTo: false)
//                             .orderBy('isTaskCompleted')
//                             .snapshots(),
//                           builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
//                             if (snapshot.hasData && snapshot.data!.docs.isNotEmpty) {
//                               return ListView.builder(
//                                 physics: BouncingScrollPhysics(),
//                                 scrollDirection: Axis.vertical,
//                                 itemCount: snapshot.data?.docs.length,
//                                 itemBuilder: (BuildContext context, int index) {
//                                   QueryDocumentSnapshot<Object?>? user = snapshot.data?.docs[index];
            
//                                   var taskTile = user!.data().toString().contains('taskTile') ? user.get('taskTile') : '';
//                                   var taskDescription = user.data().toString().contains('taskDescription') ? user.get('taskDescription') : '';
//                                   var taskDocID = user.data().toString().contains('taskDocID') ? user.get('taskDocID') : '';
//                                   var isTaskCompleted = user.data().toString().contains('isTaskCompleted') ? user.get('isTaskCompleted') : false;
    

//                                   return Column(
//                                     children: [
//                                       Slidable(
//                                         key: const ValueKey(0),
//                                         endActionPane:  ActionPane(
//                                         motion: StretchMotion(),
//                                         children: [
//                                           SlidableAction(
//                                             autoClose: true,
//                                             onPressed: (BuildContext context) async {
//                                               FirebaseFirestore.instance
//                                               .collection('users')
//                                               .doc(myUID(context))
//                                               .collection('myTasks')
//                                               .doc(taskDocID)
//                                               .delete();
//                                             },
//                                             backgroundColor: CupertinoColors.systemRed,
//                                             foregroundColor: Colors.white,
//                                             icon: FontAwesomeIcons.trashCan,
//                                             borderRadius: BorderRadius.all(Radius.circular(5.0)),
//                                           ),
//                                         ],
//                                       ),
//                                         child: Builder(
//                                           builder: (context) {
//                                             if (isTaskCompleted == false) {
//                                               return Row(
//                                               children: [
//                                                 Expanded(
//                                                   child: GestureDetector(
//                                                 onTap: () {
//                                                   FirebaseFirestore.instance
//                                                     .collection('users')
//                                                     .doc(myUID(context))
//                                                     .collection('myTasks')
//                                                     .doc(taskDocID)
//                                                     .update({
//                                                       'isTaskCompleted': true,
//                                                     });
//                                                 },
//                                                 child: Padding(
//                                                   padding: const EdgeInsets.all(5),
//                                                   child: Row(
//                                                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                                     children: [
//                                                       Padding(
//                                                         padding: const EdgeInsets.only(top: 0, bottom: 0, left: 5, right: 5),
//                                                         child: Column(
//                                                           children: [
//                                                             SizedBox(
//                                                               width: 30,
//                                                               height: 30,
//                                                               child: Row(
//                                                                 mainAxisAlignment: MainAxisAlignment.center,
//                                                                 children: [
//                                                                   Icon(FontAwesomeIcons.circle,
//                                                                     size: 26,
//                                                                   )
//                                                                 ],
//                                                               ),
//                                                             ),
//                                                           ],
//                                                         ),
//                                                       ),
//                                                       Expanded(
//                                                         child: GestureDetector(
//                                                           onTap: () {
//                                                             // do something when clicking on it
                                                    
//                                                           },
//                                                           child: Column(
//                                                             crossAxisAlignment: CrossAxisAlignment.start,
//                                                             children: [
//                                                               Text(taskTile,
//                                                                 style: TextStyle(
//                                                                   fontWeight: FontWeight.bold,
//                                                                 ),
//                                                                 maxLines: 1,
//                                                                 overflow: TextOverflow.ellipsis,
//                                                               ),
//                                                             ],
//                                                           ),
//                                                         ),
//                                                       ),
//                                                     ],
//                                                   ),
//                                                 ),
//                                                   ),
//                                                 ),
//                                               ],
//                                             );
                                              
//                                             } else {
//                                               return Row(
//                                                 children: [
//                                                   Expanded(
//                                                     child: GestureDetector(
//                                                   onTap: () {
//                                                   FirebaseFirestore.instance
//                                                     .collection('users')
//                                                     .doc(myUID(context))
//                                                     .collection('myTasks')
//                                                     .doc(taskDocID)
//                                                     .update({
//                                                       'isTaskCompleted': false,
//                                                     });
//                                                   },
//                                                   child: Padding(
//                                                     padding: const EdgeInsets.all(5),
//                                                     child: Row(
//                                                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                                       children: [
//                                                         Padding(
//                                                           padding: const EdgeInsets.only(top: 0, bottom: 0, left: 5, right: 5),
//                                                           child: Column(
//                                                             children: [
//                                                               SizedBox(
//                                                                 width: 30,
//                                                                 height: 30,
//                                                                 child: Row(
//                                                                   mainAxisAlignment: MainAxisAlignment.center,
//                                                                   children: [
//                                                                     Icon(FontAwesomeIcons.solidCircleCheck,
//                                                                       color: CupertinoColors.activeGreen,
//                                                                       size: 26,
//                                                                     )
//                                                                   ],
//                                                                 ),
//                                                               ),
//                                                             ],
//                                                           ),
//                                                         ),
//                                                         Expanded(
//                                                           child: GestureDetector(
//                                                             onTap: () {
//                                                               // do something when clicking on it
                                                      
//                                                             },
//                                                             child: Column(
//                                                               crossAxisAlignment: CrossAxisAlignment.start,
//                                                               children: [
//                                                                 Text(taskTile,
//                                                                   style: TextStyle(
//                                                                     decoration: TextDecoration.lineThrough,
//                                                                     fontWeight: FontWeight.bold,
//                                                                   ),
//                                                                   maxLines: 1,
//                                                                   overflow: TextOverflow.ellipsis,
//                                                                 ),
//                                                               ],
//                                                             ),
//                                                           ),
//                                                         ),
//                                                       ],
//                                                     ),
//                                                   ),
//                                                     ),
//                                                   ),
//                                                 ],
//                                               );
//                                             }
//                                           }
//                                         ),
//                                       ),
//                                       Divider()
//                                     ],
//                                   );
//                                 }
//                               );
//                             } if (snapshot.hasData && snapshot.data!.docs.isEmpty) {
//                               // if the stream of data is empty
//                               return Center(
//                                 child: Text('no tasks to show'),
//                               );
//                             } else {
//                               // Still loading
//                               return Text('loading...');
//                             }
//                           },
//                         ),
//                       ),
//                     ),
//                   ]
//                 ),
//               ),
//             ),

//           SizedBox(height: 30,),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.end,
//             children: [
//               Padding(
//                 padding: const EdgeInsets.all(8.0),
//                 child: CupertinoButton(
//                   padding: EdgeInsets.all(8),
//                   color: CupertinoColors.black,
//                   child: Text('delete competed',
//                     style: TextStyle(
//                       color: CupertinoColors.white,
//                     ),), 
//                   onPressed: () {
//                     deleteCompletedTasks();
//                   }
//                 ),
//               ),

//             ],
//           ),
//         ],
//       )
//     );
//   }

//   deleteCompletedTasks() async {
//     CollectionReference ref = 
//     FirebaseFirestore.instance
//       .collection('users')
//       .doc(myUID(context))
//       .collection('myTasks');

//     QuerySnapshot eventsQuery = await ref.where('isTaskCompleted', isEqualTo: true).get();

//     eventsQuery.docs.forEach((value) {
//     value.reference.delete();
//     // value.reference.update({
//     // 'dateLastMessageWasSent': DateTime.now(),
//     // 'lastMessageText': 'tap to open chat',
//     // 'lastMessageSenderUID': 'sFRV3En7oZeOy3f2ZbHKLAK3FsR2',
//     // });
//     });
//   }


// }