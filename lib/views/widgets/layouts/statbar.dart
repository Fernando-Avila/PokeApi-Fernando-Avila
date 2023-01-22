import 'package:flutter/material.dart';
import 'package:pokeapi_fernando_avila/models/pokemon_model.dart';

class Statbar extends StatelessWidget {
  Statbar({
    Key? key,
    required this.stat,
    required this.statsupdated,
    required this.statfirst,
  }) : super(key: key);
  final Stats stat;
  final Stat statfirst;
  final Stat statsupdated;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: kElevationToShadow[3]),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
              flex: 1,
              child: Container(
                alignment: Alignment.topLeft,
                child: Text(
                  titles(stat),
                  style: TextStyle(
                    color: Color.fromARGB(255, 0, 0, 0),
                    fontSize: 18,
                  ),
                ),
              )),
          Expanded(
            flex: 3,
            child: Stack(
              fit: StackFit.expand,
              children: [
                Container(
                  margin: const EdgeInsets.symmetric(
                    horizontal: 4,
                  ),
                  child: CustomPaint(
                    painter: CustomBarPainter(
                        initial: porcentage(0),
                        finish: porcentage(statfirst.baseStat!),
                        color: Color.fromARGB(206, 25, 58, 207)),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.symmetric(
                    horizontal: 4,
                  ),
                  child: CustomPaint(
                    painter: CustomBarPainter(
                        initial: porcentage(statfirst.baseStat!),
                        finish: porcentage(statsupdated.baseStat!),
                        color: statfirst.baseStat! > statsupdated.baseStat!
                            ? Color.fromARGB(174, 109, 13, 13)
                            : Color.fromARGB(110, 11, 136, 48)),
                  ),
                ),
                Positioned(
                    right: 10,
                    bottom: 5,
                    child: Text(statsupdated.baseStat!.toString(),
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            color: statfirst.baseStat! > statsupdated.baseStat!
                                ? Color.fromARGB(174, 109, 13, 13)
                                : Color.fromARGB(110, 11, 136, 48))))
              ],
            ),
          )
        ],
      ),
    );
  }
}

String titles(Stats stat) {
  switch (stat) {
    case Stats.hp:
      return 'SALUD';
    case Stats.attack:
      return 'ATAQUE';
    case Stats.defense:
      return 'DEFENSA';
    case Stats.speed:
      return 'VELOCIDAD';
  }
}

//function recibe number max, value and return a double porcentage 0.0 - 1.0
//function recibe value and return a double porcentage 0.0 - 1.0 with max 255
double porcentage(int value) {
  return value / 250;
}

enum Stats {
  hp,
  attack,
  defense,
  speed,
}

class CustomBarPainter extends CustomPainter {
  final double initial;
  final double finish;
  final Color color;

  CustomBarPainter(
      {required this.initial, required this.finish, required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    print('Se actualizo el status');
    print(initial);
    print(finish);
    final paint = Paint();
    paint.color = color;
    paint.style = PaintingStyle.fill;
    paint.strokeWidth = 1;
    final path = Path();
    path.moveTo(size.width * initial, 0);
    //path.lineTo(size.width * initial, 0);
    path.lineTo(size.width * finish, 0);
    path.lineTo(size.width * finish, size.height);
    path.lineTo(size.width * initial, size.height);
    path.lineTo(size.width * initial, 0);

    ///path.lineTo(size.width * finish, size.height);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomBarPainter oldDelegate) => true;
}
