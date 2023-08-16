import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class RegisterPage extends StatefulWidget {
  final VoidCallback showLoginPage;
  const RegisterPage({Key? key, required this.showLoginPage}): super(key:key);


  @override
  State<RegisterPage> createState() => RegisterPagetState();
}

class RegisterPagetState extends State<RegisterPage> {

  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmpasswordController = TextEditingController();

  @override
  void dispose(){
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  Future signUp() async {
    if (passwordConfirmed()){
      
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: emailController.text.trim(), 
      password: passwordController.text.trim()
      );
    }
    
  }

  bool passwordConfirmed(){
    if (confirmpasswordController.text.trim() == passwordController.text.trim()){
      return true;
    } else { 
      return false;
    }
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
          const SizedBox(height:10),
          const Text('Register below with your details',
          style: TextStyle(
            fontSize: 18,
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
          child: TextField(
            obscureText: true,
            controller: confirmpasswordController,
            decoration: InputDecoration(
              enabledBorder: OutlineInputBorder(
                borderSide: const BorderSide(color:Colors.deepPurple),
                borderRadius: BorderRadius.circular(12),
                ),
                hintText: 'Confirm Password',
                fillColor: Colors.grey[200],
                filled: true,
            ),
          ),
          
          ),
          const SizedBox(height:10),
          
          Padding(padding: const EdgeInsets.symmetric(horizontal:25.0),
          child: GestureDetector(
            onTap: signUp,
            child: Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.deepPurple,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Center(
                  child: Text(
                    'Sign Up',
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
                const Text('Member?',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
                ),
                GestureDetector(
                  onTap: widget.showLoginPage,
                  child: const Text(' Login Now!',
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