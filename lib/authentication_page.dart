// ignore_for_file: prefer_const_constructors

import 'package:flutter/cupertino.dart';
import 'package:smarttodo/sign_in.dart';
import 'package:smarttodo/sign_up.dart';

class AuthenticationPage69 extends StatefulWidget {
  const AuthenticationPage69({Key? key}) : super(key: key);

  @override
  State<AuthenticationPage69> createState() => _AuthenticationPage69State();
}

class _AuthenticationPage69State extends State<AuthenticationPage69> {
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      child: Container(
        height: MediaQuery.of(context).size.height * 1,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: const [
              Color.fromARGB(255, 55, 57, 86),
              Color.fromARGB(255, 25, 26, 39),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Snoozed',
              style: TextStyle(
                fontSize: 45,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 170,),

            Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: const BorderRadius.all(
                          Radius.circular(35.0),
                        ),
                        border: Border.all(
                          color: CupertinoColors.white,
                          width: 2,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: CupertinoColors.black.withOpacity(0),
                            spreadRadius: 4,
                            blurRadius: 10,
                            offset: Offset(0, 3),
                          )
                        ]
                      ),
                      child: CupertinoButton(
                        child: Text('Login',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: CupertinoColors.white,
                            fontSize: 22
                          ),
                        ), 
                        onPressed: () {
                          Navigator.push(context, CupertinoPageRoute(builder: (context) => SignIn69()));
                        }
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Row(
              children: [
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
                            color: CupertinoColors.black.withOpacity(0.1),
                            spreadRadius: 4,
                            blurRadius: 10,
                            offset: Offset(0, 3),
                          )
                        ]
                      ),
                      child: CupertinoButton(
                        child: Text('Sign Up',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Color.fromARGB(255, 25, 26, 39),
                            fontSize: 22
                          ),
                        ), 
                        onPressed: () {
                          Navigator.push(context, CupertinoPageRoute(builder: (context) => SignUp69()));
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
    );
  }
}

