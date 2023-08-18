import 'dart:convert';


import 'package:fantasy_futbol/models/card_model.dart';
import 'package:fantasy_futbol/widgets/menunav.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
   
    );

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load data');
    }
  }

  // Extracted method to display player statistics
 List<playerCardModel> buildPlayerStatistics(Map<String, dynamic> playerData) {
  final statistics = playerData['response'][0]['statistics'][0];
  final playerName = playerData['response'][0]['player']['name'];
  final playerImage = playerData['response'][0]['player']['photo'];
  final teamName = playerData['response'][0]['statistics'][0]['team']['name'];
  // final statItems = [
  //   Column(
  //     children: [
  //       Image.network(playerImage), // Display player photo
  //       Text('Player Name: $playerName'),
  //       Text('Team Name: $teamName'),
  //       Text('Total Shots: ${statistics['shots']?['total'] ?? 'N/A'}'),
  //       Text('Goals: ${statistics['goals']?['total'] ?? 'N/A'}'),
  //       Text('Assists: ${statistics['assists'] ?? 'N/A'}'),
  //       Text('Saves: ${statistics['saves'] ?? 'N/A'}'),
  //       Text('Passes: ${statistics['passes']?['total'] ?? 'N/A'}'),
  //       Text('Tackles: ${statistics['tackles']?['total'] ?? 'N/A'}'),
  //       Text('Duels Total: ${statistics['duels']?['total'] ?? 'N/A'}'),
  //       Text('Dribbles Attempts: ${statistics['dribbles']?['attempts'] ?? 'N/A'}'),
  //       Text('Fouls: ${statistics['fouls'] ?? 'N/A'}'),
  //       Text('Yellow Cards: ${statistics['cards']?['yellow'] ?? 'N/A'}'),
  //       Text('Red Cards: ${statistics['cards']?['red'] ?? 'N/A'}'),
  //       Text('Penalty Won: ${statistics['penalty']?['won'] ?? 'N/A'}'),
  //       Text('Penalty Commited: ${statistics['penalty']?['commited'] ?? 'N/A'}'),
  //     ],
  //   ),
  // ];

  //  return ListView.builder(
  //   itemCount: statItems.length,
  //   itemBuilder: (context, index) {
  //     return statItems[index];
  //   },
  // );

  final playerCards = [
    playerCardModel(
      name: playerName,
      imageUrl: playerImage, 
      team: teamName,
    ),
    // Add more PlayerCard instances for other statistics
  ];

  return playerCards;

  // return ListView.builder(
  //   itemCount: statItems.length,
  //   itemBuilder: (context, index) {
  //     return statItems[index];
  //   },
  // );
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
      // Display player cards
      final playerCards = buildPlayerStatistics(snapshot.data!);
      return ListView.builder(
        itemCount: playerCards.length,
        itemBuilder: (context, index) {
          final playerCard = playerCards[index];
          return Card(
                    child: Column(
                      
                      children: [
                        Image.network(playerCard.imageUrl,
                        errorBuilder: (BuildContext context, Object exception, StackTrace? stackTrace) {
                         // Display an error icon or a placeholder image
                        return Container(
                                  width: 300,
                                  height: 300,
                                  color: Colors.grey,
                                  child: Icon(Icons.error, color: Colors.white),
                                  
                                );
                      },
                      ), // Display player photo
                        Text('Player Name: ${playerCard.name}'),
                        Text('Team Name: ${playerCard.team}'),
                      ],
                    ),
                  );
        },
      );
    }
  },
)
      ),
 );



  }



}


  