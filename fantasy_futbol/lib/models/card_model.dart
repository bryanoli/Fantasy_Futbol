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
  final bool isBeingDragged;
  final ApiManager apiManager;

  PlayerCardModel({
    required this.player,
    required this.isBeingDragged,
    required this.apiManager,
  });
  
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: isBeingDragged ? Border.all(color: Colors.blue, width: 2) : null,
      ),
      child: Column(
        children: [
          FutureBuilder<List<dynamic>>(
            future: apiManager.fetchPlayersData(39, 2023), // Pass the appropriate league and season
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return CircularProgressIndicator();
              } else if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              } else if (snapshot.hasData) {
                final playerDataList = snapshot.data;
                final playerData = playerDataList?[0];
                final playerImage = playerData['player']['photo'];

                return Image.network(playerImage);
              } else {
                return Text('No data available');
              }
            },
          ),
          Text(player.name),
          Text(player.team),
        ],
      ),
    );
  }
}

class PlayerList extends StatelessWidget {
  final List<Player> players;
  final ApiManager apiManager;

  const PlayerList({super.key, required this.players, required this.apiManager, required int league, required int season});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: players.length,
      itemBuilder: (context, index) {
        final player = players[index];
        return PlayerCardModel(
          player: player,
          isBeingDragged: false,
          apiManager: apiManager,
        );
      },
    );
  }
}

