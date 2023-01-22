import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pokeapi_fernando_avila/viewmodels/pokemon_vm.dart';
import 'package:provider/provider.dart';

class Pokemondetail extends StatelessWidget {
  const Pokemondetail({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Object? heroTag = ModalRoute.of(context)!.settings.arguments;
    var size = MediaQuery.of(context).size;
    return Consumer<PokemonViewModel>(builder: (context, viewModel, __) {
      return Scaffold(
        appBar: AppBar(
          elevation: 0,
          title: Text(viewModel.pokemon.name!.toUpperCase(),
              style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.onPrimary)),
          automaticallyImplyLeading: false,
          centerTitle: true,
        ),
        body: Column(
          children: [
            Container(
                height: size.height * 0.4,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Theme.of(context).colorScheme.primary,
                      Colors.white,
                    ],
                    stops: [0.6, 1],
                  ),
                ),
                child: SvgPicture.network(
                  viewModel.pokemon.sprites!.other!.dreamWorld!.frontDefault!,
                  width: MediaQuery.of(context).size.width,
                )),
            Expanded(
              child: Stack(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.white,
                          Theme.of(context).colorScheme.primary,
                        ],
                        stops: [0.0, 0.4],
                      ),
                    ),
                  ),
                  Opacity(
                    opacity: 1,
                    child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.4),
                          borderRadius: BorderRadius.all(Radius.circular(60)),
                        ),
                        margin: const EdgeInsets.only(top: 20),
                        padding: EdgeInsets.all(10),
                        child: Wrap(
                          children: <Widget>[
                            Column(
                              children: List.generate(
                                  viewModel.pokemon.types!.length,
                                  (index) => literal(
                                      'Tipo',
                                      viewModel.pokemon.types![index].type!.name
                                          .toString(),
                                      context)),
                            ),
                            literal('Altura',
                                viewModel.pokemon.height!.toString(), context),
                          ],
                        )),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    });
  }
}

Widget literal(String title, String text, context) {
  return Container(
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
              width: 2.0, color: Theme.of(context).colorScheme.surface),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(title,
                style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.onPrimary)),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(text,
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.onPrimary)),
          ),
        ],
      ));
}
