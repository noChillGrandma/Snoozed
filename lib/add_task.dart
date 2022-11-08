// // ignore_for_file: prefer_const_constructors

// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:smarttodo/constants.dart';




// class AddTask69 extends StatefulWidget {
//   const AddTask69({Key? key}) : super(key: key);

//   @override
//   State<AddTask69> createState() => _AddTask69State();
// }

// class _AddTask69State extends State<AddTask69> {

//   late TextEditingController taskTitleController69 = TextEditingController();
//   late TextEditingController taskDescriptionController69 = TextEditingController();
//   final formKeySaveTask = GlobalKey<FormState>();
//   late String taskDocID = '';

//   @override
//   void initState() { 
//     taskDocID = generateTaskDocID();
//     super.initState();
//   }

//   @override
//   void dispose() {
   
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return CupertinoPageScaffold(
//       navigationBar: CupertinoNavigationBar(
//         middle: Text('Add Task'),

//       ),
//       child: Form(
//         key: formKeySaveTask,
//         child: Column(
//           children: [
//             SizedBox(height: 300,),
//             Text('title'),
           
//             SizedBox(
//               width: 400,
//               child: Row(
//                 children: [
//                   Expanded(
//                     child: Padding(
//                       padding: const EdgeInsets.only(top: 0, left: 20, right: 0, bottom: 0),
//                       child: Container(
//                         decoration: BoxDecoration(
//                           color: CupertinoColors.systemGrey6,
//                           borderRadius: const BorderRadius.all(
//                           Radius.circular(20.0),
//                           ),
//                         ),
//                         child: CupertinoTextFormFieldRow(
//                           textCapitalization: TextCapitalization.sentences,
//                           autovalidateMode: AutovalidateMode.onUserInteraction,
//                           maxLength: 60,
//                           minLines: null,
//                           maxLines: null,
//                           placeholder: 'Name this task',
//                           decoration: BoxDecoration(
//                             color: CupertinoColors.systemGrey6,
//                             borderRadius: const BorderRadius.all(
//                             Radius.circular(20.0),
//                             ),
//                           ),
//                           controller: taskTitleController69,
//                           validator: (taskTitle69) {
//                             if (taskTitle69 == null || taskTitle69.isEmpty) {
//                               return 'please type something first';
                              
//                             } else if (taskTitle69.length < 3) {
//                               return 'must be at least 3 characters long';
                              
//                             } else {
//                               return null;
//                             }
//                           }
//                         ),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             SizedBox(height: 15,),
//             Text('description'),
//             SizedBox(
//               width: 400,
//               child: Row(
//                 children: [
//                   Expanded(
//                     child: Padding(
//                       padding: const EdgeInsets.only(top: 0, left: 20, right: 0, bottom: 0),
//                       child: Container(
//                         decoration: BoxDecoration(
//                           color: CupertinoColors.systemGrey6,
//                           borderRadius: const BorderRadius.all(
//                           Radius.circular(20.0),
//                           ),
//                         ),
//                         child: CupertinoTextFormFieldRow(
//                           textCapitalization: TextCapitalization.sentences,
//                           maxLength: 1000,
//                           minLines: null,
//                           maxLines: null,
//                           placeholder: 'Describe this task',
//                           decoration: BoxDecoration(
//                             color: CupertinoColors.systemGrey6,
//                             borderRadius: const BorderRadius.all(
//                             Radius.circular(20.0),
//                             ),
//                           ),
//                           controller: taskDescriptionController69,
//                         ),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             SizedBox(height: 15,),
//             CupertinoButton(
//               color: CupertinoColors.black,
//               child: Text('save task'), 
//               onPressed: (){
//                  final form = formKeySaveTask.currentState!;
//                   if (form.validate()) {
//                     saveTaskToFirestore();

//                     print('task saved successfolly');

//                     taskTitleController69.clear();
//                     taskDescriptionController69.clear();

//                     setState(() {
//                       taskDocID = generateTaskDocID();
//                     });
//                   } else{
          
//                   }
//               }
//             ),
            
//           ],
//         ),
//       )
//       );
//   }


//   saveTaskToFirestore(){
//     FirebaseFirestore.instance
//     .collection('users')
//     .doc(myUID(context))
//     .collection('myTasks')
//     .doc(taskDocID)
//     .set({
//       'taskTile': taskTitleController69.text,
//       'taskDescription': taskDescriptionController69.text,
//       'taskDocID': taskDocID,
//       'dueDate': Timestamp.now(),
//       'isTaskCompleted': false,
//       'timesSkipped': 1,
//     });
//   }






// }