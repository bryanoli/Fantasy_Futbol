import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SigninPage extends StatefulWidget {
  const SigninPage({Key?key}): super(key:key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".



  @override
  State<SigninPage> createState() => _SigninPageState();
}

class _SigninPageState extends State<SigninPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  
  Future signIn() async{
    await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: emailController.text.trim(), 
      password: passwordController.text.trim());
  }

  @override
  void dispose(){
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      
        
      backgroundColor: Theme.of(context).colorScheme.inversePrimary,
     
      body:  SafeArea(
        child:Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Icon(
              Icons.sports_soccer_sharp,
              size: 250,
            ),
            SizedBox(height:75),
  

          Text('Fantasy Futbol',
            style: GoogleFonts.bonaNova(
              fontSize: 52,
            ),
          ),
          SizedBox(height: 50),

          Padding(padding: const EdgeInsets.symmetric(horizontal:25.0),
          child: TextField(
            decoration: InputDecoration(
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color:Colors.deepPurple),
                borderRadius: BorderRadius.circular(12),
                ),
                hintText: 'Email',
                fillColor: Colors.grey[200],
                filled: true,
            ),
          ),
          
          ),
        SizedBox(height:10),
        
        Padding(padding: const EdgeInsets.symmetric(horizontal:25.0),
          child: TextField(
            decoration: InputDecoration(
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color:Colors.deepPurple),
                borderRadius: BorderRadius.circular(12),
                ),
                hintText: 'Password',
                fillColor: Colors.grey[200],
                filled: true,
            ),
          ),
          
          ),
          SizedBox(height:10),
          
          ElevatedButton(
            onPressed: (){
              if(emailController.text.isNotEmpty && passwordController.text.length > 6){
                signIn();
              } else {
                debugPrint('Log: Email is empty or password is invalid');
              }
            }, 
            child: const Text('Login'))
          
          ],
          ),
        )
      ),
  
    );
  }
}