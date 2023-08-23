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

  Future<Map<String, dynamic>> callApi(String endpoint, Map <String, dynamic> params) async {
    
    final response = await http.get(Uri.parse(apiUrl).replace(
      queryParameters: params
    ), 
    headers: {
      'x-rapidapi-key': apiKey,
      'X-RapidAPI-Host': 'api-football-v1.p.rapidapi.com',
    });
   
    

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load data');
    }
  }



  Future<List<dynamic>> fetchPlayersData(int league, int season) async {
    final params = {
      'league': league.toString(),
      'season': season.toString(),
    };

    final players = await playersData(1, params, []);

    return players;
  }


  Future<List<dynamic>> playersData(int page, Map<String, dynamic> params, List<dynamic> playersData) async {
    final playersResponse = await callApi('players', {...params, 'page': page.toString()});

    final players = playersResponse['response'] as List<dynamic>;
    playersData.addAll(players);

    final currentPage = playersResponse['paging']['current'] as int;
    final totalPages = playersResponse['paging']['total'] as int;

    if (currentPage < totalPages) {
      final nextPage = currentPage + 1;
      if (nextPage.isOdd) {
        await Future.delayed(Duration(seconds: 1));
      }

      return playersData;
    }

    return playersData;
  }

  // Extracted method to display player statistics
 List<playerCardModel> buildPlayerStatistics(Map<String, dynamic> playerData) {
  final statistics = playerData['response'][0]['statistics'][0];
  final playerName = playerData['response'][0]['player']['name'];
  final playerImage = playerData['response'][0]['player']['photo'];
  final teamName = playerData['response'][0]['statistics'][0]['team']['name'];
  

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
        child: FutureBuilder<List<dynamic>>(
   future: fetchPlayersData(39, 2023),
  builder: (context, snapshot) {
    if (snapshot.connectionState == ConnectionState.waiting) {
      return CircularProgressIndicator();

  }else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else if (snapshot.hasData) {
          final players = snapshot.data;
          return ListView.builder(
            itemCount: players?.length,
            itemBuilder: (context, index) {
              final player = players?[index];
              return ListTile(
                title: Text(player['player']['name']),
                subtitle: Text(player['statistics'][0]['team']['name']),
                leading: CircleAvatar(
                  backgroundImage: NetworkImage(player['player']['photo']),
                ),
              );
            },
          );
        } else {
          return Text('No data available');
        }
      },
)
      ),
 );



  }



}



    // } else if (snapshot.hasError) {
    //   return Text('Error: ${snapshot.error}');
    // } else {
    //   // Display player cards
    //   final playerCards = buildPlayerStatistics(snapshot.data!);
    //   return ListView.builder(
    //     itemCount: playerCards.length,
    //     itemBuilder: (context, index) {
    //       final playerCard = playerCards[index];
    //       return Card(
    //                 child: Column(
                      
    //                   children: [
    //                     Image.network(playerCard.imageUrl,
    //                   //   errorBuilder: (BuildContext context, Object exception, StackTrace? stackTrace) {
    //                   //    // Display an error icon or a placeholder image
    //                   //   return Container(
    //                   //             width: 300,
    //                   //             height: 300,
    //                   //             color: Colors.grey,
    //                   //             child: Icon(Icons.error, color: Colors.white),
                                  
    //                   //           );
    //                   // },
    //                   ), // Display player photo
    //                     Text('Player Name: ${playerCard.name}'),
    //                     Text('Team Name: ${playerCard.team}'),
    //                   ],
    //                 ),
    //               );
    //     },
    
     // );
    //}