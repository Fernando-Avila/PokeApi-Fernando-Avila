import 'package:pokeapi_fernando_avila/models/pagination_model.dart';
import 'package:pokeapi_fernando_avila/models/pokemon_model.dart';
import 'package:pokeapi_fernando_avila/repository/services.dart';

class PokemonService {
  static Future<List<PokemonModel>> getAllPokemon(String url) async {
    final response = await Services().httpGet(url);
    final json = Services().jsondecode(response.body);
    final pokemons = json['results'] as List;
    return pokemons.map((pokemon) => PokemonModel.fromJson(pokemon)).toList();
  }

  //get pagination
  static Future<PaginationModel> getPagination(String url) async {
    final response = await Services().httpGet(url);
    final json = Services().jsondecode(response.body);
    final pokemons = json['results'] as List;

    List<PokemonModel> pokemonss = [];
    for (var pokemon in pokemons) {
      pokemonss.add(await getPokemon1(pokemon['url']));
    }
    var pagination = PaginationModel.fromJson(json);
    pagination.results = pokemonss;
    return pagination;
  }

  //get pokemons with pagination
  static Future<List<PokemonModel>> getAllPokemonPagination(
      PaginationModel pagination) async {
    final response = await Services().httpGet(pagination.next);
    final json = Services().jsondecode(response.body);

    final pokemons = json['results'] as List;
    pokemons.map((pokemon) => print(pokemon));
    return pokemons.map((pokemon) => PokemonModel.fromJson(pokemon)).toList();
  }

  static Future<List<PokemonModel>> searchPokemon(String name) async {
    final response =
        await Services().httpGet('https://pokeapi.co/api/v2/pokemon/$name');
    final json = Services().jsondecode(response.body);
    final pokemons = json['results'] as List;
    return pokemons.map((pokemon) => PokemonModel.fromJson(pokemon)).toList();
  }

  //get pokemon with link
  static Future<List<PokemonModel>> getPokemon(String url) async {
    final response = await Services().httpGet(url);
    final json = Services().jsondecode(response.body);
    final pokemons = json['results'] as List;
    return pokemons.map((pokemon) => PokemonModel.fromJson(pokemon)).toList();
  }

  static Future<PokemonModel> getPokemon1(String url) async {
    final response = await Services().httpGet(url);
    final json = Services().jsondecode(response.body);
    // json['url'] = url;
    // print(json['sprites']);
    // print(json['height']);
    // print(json['weight']);
    return PokemonModel.fromJson(json);
  }
}
