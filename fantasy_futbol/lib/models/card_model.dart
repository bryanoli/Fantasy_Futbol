import 'package:flutter/material.dart';
import 'package:fantasy_futbol/api/card_api.dart';

class Player {
  final String name;
  final String team;
  final String imageUrl;

  Player({
    required this.name,
    required this.team,
    required this.imageUrl,
  });
}

class PlayerCardModel extends StatelessWidget{
  final Player player;
  final ApiManager apiManager;

  PlayerCardModel({
    required this.player,
    required this.apiManager,
  });
  
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.blue, width: 2),
        ),
        child: Column(
          children: [
            Image.network(player.imageUrl), // Display the player's image
            Text(player.name), // Display the player's name
            Text(player.team), // Display the player's team
            // Add more widgets to display other player information if needed
          ],
        ),
      ),
    );
  }
}

// class PlayerList extends StatelessWidget {
//   final List<Player> players;
//   final ApiManager apiManager;

//   const PlayerList({super.key, required this.players, required this.apiManager, required int league, required int season});

//   @override
//   Widget build(BuildContext context) {
//     return ListView.builder(
//       itemCount: players.length,
//       itemBuilder: (context, index) {
//         final player = players[index];
//         return PlayerCardModel(
//           player: player,
//           isBeingDragged: false,
//           apiManager: apiManager,
//         );
//       },
//     );
//   }
// }

