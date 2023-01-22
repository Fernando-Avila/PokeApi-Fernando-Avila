import 'package:flutter/material.dart';
import 'package:pokeapi_fernando_avila/models/pagination_model.dart';
import 'package:pokeapi_fernando_avila/models/pokemon_model.dart';
import 'package:pokeapi_fernando_avila/repository/pokeservice.dart';
import 'package:pokeapi_fernando_avila/style/theme.dart';
import 'package:pokeapi_fernando_avila/views/widgets/layouts/buttonhabilitie.dart';

class PokemonViewModel with ChangeNotifier {
  PokemonViewModel() {
    getPagination();
    scrollController.addListener(() async {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        await updateData();
        scrollController.animateTo(scrollController.position.minScrollExtent,
            duration: Duration(milliseconds: 600), curve: Curves.easeInOut);
      }
    });
  }

  Future<void> resetSelection() async {
    _theme = ThemeData(
        colorScheme: const ColorScheme.light(
            primary: Color(0xffee1515),
            onPrimary: Colors.white,
            surface: Colors.white,
            onSurface: Colors.black));
    _pokemon = PokemonModel();
    _stats[0] =
        Stat(baseStat: 0, effort: 0, stat: Species(name: 'hp', url: ''));
    _stats[1] =
        Stat(baseStat: 0, effort: 0, stat: Species(name: 'attack', url: ''));
    _stats[2] =
        Stat(baseStat: 0, effort: 0, stat: Species(name: 'defense', url: ''));
    _stats[3] =
        Stat(baseStat: 0, effort: 0, stat: Species(name: 'speed', url: ''));
    equalstats();
    _abilities.clear();
  }

  Future<void> updateData() async {
    final pag = await PokemonService.getPagination(_pagination.next);
    _pagination = pag;
    resetSelection();
    notifyListeners();
  }

  ScrollController scrollController = ScrollController();
  // List of Pokemon
  List<PokemonModel> _pokemons = [];
  // List of Pokemon
  List<PokemonModel> get pokemons => _pokemons;
  //Pagination
  PaginationModel _pagination = PaginationModel(
      next: 'https://pokeapi.co/api/v2/pokemon/?offset=0&limit=3',
      previous: '',
      results: []);
  PaginationModel get pagination => _pagination;
  //Pagination
  // Get all Pokemon

