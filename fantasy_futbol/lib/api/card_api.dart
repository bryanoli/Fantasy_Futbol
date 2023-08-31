
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:fantasy_futbol/models/card_model.dart';

class ApiManager {
  final String apiKey = '8e4c13e90cmshb2e33cb92fa3787p1da5e4jsndbda7446ae7b';
  final String apiUrl = 'https://api-football-v1.p.rapidapi.com/v3/players';

  Future<Map<String, dynamic>> callApi(String endpoint, Map<String, dynamic> params) async {
    final response = await http.get(
      Uri.parse(apiUrl).replace(queryParameters: params),
      headers: {
        'x-rapidapi-key': apiKey,
        'X-RapidAPI-Host': 'api-football-v1.p.rapidapi.com',
      },
    );

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

  List<Player> buildPlayerStatistics(Map<String, dynamic> playerData) {
    final statistics = playerData['response'][0]['statistics'][0];
    final playerName = playerData['response'][0]['player']['name'];
    final playerImage = playerData['response'][0]['player']['photo'];
    final teamName = playerData['response'][0]['statistics'][0]['team']['name'];

    
  final playerCards = [
    Player(
      name: playerName,
      imageUrl: playerImage, 
      team: teamName,
      
    ),
    // Add more PlayerCard instances for other statistics
  ];

  return playerCards;
  }
}