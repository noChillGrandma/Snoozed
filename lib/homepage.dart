// ignore_for_file: use_build_context_synchronously, avoid_function_literals_in_foreach_calls

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:smarttodo/authentication69/authentication_service69.dart';
import 'package:smarttodo/constants.dart';
import 'package:url_launcher/url_launcher.dart';


class HomePage69 extends StatefulWidget {
    const HomePage69({Key? key}) : super(key: key);

  @override
  State<HomePage69> createState() => _HomePage69State();
}

class _HomePage69State extends State<HomePage69> {

  late TextEditingController taskTitleController69 = TextEditingController();
  late TextEditingController taskDescriptionController69 = TextEditingController();
  late TextEditingController taskLinkController69 = TextEditingController();
  late TextEditingController editTaskTitleController69 = TextEditingController();
  late TextEditingController editTaskDescriptionController69 = TextEditingController();
  late TextEditingController editTaskLinkController69 = TextEditingController();
  final formKeySaveTask = GlobalKey<FormState>();
  late String taskDocID = '';
  bool isEditModeEnabled = false;

  @override
  void initState() {
    taskDocID = generateTaskDocID();
    editTaskLinkController69 = TextEditingController(text: '');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      resizeToAvoidBottomInset: false,
      navigationBar: CupertinoNavigationBar(
        automaticallyImplyLeading: false,
        border: const Border(bottom: BorderSide(color: Colors.transparent)),
        backgroundColor: const Color(0xFF28293d),
        middle: const Text('Snoozed',
          style: TextStyle(
            color: CupertinoColors.white,
            fontSize: 28,
            fontWeight: FontWeight.bold
          ),
        ),
        trailing: CupertinoButton(
          padding: const EdgeInsets.all(0),
          child: const Icon(FontAwesomeIcons.rightToBracket),
          onPressed: () {
            logoutConfirmationPrompt();
          }
        ),
      ),
      backgroundColor: const Color(0xFF28293d),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.70,
                width: MediaQuery.of(context).size.width * 1,
                child: Row(
                children: [
                  Expanded(
                    child: StreamBuilder(
                      stream: FirebaseFirestore.instance
                        .collection('users')
                        .doc(myUID(context))
                        .collection('myTasks')
                        .where('isTaskCompleted', isEqualTo: false)
                        .orderBy('dueDate')
                        .limit(1)
                        .snapshots(),
                      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                        if (snapshot.hasData && snapshot.data!.docs.isNotEmpty) {
                          return ListView.builder(
                            physics: const BouncingScrollPhysics(),
                            scrollDirection: Axis.vertical,
                            itemCount: snapshot.data?.docs.length,
                            itemBuilder: (BuildContext context, int index) {
                              QueryDocumentSnapshot<Object?>? user = snapshot.data?.docs[index];
            
                              var taskTile = user!.data().toString().contains('taskTile') ? user.get('taskTile') : '';
                              var taskDescription = user.data().toString().contains('taskDescription') ? user.get('taskDescription') : '';
                              var taskDocID = user.data().toString().contains('taskDocID') ? user.get('taskDocID') : '';
                              var timesSkipped = user.data().toString().contains('timesSkipped') ? user.get('timesSkipped') : 1;
                              var taskAttachedLink = user.data().toString().contains('taskAttachedLink') ? user.get('taskAttachedLink') : '';
                              var dueDate = user.get('dueDate');
                              var convertedDate = DateTime.parse(dueDate.toDate().toString());
                              DateTime updatedDueDate = convertedDate.add(Duration(days: timesSkipped));
                              Timestamp newDueDateTimestampFormat = Timestamp.fromDate(updatedDueDate);


                              deleteTask(){
                                FirebaseFirestore.instance
                                  .collection('users')
                                  .doc(myUID(context))
                                  .collection('myTasks')
                                  .doc(taskDocID)
                                  .delete();
                              }
        
                              markTaskAsCompleted(){
                                FirebaseFirestore.instance
                                  .collection('users')
                                  .doc(myUID(context))
                                  .collection('myTasks')
                                  .doc(taskDocID)
                                  .update({
                                    'isTaskCompleted': true
                                  });
                              }

                              skipTask(){
                                FirebaseFirestore.instance
                                .collection('users')
                                .doc(myUID(context))
                                .collection('myTasks')
                                .doc(taskDocID)
                                .update({
                                  'timesSkipped': timesSkipped + 1,
                                  'dueDate': newDueDateTimestampFormat,
                                });
                              }

                              editTask(){
                                  FirebaseFirestore.instance
                                  .collection('users')
                                  .doc(myUID(context))
                                  .collection('myTasks')
                                  .doc(taskDocID)
                                  .update({
                                    'taskTile': editTaskTitleController69.text,
                                    'taskDescription': editTaskDescriptionController69.text,
                                    'taskAttachedLink': editTaskLinkController69.text,
                                  });
                                }
                              return Builder(
                                builder: (context) {
                                  if (isEditModeEnabled == true) {
                                    return Column(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(20.0),
                                          child: Container(
                                            height: MediaQuery.of(context).size.height * 0.365,
                                            width: MediaQuery.of(context).size.width * 0.90,
                                            decoration: BoxDecoration(
                                              color: const Color.fromARGB(255, 57, 59, 85),
                                              borderRadius: const BorderRadius.all(
                                                Radius.circular(35.0),
                                              ),
                                              boxShadow: [
                                                BoxShadow(
                                                  color: CupertinoColors.black.withOpacity(0),
                                                  spreadRadius: 4,
                                                  blurRadius: 10,
                                                  offset: const Offset(0, 3),
                                                )
                                              ]
                                            ),
                                            child: Column(
                                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                                              children: [
                                                const SizedBox(height: 15,),
                                                SizedBox(
                                                  width: MediaQuery.of(context).size.width * 0.85,
                                                  child: Row(
                                                    children: [
                                                      Expanded(
                                                        child: Padding(
                                                          padding: const EdgeInsets.only(top: 0, left: 0, right: 0, bottom: 0),
                                                          child: Container(
                                                            decoration: const BoxDecoration(
                                                              color: Color.fromARGB(255, 62, 64, 93),
                                                              borderRadius: BorderRadius.all(
                                                              Radius.circular(20.0),
                                                              ),
                                                            ),
                                                            child: CupertinoTextFormFieldRow(
                                                              textCapitalization: TextCapitalization.sentences,
                                                              autovalidateMode: AutovalidateMode.onUserInteraction,
                                                              maxLength: 65,
                                                              maxLines: 1,
                                                              placeholder: 'Enter a title for this task',
                                                              decoration: const BoxDecoration(
                                                                color: Color.fromARGB(255, 62, 64, 93),
                                                                borderRadius: BorderRadius.all(
                                                                Radius.circular(20.0),
                                                                ),
                                                              ),
                                                              controller: editTaskTitleController69,
                                                              style: const TextStyle(
                                                                fontSize: 20
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                const SizedBox(height: 5,),
                                                SizedBox(
                                                  width: MediaQuery.of(context).size.width * 0.85,
                                                  child: Row(
                                                    children: [
                                                      Expanded(
                                                        child: Padding(
                                                          padding: const EdgeInsets.only(top: 0, left: 0, right: 0, bottom: 0),
                                                          child: Container(
                                                            decoration: const BoxDecoration(
                                                              color: Color.fromARGB(255, 62, 64, 93),
                                                              borderRadius: BorderRadius.all(
                                                              Radius.circular(20.0),
                                                              ),
                                                            ),
                                                            child: CupertinoTextFormFieldRow(
                                                              textCapitalization: TextCapitalization.sentences,
                                                              autovalidateMode: AutovalidateMode.onUserInteraction,
                                                              maxLength: 1000,
                                                              maxLines: 7,
                                                              placeholder: 'Enter a description for this task',
                                                              decoration: const BoxDecoration(
                                                                color: Color.fromARGB(255, 62, 64, 93),
                                                                borderRadius: BorderRadius.all(
                                                                Radius.circular(20.0),
                                                                ),
                                                              ),
                                                              controller: editTaskDescriptionController69,
                                                              style: const TextStyle(
                                                                fontSize: 20
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                const SizedBox(height: 5,),
                                                Row(
                                                  children: [
                                                    const SizedBox(width: 17,),
                                                    const Icon(FontAwesomeIcons.link,
                                                      size: 26,
                                                    ),
                                                    const SizedBox(width: 12,),
                                                    Expanded(
                                                      child: GestureDetector(
                                                        onTap: () async {
                                                        },
                                                        child: Text(taskAttachedLink,
                                                          overflow: TextOverflow.ellipsis,
                                                          style: const TextStyle(
                                                            color: Color.fromARGB(255, 60, 153, 252),
                                                            fontSize: 19,
                                                            fontWeight: FontWeight.bold,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      width: MediaQuery.of(context).size.width * 0.7,
                                                      child: Row(
                                                        children: [
                                                          Expanded(
                                                            child: Padding(
                                                              padding: const EdgeInsets.only(top: 0, left: 0, right: 0, bottom: 0),
                                                              child: Container(
                                                                decoration: const BoxDecoration(
                                                                  color: Color.fromARGB(255, 62, 64, 93),
                                                                  borderRadius: BorderRadius.all(
                                                                  Radius.circular(20.0),
                                                                  ),
                                                                ),
                                                                child: CupertinoTextFormFieldRow(
                                                                  textCapitalization: TextCapitalization.sentences,
                                                                  autovalidateMode: AutovalidateMode.onUserInteraction,
                                                                  maxLength: 500,
                                                                  maxLines: 1,
                                                                  placeholder: 'Paste a link for this task',
                                                                  decoration: const BoxDecoration(
                                                                    color: Color.fromARGB(255, 62, 64, 93),
                                                                    borderRadius: BorderRadius.all(
                                                                    Radius.circular(20.0),
                                                                    ),
                                                                  ),
                                                                  controller: editTaskLinkController69,
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    const SizedBox(width: 20,),
                                                  ],
                                                ),
                                                const SizedBox(height: 17,),
                                              ],
                                          ),
                                        ),
                                      ),
                                      Row(
                                        children: [
                                          Expanded(
                                            child: Padding(
                                              padding: const EdgeInsets.all(12.0),
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  color: const Color.fromARGB(255, 18, 18, 27),
                                                  borderRadius: const BorderRadius.all(
                                                    Radius.circular(35.0),
                                                  ),
                                       
                                                  boxShadow: [
                                                    BoxShadow(
                                                      color: CupertinoColors.black.withOpacity(0),
                                                      spreadRadius: 4,
                                                      blurRadius: 10,
                                                      offset: const Offset(0, 3),
                                                    )
                                                  ]
                                                ),
                                                child: CupertinoButton(
                                                  child: const Text('Cancel',
                                                    style: TextStyle(
                                                      fontWeight: FontWeight.bold,
                                                      color: CupertinoColors.white,
                                                      fontSize: 22
                                                    ),
                                                  ), 
                                                  onPressed: () {
                                                    setState(() {
                                                      isEditModeEnabled = false;
                                                    });
                                                  }
                                                ),
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            child: Padding(
                                              padding: const EdgeInsets.all(12.0),
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  color: CupertinoColors.white,
                                                  borderRadius: const BorderRadius.all(
                                                    Radius.circular(35.0),
                                                  ),
                                            
                                                  boxShadow: [
                                                    BoxShadow(
                                                      color: CupertinoColors.black.withOpacity(0),
                                                      spreadRadius: 4,
                                                      blurRadius: 10,
                                                      offset: const Offset(0, 3),
                                                    )
                                                  ]
                                                ),
                                                child: CupertinoButton(
                                                  child: const Text('Save',
                                                    style: TextStyle(
                                                      fontWeight: FontWeight.bold,
                                                      color: Color.fromARGB(255, 18, 18, 27),
                                                      fontSize: 22
                                                    ),
                                                  ), 
                                                  onPressed: () {
                                                    editTask();
                                                    setState(() {
                                                      isEditModeEnabled = false;
                                                    });
                                                  }
                                                ),
                                              ),
                                            ),
                                          ),
                                       
                                        ],
                                      ),
                                      ],
                                    );
                                  } else {
                                    return Column(
                                    children: [
                                      Stack(
                                        alignment: AlignmentDirectional.bottomEnd,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(20.0),
                                            child: Container(
                                              height: MediaQuery.of(context).size.height * 0.365,
                                              width: MediaQuery.of(context).size.width * 0.90,
                                              decoration: BoxDecoration(
                                                color: const Color.fromARGB(255, 57, 59, 85),
                                                borderRadius: const BorderRadius.all(
                                                  Radius.circular(35.0),
                                                ),
                                                boxShadow: [
                                                  BoxShadow(
                                                    color: CupertinoColors.black.withOpacity(0),
                                                    spreadRadius: 4,
                                                    blurRadius: 10,
                                                    offset: const Offset(0, 3),
                                                  )
                                                ]
                                              ),
                                        child: Column(
                                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                                            children: [
                                              const SizedBox(height: 20,),
                                              Padding(
                                                padding: const EdgeInsets.only(top: 8, bottom: 12, left: 15, right: 15),
                                                child: SelectableText(taskTile,
                                                textAlign: TextAlign.center,
                                                  style: const TextStyle(
                                                    fontSize: 20,
                                                    fontWeight: FontWeight.bold
                                                  ),
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(top: 5, bottom: 12, left: 12, right: 12),
                                                child: SelectableText(taskDescription,
                                                textAlign: TextAlign.start,
                                                  style: const TextStyle(
                                                    fontSize: 20,
                                                  ),
                                                  maxLines: 8,
                                                ),
                                              ),
                                              Builder(
                                                builder: (context) {
                                                  if (taskAttachedLink == '') {
                                                    return Container();
                                                  } else {
                                                    return Row(
                                                      children: [
                                                        const SizedBox(width: 17,),
                                                        const Icon(FontAwesomeIcons.link,
                                                          size: 26,
                                                        ),
                                                        const SizedBox(width: 12,),
                                                        Expanded(
                                                          child: GestureDetector(
                                                            onTap: () async {
                                                              await _launchInBrowser(Uri.parse(taskAttachedLink)); 
                                                            },
                                                            child: Text(taskAttachedLink,
                                                              overflow: TextOverflow.ellipsis,
                                                              style: const TextStyle(
                                                                color: Color.fromARGB(255, 60, 153, 252),
                                                                fontSize: 19,
                                                                fontWeight: FontWeight.bold,
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                        const SizedBox(width: 20,),
                                                      ],
                                                    );
                                                  }
                                                }
                                              ),
                                              const SizedBox(height: 17,),
                                            ],
                                        ),
                                      ),
                                    ),
                                      Positioned(
                                        right: -15,
                                        bottom: -20,
                                        child: Padding(
                                          padding: const EdgeInsets.only(top: 0, left: 0, right: 25, bottom: 28),
                                          child: Container(
                                            decoration: const BoxDecoration(
                                              color: Color.fromARGB(255, 18, 18, 27),
                                              borderRadius: BorderRadius.all(
                                                Radius.circular(35),
                                              ),
                                            ),
                                            child: Builder(
                                              builder: (context) {
                                                if (isEditModeEnabled == false) {
                                                  return CupertinoButton(
                                                  padding: const EdgeInsets.all(0),
                                                  pressedOpacity: 0.8,
                                                  child: const Icon(FontAwesomeIcons.pen,
                                                    size: 22,),
                                                  onPressed: (){
                                                    setState(() {
                                                      editTaskTitleController69.text = taskTile;
                                                      editTaskLinkController69.text = taskAttachedLink;
                                                      editTaskDescriptionController69.text = taskDescription;
                                                      isEditModeEnabled = true;
                                                    });
                                                  }
                                                );
                                                } else {
                                                  return Container();
                                                }
                                              }
                                            ),
                                          ),
                                        ),
                                      ),
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                                        children: [
                                          const SizedBox(width: 5,),
                                          Container(
                                            height: 80,
                                            width: 80,
                                            decoration: BoxDecoration(
                                              color: const Color.fromARGB(255, 18, 18, 27),
                                              borderRadius: const BorderRadius.all(
                                                Radius.circular(50.0),
                                              ),
                                              boxShadow: [
                                                BoxShadow(
                                                  color: CupertinoColors.systemGrey.withOpacity(0.05),
                                                  spreadRadius: 4,
                                                  blurRadius: 10,
                                                  offset: const Offset(0, 3),
                                                )
                                              ]
                                            ),
                                            child: CupertinoButton(
                                              child: const Icon(FontAwesomeIcons.trashCan,
                                              color: CupertinoColors.systemRed,
                                                size: 30,
                                              ),
                                              onPressed: () {
                                                deleteTask();
                                              },
                                            ),
                                          ),
                                          Column(
                                            children: [
                                              const SizedBox(height: 40,),
                                              Container(
                                                height: 100,
                                                width: 100,
                                                decoration: BoxDecoration(
                                                  color: const Color.fromARGB(255, 18, 18, 27),
                                                  borderRadius: const BorderRadius.all(
                                                    Radius.circular(50.0),
                                                  ),
                                                  boxShadow: [
                                                    BoxShadow(
                                                      color: CupertinoColors.systemGrey.withOpacity(0.05),
                                                      spreadRadius: 4,
                                                      blurRadius: 10,
                                                      offset: const Offset(0, 3),
                                                    )
                                                  ]
                                                ),
                                                child: CupertinoButton(
                                                  child: const Icon(FontAwesomeIcons.check,
                                                  color: CupertinoColors.activeGreen,
                                                    size: 55,
                                                  ),
                                                  onPressed: (){
                                                    markTaskAsCompleted();
                                                  },
                                                ),
                                              ),
                                            ],
                                          ),
                                          Container(
                                            height: 80,
                                            width: 80,
                                            decoration: BoxDecoration(
                                              color: const Color.fromARGB(255, 18, 18, 27),
                                              borderRadius: const BorderRadius.all(
                                                Radius.circular(50.0),
                                              ),
                                              boxShadow: [
                                                BoxShadow(
                                                  color: CupertinoColors.systemGrey.withOpacity(0.05),
                                                  spreadRadius: 4,
                                                  blurRadius: 10,
                                                  offset: const Offset(0, 3),
                                                )
                                              ]
                                            ),
                                            child: CupertinoButton(
                                              child: const Icon(FontAwesomeIcons.share,
                                              color: Color.fromARGB(255, 255, 179, 0),
                                                size: 30,
                                              ),
                                              onPressed: (){
                                                skipTask();
                                              },
                                            ),
                                          ),
                                          const SizedBox(width: 5,),
                                        ],
                                      ),
                                    ],
                                  );
                                  }
                                }
                              );
                            }
                          );
                        } if (snapshot.hasData && snapshot.data!.docs.isEmpty) {
                          // if the stream of data is empty
                          return Column(
                                children: [
                                  const SizedBox(height: 10,),
                                  const Image(
                                    height: 300,
                                    fit: BoxFit.fitHeight,
                                    image: AssetImage('assets/images/celebration_task_list_empty.png')
                                  ),
                                  const SizedBox(height: 30,),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: const [
                                      Text('Your task list is empty, Yay!',
                                        style: TextStyle(
                                          color: CupertinoColors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: const [
                                      Expanded(
                                        child: Padding(
                                          padding: EdgeInsets.only(left: 30, right: 30),
                                          child: Text('Add more tasks by tapping the "+" icon below',
                                            style: TextStyle(
                                              color: CupertinoColors.white,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 20,
                                            ),
                                            textAlign: TextAlign.center,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              );
                        } else {
                          // Still loading
                          return loadingWidget;
                        }
                      },
                    ),
                  ),
                ]
                ),
              )
            ],
          ),
          
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Container(
                height: 70,
                width: 70,
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 18, 18, 27),
                  borderRadius: const BorderRadius.all(
                    Radius.circular(50.0),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: CupertinoColors.systemGrey.withOpacity(0.05),
                      spreadRadius: 4,
                      blurRadius: 10,
                      offset: const Offset(0, 3),
                    )
                  ]
                ),
                child: CupertinoButton(
                  child: const Icon(FontAwesomeIcons.bars,
                  color: CupertinoColors.white,),
                  onPressed: (){
                    _showTaskListPanel(context);
                    // Navigator.push(context, CupertinoPageRoute(builder: (context) => ListOfTasks()));
                  },
                ),
              ),
              Container(
                height: 70,
                width: 70,
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 18, 18, 27),
                  borderRadius: const BorderRadius.all(
                    Radius.circular(50.0),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: CupertinoColors.systemGrey.withOpacity(0.05),
                      spreadRadius: 4,
                      blurRadius: 10,
                      offset: const Offset(0, 3),
                    )
                  ]
                ),
                child: CupertinoButton(
                  child: const Icon(FontAwesomeIcons.plus,
                  color: CupertinoColors.white,),
                  onPressed: (){
                    _showAddTaskPanel(context);
                    // Navigator.push(context, CupertinoPageRoute(builder: (context) => AddTask69()));
             
                  },
                ),
              ),
            ],
          ),
          const Text('Version $appVersionNumber',
            style: TextStyle(
              color: Color.fromARGB(255, 80, 80, 113),
              fontSize: 15,
            ),
          ),
        ],
      ),
    );
  }

Future<void> _launchInBrowser(Uri url) async {
    if (!await launchUrl(url, mode: LaunchMode.externalApplication,)) {
       Fluttertoast.showToast(
        timeInSecForIosWeb: 5,
        msg: 'Can\'t open this link, make sure it\'s like this: https://www.website.com/',
        fontSize:16
      );
    }
  }

  _showAddTaskPanel(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return GestureDetector(
          onTap: () => Navigator.of(context).pop(),
          child: Container(
            color: const Color.fromRGBO(0, 0, 0, 0.001),
            child: GestureDetector(
              onTap: () {},
              child: DraggableScrollableSheet(
                initialChildSize: 0.75,
                minChildSize: 0.2,
                builder: (_, controller) {
                  return Container(
                    height: 600,
                    decoration: const BoxDecoration(
                      color: Color(0xFF28293d),
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(25.0),
                        topRight: Radius.circular(25.0),
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        GestureDetector(
                          onVerticalDragDown: (_) {
                            FocusScope.of(context).requestFocus(FocusNode());
                          },
                          child: Column(
                            children: const [
                              SizedBox(height: 30,),
                              Text('Add New Task',
                                style: TextStyle(
                                  fontSize: 24,
                                  color: CupertinoColors.white,
                                  fontWeight: FontWeight.bold
                                ),
                              ),
                              SizedBox(height: 20,),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.45,
                          child: SingleChildScrollView(
                            child: Column(
                              children: [
                                Form(
                                  key: formKeySaveTask,
                                  child: Column(
                                    children: [
                                      SizedBox(
                                        width: MediaQuery.of(context).size.width * 0.9,
                                        child: Row(
                                          children: [
                                            Expanded(
                                              child: Padding(
                                                padding: const EdgeInsets.only(top: 0, left: 0, right: 0, bottom: 0),
                                                child: Container(
                                                  decoration: const BoxDecoration(
                                                    color: Color.fromARGB(255, 62, 64, 93),
                                                    borderRadius: BorderRadius.all(
                                                    Radius.circular(20.0),
                                                    ),
                                                  ),
                                                  child: CupertinoTextFormFieldRow(
                                                    textCapitalization: TextCapitalization.sentences,
                                                    autovalidateMode: AutovalidateMode.onUserInteraction,
                                                    maxLength: 65,
                                                    maxLines: 1,
                                                    placeholder: 'Name this task',
                                                    decoration: const BoxDecoration(
                                                      color: Color.fromARGB(255, 62, 64, 93),
                                                      borderRadius: BorderRadius.all(
                                                      Radius.circular(20.0),
                                                      ),
                                                    ),
                                                    controller: taskTitleController69,
                                                    validator: (taskTitle69) {
                                                      if (taskTitle69 == null || taskTitle69.isEmpty) {
                                                        return 'please type something first';
                                                        
                                                      } else if (taskTitle69.length < 3) {
                                                        return 'must be at least 3 characters long';
                                                        
                                                      } else {
                                                        return null;
                                                      }
                                                    }
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      const SizedBox(height: 15,),
                                      SizedBox(
                                        width: MediaQuery.of(context).size.width * 0.9,
                                        child: Row(
                                          children: [
                                            Expanded(
                                              child: Padding(
                                                padding: const EdgeInsets.only(top: 0, left: 0, right: 0, bottom: 0),
                                                child: Container(
                                                  decoration: const BoxDecoration(
                                                    color: Color.fromARGB(255, 62, 64, 93),
                                                    borderRadius: BorderRadius.all(
                                                    Radius.circular(20.0),
                                                    ),
                                                  ),
                                                  child: CupertinoTextFormFieldRow(
                                                    textCapitalization: TextCapitalization.sentences,
                                                    maxLength: 1000,
                                                    maxLines: 8,
                                                    placeholder: 'Describe this task',
                                                    decoration: const BoxDecoration(
                                                      color: Color.fromARGB(255, 62, 64, 93),
                                                      borderRadius: BorderRadius.all(
                                                      Radius.circular(20.0),
                                                      ),
                                                    ),
                                                    controller: taskDescriptionController69,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      const SizedBox(height: 15,),
                                      SizedBox(
                                        width: MediaQuery.of(context).size.width * 0.9,
                                        child: Row(
                                          children: [
                                            Expanded(
                                              child: Padding(
                                                padding: const EdgeInsets.only(top: 0, left: 0, right: 0, bottom: 0),
                                                child: Container(
                                                  decoration: const BoxDecoration(
                                                    color: Color.fromARGB(255, 62, 64, 93),
                                                    borderRadius: BorderRadius.all(
                                                    Radius.circular(20.0),
                                                    ),
                                                  ),
                                                  child: CupertinoTextFormFieldRow(
                                                    textCapitalization: TextCapitalization.sentences,
                                                    autovalidateMode: AutovalidateMode.onUserInteraction,
                                                    maxLength: 500,
                                                    maxLines: 1,
                                                    placeholder: 'Paste a link for this task',
                                                    decoration: const BoxDecoration(
                                                      color: Color.fromARGB(255, 62, 64, 93),
                                                      borderRadius: BorderRadius.all(
                                                      Radius.circular(20.0),
                                                      ),
                                                    ),
                                                    controller: taskLinkController69,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      const SizedBox(height: 15,),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Expanded(
                                            child: Padding(
                                              padding: const EdgeInsets.only(left: 70, right: 70, top: 10),
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  color: const Color.fromARGB(255, 18, 18, 27),
                                                  borderRadius: const BorderRadius.all(
                                                    Radius.circular(35.0),
                                                  ),
                                                  boxShadow: [
                                                    BoxShadow(
                                                      color: CupertinoColors.black.withOpacity(0.1),
                                                      spreadRadius: 4,
                                                      blurRadius: 10,
                                                      offset: const Offset(0, 3),
                                                    )
                                                  ]
                                                ),
                                                child: CupertinoButton(
                                                  child: const Text('Add Task',
                                                    style: TextStyle(
                                                      color: CupertinoColors.white,
                                                      fontWeight: FontWeight.bold
                                                    ),
                                                  ), 
                                                  onPressed: (){
                                                    final form = formKeySaveTask.currentState!;
                                                      if (form.validate()) {
                                                        saveTaskToFirestore();
                                                        Fluttertoast.showToast(
                                                          timeInSecForIosWeb: 3,
                                                          msg: 'Task added!',
                                                          fontSize:16
                                                        );
                                                                                    
                                                        taskTitleController69.clear();
                                                        taskDescriptionController69.clear();
                                                        taskLinkController69.clear();
                                          
                                                        setState(() {
                                                          taskDocID = generateTaskDocID();
                                                        });
                                                      } else{
                                                                              
                                                      }
                                                  }
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
        );
      },
    );
  }


  _showTaskListPanel(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return GestureDetector(
          onTap: () => Navigator.of(context).pop(),
          child: Container(
            color: const Color.fromRGBO(0, 0, 0, 0.001),
            child: GestureDetector(
              onTap: () {},
              child: DraggableScrollableSheet(
                initialChildSize: 0.72,
                minChildSize: 0.2,
                builder: (_, controller) {
                  return Container(
                    height: 600,
                    decoration: const BoxDecoration(
                      color: Color(0xFF28293d),
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(25.0),
                        topRight: Radius.circular(25.0),
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const SizedBox(height: 15,),
                        const Text('My Tasks',
                          style: TextStyle(
                            fontSize: 24,
                            color: CupertinoColors.white,
                            fontWeight: FontWeight.bold
                          ),
                        ),
                        SizedBox(
                            height: MediaQuery.of(context).size.height * 0.55,
                            child: Padding(
                              padding: const EdgeInsets.only(top: 0, bottom: 0, left: 0, right: 8),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: StreamBuilder(
                                        stream: FirebaseFirestore.instance
                                          .collection('users')
                                          .doc(myUID(context))
                                          .collection('myTasks')
                                          // .where('isTaskCompleted', isEqualTo: false)
                                          .orderBy('isTaskCompleted')
                                          .snapshots(),
                                        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                                          if (snapshot.hasData && snapshot.data!.docs.isNotEmpty) {
                                            return ListView.builder(
                                              physics: const BouncingScrollPhysics(),
                                              scrollDirection: Axis.vertical,
                                              itemCount: snapshot.data?.docs.length,
                                              itemBuilder: (BuildContext context, int index) {
                                                QueryDocumentSnapshot<Object?>? user = snapshot.data?.docs[index];
                          
                                                var taskTile = user!.data().toString().contains('taskTile') ? user.get('taskTile') : '';
                                                var taskDocID = user.data().toString().contains('taskDocID') ? user.get('taskDocID') : '';
                                                var isTaskCompleted = user.data().toString().contains('isTaskCompleted') ? user.get('isTaskCompleted') : false;
                  
                                                return Column(
                                                  children: [
                                                    Slidable(
                                                      key: const ValueKey(0),
                                                      endActionPane:  ActionPane(
                                                      motion: const StretchMotion(),
                                                      children: [
                                                        SlidableAction(
                                                          autoClose: true,
                                                          onPressed: (BuildContext context) async {
                                                            FirebaseFirestore.instance
                                                            .collection('users')
                                                            .doc(myUID(context))
                                                            .collection('myTasks')
                                                            .doc(taskDocID)
                                                            .delete();
                                                          },
                                                          backgroundColor: CupertinoColors.systemRed,
                                                          foregroundColor: Colors.white,
                                                          icon: FontAwesomeIcons.trashCan,
                                                          borderRadius: const BorderRadius.all(Radius.circular(5.0)),
                                                        ),
                                                      ],
                                                    ),
                                                      child: Builder(
                                                        builder: (context) {
                                                          if (isTaskCompleted == false) {
                                                            return Row(
                                                            children: [
                                                              Expanded(
                                                                child: GestureDetector(
                                                              onTap: () {
                                                                FirebaseFirestore.instance
                                                                  .collection('users')
                                                                  .doc(myUID(context))
                                                                  .collection('myTasks')
                                                                  .doc(taskDocID)
                                                                  .update({
                                                                    'isTaskCompleted': true,
                                                                  });
                                                              },
                                                              child: Padding(
                                                                padding: const EdgeInsets.all(5),
                                                                child: Row(
                                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                  children: [
                                                                    Padding(
                                                                      padding: const EdgeInsets.only(top: 0, bottom: 0, left: 5, right: 5),
                                                                      child: Column(
                                                                        children: [
                                                                          SizedBox(
                                                                            width: 30,
                                                                            height: 30,
                                                                            child: Row(
                                                                              mainAxisAlignment: MainAxisAlignment.center,
                                                                              children: const [
                                                                                Icon(FontAwesomeIcons.circle,
                                                                                  size: 26,
                                                                                  
                                                                                )
                                                                              ],
                                                                            ),
                                                                          ),
                                                                        ],
                                                                      ),
                                                                    ),
                                                                    Expanded(
                                                                      child: GestureDetector(
                                                                        onTap: () {
                                                                          FirebaseFirestore.instance
                                                                          .collection('users')
                                                                          .doc(myUID(context))
                                                                          .collection('myTasks')
                                                                          .doc(taskDocID)
                                                                          .update({
                                                                            'isTaskCompleted': true,
                                                                          });
                                                                        },
                                                                        child: Column(
                                                                          crossAxisAlignment: CrossAxisAlignment.start,
                                                                          children: [
                                                                            Text(taskTile,
                                                                              style: const TextStyle(
                                                                                color: CupertinoColors.white,
                                                                                fontWeight: FontWeight.bold,
                                                                              ),
                                                                              maxLines: 1,
                                                                              overflow: TextOverflow.ellipsis,
                                                                            ),
                                                                          ],
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                                ),
                                                              ),
                                                            ],
                                                          );
                                                            
                                                          } else {
                                                            return Row(
                                                              children: [
                                                                Expanded(
                                                                  child: GestureDetector(
                                                                onTap: () {
                                                                FirebaseFirestore.instance
                                                                  .collection('users')
                                                                  .doc(myUID(context))
                                                                  .collection('myTasks')
                                                                  .doc(taskDocID)
                                                                  .update({
                                                                    'isTaskCompleted': false,
                                                                  });
                                                                },
                                                                child: Padding(
                                                                  padding: const EdgeInsets.all(5),
                                                                  child: Row(
                                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                    children: [
                                                                      Padding(
                                                                        padding: const EdgeInsets.only(top: 0, bottom: 0, left: 5, right: 5),
                                                                        child: Column(
                                                                          children: [
                                                                            SizedBox(
                                                                              width: 30,
                                                                              height: 30,
                                                                              child: Row(
                                                                                mainAxisAlignment: MainAxisAlignment.center,
                                                                                children: const [
                                                                                  Icon(FontAwesomeIcons.solidCircleCheck,
                                                                                    color: CupertinoColors.activeGreen,
                                                                                    size: 26,
                                                                                  )
                                                                                ],
                                                                              ),
                                                                            ),
                                                                          ],
                                                                        ),
                                                                      ),
                                                                      Expanded(
                                                                        child: GestureDetector(
                                                                          onTap: () {
                                                                            // do something when clicking on it
                                                                    
                                                                          },
                                                                          child: Column(
                                                                            crossAxisAlignment: CrossAxisAlignment.start,
                                                                            children: [
                                                                              Text(taskTile,
                                                                                style: const TextStyle(
                                                                                  decoration: TextDecoration.lineThrough,
                                                                                  fontWeight: FontWeight.bold,
                                                                                  color: CupertinoColors.white,
                                                                                ),
                                                                                maxLines: 1,
                                                                                overflow: TextOverflow.ellipsis,
                                                                              ),
                                                                            ],
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ),
                                                                  ),
                                                                ),
                                                              ],
                                                            );
                                                          }
                                                        }
                                                      ),
                                                    ),
                                                    const Divider()
                                                  ],
                                                );
                                              }
                                            );
                                          } if (snapshot.hasData && snapshot.data!.docs.isEmpty) {
                                            // if the stream of data is empty
                                            return const Center(
                                              child: Text('no tasks to show'),
                                            );
                                          } else {
                                            // Still loading
                                            return loadingWidget;
                                          }
                                        },
                                      ),
                                    ),
                                  ),
                                ]
                              ),
                            ),
                          ),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: CupertinoColors.activeGreen,
                                    borderRadius: const BorderRadius.all(
                                      Radius.circular(35.0),
                                    ),
                                    boxShadow: [
                                      BoxShadow(
                                        color: CupertinoColors.black.withOpacity(0.1),
                                        spreadRadius: 4,
                                        blurRadius: 10,
                                        offset: const Offset(0, 3),
                                      )
                                    ]
                                  ),
                                  child: CupertinoButton(
                                    // padding: EdgeInsets.all(8),
                                    child: const Text('Remove Completed',
                                      style: TextStyle(
                                        color: CupertinoColors.white,
                                        fontWeight: FontWeight.bold
                                      ),
                                    ), 
                                    onPressed: () {
                                      deleteCompletedTasks();
                                    }
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 25,
                        )
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
        );
      },
    );
  }

  saveTaskToFirestore(){
    FirebaseFirestore.instance
    .collection('users')
    .doc(myUID(context))
    .collection('myTasks')
    .doc(taskDocID)
    .set({
      'taskTile': taskTitleController69.text,
      'taskDescription': taskDescriptionController69.text,
      'taskAttachedLink': taskLinkController69.text,
      'taskDocID': taskDocID,
      'dueDate': Timestamp.now(),
      'isTaskCompleted': false,
      'timesSkipped': 1,
    });
  }


  deleteCompletedTasks() async {
    CollectionReference ref = 
    FirebaseFirestore.instance
      .collection('users')
      .doc(myUID(context))
      .collection('myTasks');

    QuerySnapshot eventsQuery = await ref.where('isTaskCompleted', isEqualTo: true).get();

    eventsQuery.docs.forEach((value) {
    value.reference.delete();
    });
  }

  logoutConfirmationPrompt(){
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



}