//get pagination
  Future<void> getPagination() async {
    print('getPagination');
    // Get all Pokemon
    // Set the list of Pokemon

    _pagination = await PokemonService.getPagination(_pagination.next);
    // Notify the listeners

    notifyListeners();
  }

  Future<void> getAllPokemon(String url) async {
    // Get all Pokemon
    final pokemons = await PokemonService.getAllPokemon(url);
    // Set the list of Pokemon
    _pokemons = pokemons;
    print(_pokemons);
    notifyListeners();
  }

  //void search 1 pokemon
  Future<void> searchPokemon(String name) async {
    // Get all Pokemon
    final pokemons = await PokemonService.searchPokemon(name);
    // Set the list of Pokemon
    _pokemons = pokemons;
    // Notify the listeners
    notifyListeners();
  }

  //get pokemon with link
  Future<void> getPokemon(String url) async {
    // Get all Pokemon
    final pokemons = await PokemonService.getPokemon(url);
    // Set the list of Pokemon
    _pokemons = pokemons;
    // Notify the listeners
    notifyListeners();
  }

  //Change habilities
  final List<Habilities> _abilities = [];
  List<Habilities> get abilities => _abilities;

  final List<Stat> _stats = [
    Stat(baseStat: 0, effort: 0, stat: Species(name: 'hp', url: '')),
    Stat(baseStat: 0, effort: 0, stat: Species(name: 'attack', url: '')),
    Stat(baseStat: 0, effort: 0, stat: Species(name: 'defense', url: '')),
    Stat(baseStat: 0, effort: 0, stat: Species(name: 'speed', url: '')),
  ];
  List<Stat> get stats => _stats;

  List<Stat> _newstats = [
    Stat(baseStat: 0, effort: 0, stat: Species(name: 'hp', url: '')),
    Stat(baseStat: 0, effort: 0, stat: Species(name: 'attack', url: '')),
    Stat(baseStat: 0, effort: 0, stat: Species(name: 'defense', url: '')),
    Stat(baseStat: 0, effort: 0, stat: Species(name: 'speed', url: '')),
  ];
  List<Stat> get newstats => _newstats;

  void Selecthability(Habilities habilitie) {
    _abilities.contains(habilitie)
        ? _abilities.remove(habilitie)
        : _abilities.length < 2
            ? _abilities.add(habilitie)
            : {};
    Updatehabilities();
    notifyListeners();
  }

  void Updatehabilities() {
    equalstats();
    for (var abilitie in _abilities) {
      switch (abilitie) {
        case Habilities.intimidation:
          _newstats[0].baseStat = _newstats[0].baseStat! - 5;
          _newstats[1].baseStat = _newstats[1].baseStat! + 10;
          _newstats[2].baseStat = _newstats[2].baseStat! - 10;
          _newstats[3].baseStat = _newstats[3].baseStat! + 15;
          break;
        case Habilities.immunity:
          _newstats[0].baseStat = _newstats[0].baseStat! + 10;
          _newstats[1].baseStat = _newstats[1].baseStat! - 20;
          _newstats[2].baseStat = _newstats[2].baseStat! + 20;
          _newstats[3].baseStat = _newstats[3].baseStat! - 10;

          break;
        case Habilities.power:
          _newstats[0].baseStat = _newstats[0].baseStat! - 20;
          _newstats[1].baseStat = _newstats[1].baseStat! + 15;
          _newstats[2].baseStat = _newstats[2].baseStat! - 10;
          _newstats[3].baseStat = _newstats[3].baseStat! + 15;
          break;
        case Habilities.regeneration:
          _newstats[0].baseStat = _newstats[0].baseStat! + 10;
          _newstats[1].baseStat = _newstats[1].baseStat! - 20;
          _newstats[2].baseStat = _newstats[2].baseStat! + 5;
          _newstats[3].baseStat = _newstats[3].baseStat! + 5;
          break;
        case Habilities.impassive:
          _newstats[0].baseStat = _newstats[0].baseStat! - 10;
          _newstats[1].baseStat = _newstats[1].baseStat! - 3;
          _newstats[2].baseStat = _newstats[2].baseStat! - 10;
          _newstats[3].baseStat = _newstats[3].baseStat! + 30;
          break;
        case Habilities.toxic:
          _newstats[0].baseStat = _newstats[0].baseStat! - 15;
          _newstats[1].baseStat = _newstats[1].baseStat! + 0;
          _newstats[2].baseStat = _newstats[2].baseStat! + 20;
          _newstats[3].baseStat = _newstats[3].baseStat! - 3;
          break;
        default:
      }
    }
  }

  //select pokemon
  PokemonModel _pokemon = PokemonModel();
  PokemonModel get pokemon => _pokemon;
  void selectPokemon(PokemonModel pokemon) {
    _pokemon = pokemon;
    var th = design(_pokemon.types![0].type!.name!);
    _stats[0] = _pokemon.stats![0];
    _stats[1] = _pokemon.stats![1];
    _stats[2] = _pokemon.stats![4];
    _stats[3] = _pokemon.stats![5];
    _abilities.clear();
    // _statsupdated = _stats;
    equalstats();
    _theme = ThemeData(
        colorScheme: ColorScheme.light(
            primary: th.primary,
            onPrimary: th.onPrimary,
            surface: th.surface,
            onSurface: th.onSurface));
    notifyListeners();
  }

  ThemeData _theme = ThemeData(
      colorScheme: const ColorScheme.light(
          primary: Color(0xffee1515),
          onPrimary: Colors.white,
          surface: Colors.white,
          onSurface: Colors.black));

  ThemeData get theme => _theme;

  void equalstats() {
    int ps = _stats[0].baseStat!;
    int at = _stats[1].baseStat!;
    int df = _stats[2].baseStat!;
    int sp = _stats[3].baseStat!;
    _newstats[0].baseStat = ps;
    _newstats[1].baseStat = at;
    _newstats[2].baseStat = df;
    _newstats[3].baseStat = sp;
  }
}
