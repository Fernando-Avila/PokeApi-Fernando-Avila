import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pokeapi_fernando_avila/resources/extra.dart';
import 'package:pokeapi_fernando_avila/viewmodels/pokemon_vm.dart';
import 'package:pokeapi_fernando_avila/views/widgets/layouts/buttonhabilitie.dart';
import 'package:pokeapi_fernando_avila/views/widgets/layouts/buttonpokemon.dart';
import 'package:pokeapi_fernando_avila/views/widgets/layouts/designs.dart';
import 'package:pokeapi_fernando_avila/views/widgets/layouts/statbar.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with TickerProviderStateMixin {
  late final AnimationController _animatedcontroller = AnimationController(
    vsync: this,
    duration: Duration(milliseconds: 400),
  );

  final globalOffsetValue = ValueNotifier<double>(0);
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var height = MediaQuery.of(context).size.height;
    return Consumer<PokemonViewModel>(builder: (context, viewModel, child) {
      return Scaffold(
          body: CustomScrollView(
        controller: viewModel.scrollController,
        physics: const BouncingScrollPhysics(),
        slivers: [
          SliverAppBar(
            title: Text(
              viewModel.pokemon.name ?? 'Selecciona tu Pokemon',
              style: const TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
              ),
            ),
            centerTitle: true,
            floating: true,
            snap: true,
            pinned: true,
            stretch: true,
            expandedHeight: height * 0.15,
            flexibleSpace: FlexibleSpaceBar(
              stretchModes: const [
                StretchMode.zoomBackground,
                StretchMode.blurBackground
              ],
              background: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  SizedBox(
                    height: 100,
                    width: size.width,
                    child:
                        ButtonsPokemons(results: viewModel.pagination.results),
                  )
                ],
              ),
            ),
          ),
          SliverFillRemaining(
            child: Stack(
              children: [
                Opacity(
                  opacity: 0.3,
                  child: Container(
                    decoration: BoxDecoration(
                        gradient: LinearGradient(colors: [
                      Theme.of(context).colorScheme.primary,
                      Theme.of(context).colorScheme.surface
                    ])),
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    const Text(
                      'Habilidades',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      height: height * 0.2,
                      child: ButonsHabilities(
                          animatedcontroller: _animatedcontroller),
                    ),
                    Dvdh(),
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 20),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                      ),
                      decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.5),
                          boxShadow: [
                            BoxShadow(
                                color: Colors.black.withOpacity(0.2),
                                blurRadius: 10,
                                spreadRadius: 5)
                          ]),
                      height: height * 0.1,
                      width: size.width,
                      child: ListView.builder(
                          physics: NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) => Text(
                                Infoabilities(viewModel.abilities[index]),
                                style: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                          itemCount: viewModel.abilities.length),
                    ),
                    InkWell(
                      onTap: () async {
                        viewModel.pokemon != null
                            ? Navigator.pushNamed(context, '/detailpokemon')
                            : null;
                      },
                      child: Container(
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            boxShadow: kElevationToShadow[12],
                            gradient: LinearGradient(
                                colors: [
                                  Theme.of(context)
                                      .colorScheme
                                      .primary
                                      .withOpacity(0.9),
                                  Theme.of(context)
                                      .colorScheme
                                      .surface
                                      .withOpacity(0.9),
                                ],
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight),
                            borderRadius: BorderRadius.circular(30)),
                        height: height * 0.2,
                        width: size.width * 0.8,
                        child: viewModel.pokemon.sprites == null
                            ? const Center(
                                child: Image(
                                    image: AssetImage(
                                        'assets/images/pokeball.png')),
                              )
                            : SvgPicture.network(
                                viewModel.pokemon.sprites!.other!.dreamWorld!
                                    .frontDefault!,
                                width: MediaQuery.of(context).size.width,
                              ),
                      ),
                    ),
                    Dvdh(),
                    SizedBox(
                        height: height * 0.2,
                        child: StatusBars(viemModel: viewModel))
                  ],
                ),
              ],
            ),
          ),
        ],
      ));
    });
  }
}

class ButonsHabilities extends StatelessWidget {
  const ButonsHabilities({
    Key? key,
    required AnimationController animatedcontroller,
  })  : _animatedcontroller = animatedcontroller,
        super(key: key);

  final AnimationController _animatedcontroller;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: GridView.builder(
        physics: NeverScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3, mainAxisExtent: 60),
        itemCount: Habilities.values.length,
        itemBuilder: (BuildContext context, int index) {
          return buttonHabilitie(
            animationController: _animatedcontroller,
            habilitie: Habilities.values[index],
          );
        },
      ),
    );
  }
}

class ButtonsPokemons extends StatelessWidget {
  const ButtonsPokemons({
    Key? key,
    required this.results,
  }) : super(key: key);
  final List results;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: GridView.builder(
        physics: NeverScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3, mainAxisExtent: 60),
        itemCount: results.length,
        itemBuilder: (BuildContext context, int index) {
          return Buttonpokemon(
            pokemon: results[index],
          );
        },
      ),
    );
  }
}

class StatusBars extends StatelessWidget {
  var viemModel;
  StatusBars({Key? key, this.viemModel}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      physics: NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 1, mainAxisExtent: 40),
      itemCount: Stats.values.length,
      itemBuilder: (BuildContext context, int index) {
        return Statbar(
          statfirst: viemModel.stats[index],
          statsupdated: viemModel.newstats[index],
          stat: Stats.values[index],
        );
      },
    );
  }
}
