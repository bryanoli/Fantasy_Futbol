import 'package:fantasy_futbol/pages/register_page.dart';
import 'package:fantasy_futbol/pages/signin_page.dart';
import 'package:flutter/material.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {

  bool showLoginPage = true;

  void toggleScreens(){
    setState(() {
      showLoginPage = !showLoginPage;  
    });
    
  }

  @override
  Widget build(BuildContext context) {
    if (showLoginPage){
      return SigninPage(showRegisterPage: toggleScreens,);
    } else {
      return RegisterPage(showLoginPage: toggleScreens,);
    }
    
  }
}