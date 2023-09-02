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
      child: Card(
        color: Colors.amberAccent,
        shadowColor: Colors.limeAccent,
        
        elevation: 4.0,
        margin: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              height: MediaQuery.of(context).size.height*.1,
                width: MediaQuery.of(context).size.width*.1,
            ),
            CircleAvatar(
              radius: 90,
              backgroundImage: NetworkImage(player.imageUrl),
            ),
            SizedBox(
              height: 16.0,
            ),
            Text(
              player.name,
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 8.0,
            ),
            Text(
              'Team: ${player.team}',
              style: TextStyle(
                fontSize: 18.0,
              ),
            ),
            SizedBox(
              height: 16.0,
            ),
          ],
        ),
      ),
    );
  }
}

