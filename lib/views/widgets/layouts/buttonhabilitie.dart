import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:pokeapi_fernando_avila/resources/extra.dart';
import 'package:pokeapi_fernando_avila/viewmodels/pokemon_vm.dart';
import 'package:provider/provider.dart';

class buttonHabilitie extends StatelessWidget with ChangeNotifier {
  buttonHabilitie(
      {super.key, required this.animationController, required this.habilitie});
  final AnimationController animationController;
  late final Animation _animationslide =
      Tween<double>(begin: 0.9, end: 1).animate(
    CurvedAnimation(
      curve: Curves.bounceOut,
      parent: animationController,
      reverseCurve: Curves.bounceIn,
    ),
  );
  final Habilities habilitie;
  @override
  Widget build(BuildContext context) {
    final _habilidades = Provider.of<PokemonViewModel>(context, listen: false);
    return AnimatedBuilder(
      animation: animationController,
      builder: (context, child) => Transform.scale(
          scale: _habilidades.abilities.contains(habilitie)
              ? _animationslide.value
              : 0.9,
          child: child),
      child: Tooltip(
        message: Infoabilities(habilitie),
        child: InkWell(
          onTap: () {
            //Provider de habilidades
            _habilidades.Selecthability(habilitie);
            animationController.forward().whenComplete(() {
              animationController.reverse();
            });
          },
          child: Stack(
            children: [
              Opacity(
                opacity: _animationslide.value,
                child: Container(
                  height: 50,
                  alignment: Alignment.center,
                  padding: const EdgeInsets.all(30),
                  decoration: BoxDecoration(
                    gradient: _design(habilitie).gradient,
                    borderRadius: BorderRadius.circular(60),
                    boxShadow: kElevationToShadow[4],
                  ),
                ),
              ),
              Container(
                  height: 50,
                  alignment: Alignment.center,
                  padding: const EdgeInsets.fromLTRB(30, 0, 10, 0),
                  child: AutoSizeText(
                    _design(habilitie).text,
                    style: const TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                    maxLines: 1,
                  )),
              _habilidades.abilities.contains(habilitie)
                  ? Positioned(
                      child: Icon(Icons.check, color: Colors.white), right: 0)
                  : SizedBox()
            ],
          ),
        ),
      ),
    );
  }
}

designHabilities _design(Habilities habilitie) {
  var map = {
    Habilities.intimidation: designHabilities(
        text: 'INTIMIDACION',
        gradient: const LinearGradient(colors: [
          //color ebd656
          Color(0xFFebd656),
          Color(0xFFdede66)
        ])),
    Habilities.immunity: designHabilities(
        text: 'INMUNIDAD',
        gradient: const LinearGradient(
            colors: [Color(0xFF2cb9c2), Color(0xFF8faedc)])),
    Habilities.power: designHabilities(
        text: 'POTENCIA',
        gradient: const LinearGradient(
            colors: [Color(0xFFff8255), Color(0xFFffc94f)])),
    Habilities.regeneration: designHabilities(
        text: 'REGENERACIÓN',
        gradient: const LinearGradient(
            colors: [Color(0xFF8a97cc), Color(0xFFf49778)])),
    Habilities.impassive: designHabilities(
        text: 'IMPASIBLE',
        gradient: const LinearGradient(
            colors: [Color(0xFFd7df72), Color(0xFF9dc880)])),
    Habilities.toxic: designHabilities(
        text: 'TOXICO',
        gradient: const LinearGradient(
            colors: [Color(0xFFee8b66), Color(0xFFf6a353)])),
  };
  return map[habilitie] ??
      designHabilities(
          text: 'TOXICO',
          gradient: const LinearGradient(
              colors: [Color(0xFFee8b66), Color(0xFFf6a353)]));
}

class designHabilities {
  String text;
  LinearGradient gradient;
  designHabilities({required this.text, required this.gradient});
}

enum Habilities {
  intimidation,
  immunity,
  power,
  regeneration,
  impassive,
  toxic,
}
