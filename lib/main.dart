import 'package:flutter/material.dart';
import 'package:pokeapi_fernando_avila/viewmodels/pokemon_vm.dart';
import 'package:pokeapi_fernando_avila/views/screens/home.dart';
import 'package:pokeapi_fernando_avila/views/screens/pokemondetail.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp3());
}

class MyApp3 extends StatelessWidget {
  const MyApp3({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => PokemonViewModel(),
      child: Consumer(builder: (context, PokemonViewModel viewModel, child) {
        return MaterialApp(
          theme: viewModel.theme,
          routes: {
            '/': (context) => Home(),
            '/detailpokemon': (context) => Pokemondetail(),
          },
          initialRoute: '/',
        );
      }),
    );
  }
}
