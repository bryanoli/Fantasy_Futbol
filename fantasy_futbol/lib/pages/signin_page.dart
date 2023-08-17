import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SigninPage extends StatefulWidget {
  final VoidCallback showRegisterPage;
  const SigninPage({Key?key, required this.showRegisterPage}): super(key:key);



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
            const SizedBox(height:75),
  

          Text('Fantasy Futbol',
            style: GoogleFonts.bonaNova(
              fontSize: 52,
            ),
          ),
          const SizedBox(height: 50),

          Padding(padding: const EdgeInsets.symmetric(horizontal:25.0),
          child: TextField(
            controller: emailController,
            decoration: InputDecoration(
              enabledBorder: OutlineInputBorder(
                borderSide: const BorderSide(color:Colors.deepPurple),
                borderRadius: BorderRadius.circular(12),
                ),
                hintText: 'Email',
                fillColor: Colors.grey[200],
                filled: true,
            ),
          ),
          
          ),
        const SizedBox(height:10),
        
        Padding(padding: const EdgeInsets.symmetric(horizontal:25.0),
          child: TextField(
            obscureText: true,
            controller: passwordController,
            decoration: InputDecoration(
              enabledBorder: OutlineInputBorder(
                borderSide: const BorderSide(color:Colors.deepPurple),
                borderRadius: BorderRadius.circular(12),
                ),
                hintText: 'Password',
                fillColor: Colors.grey[200],
                filled: true,
            ),
          ),
          
          ),
          const SizedBox(height:10),
          
          Padding(padding: const EdgeInsets.symmetric(horizontal:25.0),
          child: GestureDetector(
            onTap: signIn,
            child: Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.deepPurple,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Center(
                  child: Text(
                    'Sign In',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 18
                    ),
                  ),
                ),
               ),
          ),
            ),
            const SizedBox(height: 25,),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('Not a member?',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
                ),
                GestureDetector(
                  onTap: widget.showRegisterPage,
                  child: const Text(' Register Now!',
                  style: TextStyle(
                    color: Colors.blue,
                    fontWeight: FontWeight.bold,
                  ),
                  ),
                ),
              ],
            )
          ],
          ),
        )
      ),
  
    );
  }
}