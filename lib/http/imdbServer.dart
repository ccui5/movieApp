import 'dart:convert';
import 'package:http/http.dart' as http;

const API_KEY = "5c5cd743";
const API_URL = "http://www.omdbapi.com/?apikey=";

Future<String> getPosterById(movieId) async {
  final response = await http.get('$API_URL$API_KEY&i=$movieId');

  Map data;

  data = json.decode(response.body);

  return data['Poster'];
}
