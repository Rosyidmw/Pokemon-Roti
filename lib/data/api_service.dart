import 'dart:convert';

import 'package:http/http.dart' as http;

class ApiService {
  Map pokeData = {};
  List pokeList = [];

  Future<void> getData() async {
    http.Response pokeResponse;

    String urlString = "https://raw.githubusercontent.com/Biuni/PokemonGO-Pokedex/master/pokedex.json";

    Uri uri = Uri.parse(urlString);

    pokeResponse = await http.get(uri);

    if (pokeResponse.statusCode == 200) {
      pokeData = json.decode(pokeResponse.body);
      pokeList = pokeData['pokemon'];
    } else {
      throw Exception('Failed to load data');
    }
  }
}