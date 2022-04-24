import 'dart:math';

import 'package:Randomy/controllers/items_controller.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'utils/alerts.dart';

class RandomPickerButton extends ConsumerWidget {
  const RandomPickerButton({Key? key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final items = ref.watch(itemsProvider);

    final random = Random();
    late int selected;

    return FloatingActionButton(
        child: CircleAvatar(
          radius: 20,
          backgroundColor: Colors.transparent,
          child: Image.asset('assets/dice.png', color: Colors.white),
        ),
        onPressed: () {
          selected = random.nextInt(items.length);

          Alerts.awesomeDialog(
            context: context,
            dialogType: DialogType.SUCCES,
            animType: AnimType.SCALE,
            okBtnColor: Color(0xFFFFC107),
            okText: 'Ok',
            okOnPress: () {},
            cancelText: 'Cancel',
            cancelBtnPress: () {},
            body: Center(
              child: Column(
                children: [
                  Text(
                    '${items[selected].itemName}',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                  Text(
                    '${items[selected].creatorName}',
                    style: TextStyle(fontStyle: FontStyle.italic, fontSize: 15),
                  ),
                ],
              ),
            ),
          );
        });
  }
}
