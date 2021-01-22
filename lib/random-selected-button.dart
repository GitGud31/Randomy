import 'dart:math';

import 'package:Randomy/user.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';

class RandomSelectButton extends StatelessWidget {
  const RandomSelectButton({
    Key key,
    @required List<User> data,
  })  : _data = data,
        super(key: key);

  final List<User> _data;

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

          AwesomeDialog(
            context: context,
            animType: AnimType.SCALE,
            dialogType: DialogType.SUCCES,
            btnOkColor: Color(0xFFFFC107),
            body: Center(
              child: Column(
                children: [
                  Text(
                    '${_data[selected].itemName}',
                    style: TextStyle(
                      fontStyle: FontStyle.italic,
                      color: Colors.black,
                      fontSize: 20,
                    ),
                  ),
                  Text(
                    '${_data[selected].creatorName}',
                    style: TextStyle(
                      fontStyle: FontStyle.italic,
                      color: Colors.grey,
                      fontSize: 15,
                    ),
                  ),
                ],
              ),
            ),
            btnOkOnPress: () {},
          )..show();
        });
  }
}
