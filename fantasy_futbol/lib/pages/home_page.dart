import 'dart:convert';


import 'package:fantasy_futbol/api/card_api.dart';
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


Future<List<dynamic>> _fetchPlayersData() async {
  int league, season;

  if (int.tryParse(leagueController.text) != null) {
    league = int.parse(leagueController.text);
  } else {
    
    return [];
  }

  if (int.tryParse(seasonController.text) != null) {
    season = int.parse(seasonController.text);
  } else {
    
    return [];
  }

  return apiManager.fetchPlayersData(league, season);
}

Future<void> _handleSearch() async {
  final league = int.tryParse(leagueController.text);
  final season = int.tryParse(seasonController.text);

  if (league != null && season != null) {
    setState(() {
      areLeagueAndSeasonEntered = true;
    });
  } else {
    setState(() {
      areLeagueAndSeasonEntered = false;
    });
  }
}


  TextEditingController leagueController = TextEditingController();
  TextEditingController seasonController = TextEditingController();
  bool areLeagueAndSeasonEntered = false;
  
  bool isDark = false;

  ApiManager apiManager = ApiManager();


  Player? selectedPlayer;

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
      child: Column(
        children: [
          Row(
            children: [
              if (selectedPlayer != null)
            PlayerCardModel(
              player: selectedPlayer!,
              apiManager: ApiManager(), // Initialize ApiManager properly
            ),
              Expanded(
                child: TextFormField(
                  controller: leagueController,
                  decoration: InputDecoration(labelText: 'League'),
                  onEditingComplete: _handleSearch,
                ),
              ),
              SizedBox(width: 16.0),
              Expanded(
                child: TextFormField(
                  controller: seasonController,
                  decoration: InputDecoration(labelText: 'Season'),
                  onEditingComplete: _handleSearch,
                ),
              ),
            ],
          ),
          FutureBuilder<List<dynamic>>(
            future: _fetchPlayersData(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return CircularProgressIndicator();
              } else if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              } else if (snapshot.hasData) {
                final players = snapshot.data;
                
                
              return SearchAnchor(
                  builder: (BuildContext context, SearchController controller) {
                    return SearchBar(
              controller: controller,
              padding: const MaterialStatePropertyAll<EdgeInsets>(
                  EdgeInsets.symmetric(horizontal: 16.0)),
              onTap: () {
                controller.openView();
              },
              onChanged: (_) {
                controller.openView();
              },
              leading: const Icon(Icons.search),
              trailing: <Widget>[
                Tooltip(
                  message: 'Change brightness mode',
                  child: IconButton(
                    isSelected: isDark,
                    onPressed: () {
                      setState(() {
                        isDark = !isDark;
                      });
                    },
                        icon: const Icon(Icons.wb_sunny_outlined),
                        selectedIcon: const Icon(Icons.brightness_2_outlined),
                          ),
                        ),
                      ],
                    );
                    
                  },
                  suggestionsBuilder: (BuildContext context, SearchController controller) {
                  print(players);
                  if (!areLeagueAndSeasonEntered) {
                     return []; // Return an empty list when league and season are not entered
                    }
                    final filteredSuggestions = players!
                            .where((player) =>
                                player['player']['name']
                                    .toLowerCase()
                                    .contains(controller.text.toLowerCase())) // Filter suggestions based on user input
                            .map((player) {
                              return ListTile(
                                title: Text(player['player']['name']),  // Use the appropriate property from your Player class
                                onTap: () {
                                  setState(() {
                                    final playerName = player['player']['name'];
                                    final teamName = player['statistics'][0]['team']['name'];
                                    final imageUrl = player['player']['photo'];
                                    selectedPlayer = Player(
                                      name: playerName,
                                      team: teamName,
                                      imageUrl: imageUrl,
                                    );
                                    controller.closeView(player['player']['name']);  // Use the appropriate property from your Player class
                                  });
                                },
                              );
                            })
                            .toList();

                        return filteredSuggestions;
                      });
              } else {
                return Text('No data available');
              }
            },
          ),
        ],
      ),
    ),
 );



  }



}
