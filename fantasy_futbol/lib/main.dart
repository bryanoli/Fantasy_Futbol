import 'package:fantasy_futbol/auth/auth_page.dart';
import 'package:fantasy_futbol/auth/main_page.dart';
import 'package:fantasy_futbol/pages/feedback_page.dart';
import 'package:fantasy_futbol/pages/setting_page.dart';
import 'package:fantasy_futbol/pages/signin_page.dart';
import 'package:fantasy_futbol/pages/squad_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: MainPage(),
      routes: {
        '/squad': (context) => squadPage(),
        '/settings': (context) => settingPage(),
        '/feedback': (context) => feedbackPage(),
        '/logout': (context) {
          FirebaseAuth.instance.signOut();
          return MainPage();
        },
      },
    );
  }
}


