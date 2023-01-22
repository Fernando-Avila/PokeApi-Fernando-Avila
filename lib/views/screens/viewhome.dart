import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pokeapi_fernando_avila/repository/services.dart';
import 'package:pokeapi_fernando_avila/viewmodels/pokemon_vm.dart';
import 'package:pokeapi_fernando_avila/views/screens/home.dart';
import 'package:provider/provider.dart';

class Viewhome extends StatelessWidget {
  Viewhome({Key? key}) : super(key: key);
  final PokemonViewModel viewModel = PokemonViewModel();
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
        body: FutureBuilder(
            future: viewModel.getPagination(),
            builder: (context, snapshot) {
              return CustomScrollView(
                controller: viewModel.scrollController,
                physics: const BouncingScrollPhysics(),
                slivers: [
                  Consumer<PokemonViewModel>(
                      builder: (context, viewModel, child) {
                    return SliverAppBar(
                      title: Text(viewModel.pagination.results.isEmpty
                          ? ''
                          : viewModel.pagination.results[0].name!),
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
                            /*Expanded(
                                child: Buttonpokemon(
                                  url:
                                      'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/dream-world/9.svg',
                                  name: Provider.of<PokemonViewModel>(context,
                                              listen: false)
                                          .pagination
                                          .results
                                          .isEmpty
                                      ? ''
                                      : viewModel.pagination.results[0].name,
                                ),
                              ),*/
                          ],
                        ),
                      ),
                    );
                  }),
                  SliverFillRemaining(
                    child: Column(
                      children: <Widget>[
                        Text('Pokemon'),
                        // Text(Provider.of<PokemonViewModel>(context).data),
                        /*SizedBox(
                          height: height * 0.25,
                          child: ButonsHabilities(
                              animatedcontroller: _animatedcontroller),
                        ),*/
                        InkWell(
                          onTap: () async {
                            var value = await Services().httpGet(
                                'https://pokeapi.co/api/v2/pokemon/7/');
                            //print(value.body);
                            viewModel.getPagination();
                          },
                          child: SizedBox(
                            //padding: const EdgeInsets.symmetric(horizontal: 60),
                            height: height * 0.2,
                            width: MediaQuery.of(context).size.width,
                            child: SvgPicture.network(
                              'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/dream-world/7.svg',
                              width: MediaQuery.of(context).size.width,
                            ),
                          ),
                        ),
                        Divider(
                          color: Colors.black,
                          thickness: 2,
                        ),
                        SizedBox(height: height * 0.2, child: StatusBars())
                      ],
                    ),
                  ),
                ],
              );
            }));
  }
}
