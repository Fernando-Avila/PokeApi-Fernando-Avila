//class pagintation with response pokeApi
import 'package:pokeapi_fernando_avila/models/pokemon_model.dart';

class PaginationModel {
  dynamic count;
  final String next;
  final String previous;
  late List<PokemonModel> results;
  PaginationModel(
      {this.count,
      required this.next,
      required this.previous,
      required this.results});
  factory PaginationModel.fromJson(Map<String, dynamic> json) {
    return PaginationModel(
        count: json['count'],
        next: json['next'],
        previous: json['previous'] ?? '',
        results: []
        /*results: (json['results'] as List)
            .map((pokemon) => PokemonModel.fromJson(pokemon))
            .toList()*/
        );
  }
}
