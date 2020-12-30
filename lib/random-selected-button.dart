import 'dart:math';

import 'package:flutter/material.dart';

class RandomSelectButton extends StatelessWidget {
  const RandomSelectButton({
    Key key,
    @required List<String> data,
  })  : _data = data,
        super(key: key);

  final List<String> _data;

  @override
  Widget build(BuildContext context) {
    Random random = Random();
    int selected;

    return FloatingActionButton(
        child: CircleAvatar(
          radius: 20,
          backgroundColor: Colors.transparent,
          child: Image.asset('assets/dice.png', color: Colors.white),
        ),
        onPressed: () {
          selected = random.nextInt(_data.length);
          showDialog(
              context: context,
              builder: (_) {
                return AlertDialog(
                  title: const Text('SELECTED'),
                  content: Text('${_data[selected]}'),
                );
              });
        });
  }
}
