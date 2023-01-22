import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pokeapi_fernando_avila/style/theme.dart';
import 'package:pokeapi_fernando_avila/viewmodels/pokemon_vm.dart';
import 'package:provider/provider.dart';

class Buttonpokemon extends StatelessWidget {
  const Buttonpokemon({Key? key, this.pokemon}) : super(key: key);

  final pokemon;
  @override
  Widget build(BuildContext context) {
//    print(pokemon.types[0].type.name);
    var colors = design(pokemon.types[0].type.name);
    return Container(
      width: 100,
      padding: const EdgeInsets.symmetric(horizontal: 5),
      child: InkWell(
        onTap: () {
          Provider.of<PokemonViewModel>(context, listen: false)
              .selectPokemon(pokemon);
        },
        child: Stack(
          children: [
            Positioned(
                child: Opacity(
              opacity: 1,
              child: Container(
                height: 50,
                width: MediaQuery.of(context).size.width * 0.3,
                margin: const EdgeInsets.fromLTRB(0, 10, 10, 5),
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                    gradient: LinearGradient(colors: [
                      colors.surface,
                      colors.primary,
                      colors.surface,
                      colors.primary
                    ], begin: Alignment.topLeft, end: Alignment.bottomRight),
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: kElevationToShadow[4],
                    border: Border.all(color: colors.surface, width: 2)),
              ),
            )),
            Positioned(
              right: 0,
              bottom: 0,
              child: SvgPicture.network(
                pokemon.sprites.other.dreamWorld.frontDefault,
                height: 60,
                width: MediaQuery.of(context).size.width * 0.15,
                fit: BoxFit.cover,
              ),
            ),
            Positioned(
                child: Container(
                    height: 50,
                    width: MediaQuery.of(context).size.width * 0.15,
                    margin: const EdgeInsets.fromLTRB(0, 10, 60, 5),
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        color: Colors.transparent,
                        borderRadius: BorderRadius.circular(10)),
                    child: AutoSizeText(
                      pokemon.name.toUpperCase(),
                      style: const TextStyle(
                          fontSize: 16,
                          color: Colors.black,
                          fontWeight: FontWeight.bold),
                      maxLines: 1,
                    ))),
          ],
        ),
      ),
    );
  }
}
