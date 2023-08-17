import 'dart:convert';

import 'package:fantasy_futbol/api/card_api.dart';
import 'package:fantasy_futbol/widgets/menunav.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  const HomePage ({Key?key}) : super(key:key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  final user = FirebaseAuth.instance.currentUser;
  final String apiKey = '8e4c13e90cmshb2e33cb92fa3787p1da5e4jsndbda7446ae7b';
  final String apiUrl = 'https://api-football-v1.p.rapidapi.com/v3/players';

  Future<Map<String, dynamic>> getPlayerStatistics(int playerId, int season) async {
    
    
    final response = await http.get(
      Uri.parse(apiUrl).replace(queryParameters: 
      {
        'id': playerId.toString(), 
        'season': season.toString()}
        ),
      headers: {
        'X-RapidAPI-Key': apiKey,
        'X-RapidAPI-Host': 'api-football-v1.p.rapidapi.com',
      },
      // Add your query parameters here

      
    );

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load data');
    }
  }

  // Extracted method to display player statistics
  Widget buildPlayerStatistics(Map<String, dynamic> playerData) {
    final statistics = playerData['response'][0]['statistics'][0];
    final playerName = playerData['response'][0]['player']['name'];

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text('Player Name: $playerName'),
        Text('Total Shots: ${statistics['shots']?['total'] ?? 'N/A'}'),
        Text('Goals: ${statistics['shots']?['goals']?['total'] ?? 'N/A'}'),
        Text('Assists: ${statistics['shots']?['assists'] ?? 'N/A'}'),

        // You can add more Text widgets here for other statistics
      ],
    );
  }

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
        child: FutureBuilder<Map<String, dynamic>>(
          future: getPlayerStatistics(276, 2022),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator();
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else {
              // Display player statistics
              return buildPlayerStatistics(snapshot.data!);
            }
          },
        ),
      ),
 );



  }



}
    // body: Center(
    //   child:Column(
    //     mainAxisAlignment: MainAxisAlignment.center,
    //     children: [
    //       Text('Signed in as: ' + user!.email!),
    //       MaterialButton(onPressed: (){
    //         FirebaseAuth.instance.signOut();
    //       },
    //       color: Colors.deepPurple,
    //       child: const Text('sign out'),
    //       )
    //     ],
    //   ),
    //   ),

 