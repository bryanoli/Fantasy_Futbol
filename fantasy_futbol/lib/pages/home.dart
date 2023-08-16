import 'package:fantasy_futbol/widgets/menunav.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HomePage extends StatefulWidget {
  const HomePage ({Key?key}) : super(key:key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  final user = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context){
  return Scaffold(
    appBar: AppBar(
    backgroundColor: Theme.of(context).colorScheme.inversePrimary,
    title:  Row(
      children: [
        const Icon(Icons.sports_soccer_sharp),
        const SizedBox(
          height: 10,
        ),
        Text('Fantasy Futbol',
            style: GoogleFonts.bonaNova(
              fontSize: 52,
            ),
        ),
      ],
    ),
    
    ),
    drawer: NavDrawer(),
    body: Center(
      child:Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('Signed in as: ' + user!.email!),
          MaterialButton(onPressed: (){
            FirebaseAuth.instance.signOut();
          },
          color: Colors.deepPurple,
          child: const Text('sign out'),
          )
        ],
      ),
      ),

  );



  }



}