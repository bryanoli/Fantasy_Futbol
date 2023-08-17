import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

import 'dart:convert';
import 'package:http/http.dart' as http;

Future<Map<String, dynamic>> callApi(String endpoint, {Map<String, dynamic>? params}) async {
  final baseUrl = 'YOUR_API_BASE_URL_HERE'; // Replace with your API base URL
  final apiKey = '8e4c13e90cmshb2e33cb92fa3787p1da5e4jsndbda7446ae7b'; // Replace with your API key
  final queryParams = params != null ? Uri(queryParameters: params).query : '';
  final url = Uri.parse('$baseUrl$endpoint?$queryParams');

  final response = await http.get(url, headers: {'x-rapidapi-key': apiKey});
  if (response.statusCode == 200) {
    return json.decode(response.body);
  } else {
    throw Exception('Failed to load data from API');
  }
}

Future<List<dynamic>> fetchData(/* Specify your parameters here */) async {
  final data = await callApi(
    'YOUR_ENDPOINT_HERE', // Replace with the specific endpoint you want to fetch from
    params: {/* Specify your query parameters here */}
  );

  // Process and return the fetched data as needed
  return data['response'];
}
