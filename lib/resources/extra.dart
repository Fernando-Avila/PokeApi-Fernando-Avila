import 'package:pokeapi_fernando_avila/views/widgets/layouts/buttonhabilitie.dart';

String Infoabilities(Habilities abiliti) {
  var map = {
    Habilities.intimidation:
        'Intimidación: Ataque +10, velocidad+15, salud-5, defensa-10',
    Habilities.toxic: 'Tóxico: Defensa+10, velocidad-3, salud-15',
    Habilities.regeneration:
        'Regeneración: Ataque-20, velocidad+5, salud-10, defensa+5',
    Habilities.immunity:
        'Inmunidad: Ataque-20, velocidad-10, salud+10, defensa+20',
    Habilities.impassive:
        'Impasible: Ataque -3, velocidad+30, salud-15, defensa-10',
    Habilities.power:
        'Potencía: Ataque +15, velocidad+15, salud-20, defensa-10',
  };
  return map[abiliti] ?? '';
}
