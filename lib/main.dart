import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smarttodo/authentication/services/authentication_service.dart';
import 'package:smarttodo/authentication/services/wrapper.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<AuthenticationService>(
          create: (_) => AuthenticationService(FirebaseAuth.instance),
        ),
        StreamProvider(
          create: (context) =>
            context.read<AuthenticationService>().authStateChanges, 
            initialData: null,
        ),
      ],
      child: const CupertinoApp(
        theme: CupertinoThemeData(
          barBackgroundColor: CupertinoColors.white,
          brightness: Brightness.dark,
          primaryColor: CupertinoColors.white,
          textTheme: CupertinoTextThemeData(
            primaryColor: CupertinoColors.white,
            textStyle: TextStyle(
              color: CupertinoColors.white,
              fontSize: 17,
            )
          )
        ),
        home: AuthenticationWrapper69(),
        localizationsDelegates: <LocalizationsDelegate<dynamic>>[
          DefaultMaterialLocalizations.delegate,
          DefaultWidgetsLocalizations.delegate,
        ],
      ),
    );
  }
}



