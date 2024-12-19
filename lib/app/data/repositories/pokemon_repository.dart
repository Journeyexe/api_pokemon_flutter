import 'dart:convert';
import 'package:api_pokemon/app/data/http/http_client.dart';
import 'package:api_pokemon/app/data/models/pokemon_model.dart';

abstract class IPokemonRepository {
  Future<List<PokemonModel>> getPokemon();
}

class PokemonRepository implements IPokemonRepository {
  final IHttpClient client;

  PokemonRepository({required this.client});

  @override
  Future<List<PokemonModel>> getPokemon() async {
    final List<Future<PokemonModel>> futurePokemons = [];

    for (int i = 1; i <= 151; i++) {
      futurePokemons.add(_fetchPokemon(i));
    }

    return await Future.wait(futurePokemons);
  }

  Future<PokemonModel> _fetchPokemon(int id) async {
    final response =
        await client.get(url: 'https://pokeapi.co/api/v2/pokemon/$id');
    if (response.statusCode == 200) {
      final body = jsonDecode(response.body);
      return PokemonModel.fromMap(body);
    } else {
      throw Exception('Erro ao buscar Pokémon $id');
    }
  }
}
