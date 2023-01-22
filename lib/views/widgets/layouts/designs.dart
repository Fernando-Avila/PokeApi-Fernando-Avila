import 'package:flutter/material.dart';

class Dvdh extends StatelessWidget {
  const Dvdh({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Divider(
      color: Theme.of(context).colorScheme.primary,
      height: 10,
      thickness: 2,
      indent: 20,
      endIndent: 20,
    );
  }
}
