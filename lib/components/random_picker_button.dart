import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:Randomy/controllers/items_controller.dart';
import 'package:awesome_dialog/awesome_dialog.dart';

import '../consts/colors.dart';
import '../utils/alerts.dart';

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
          backgroundColor: transparent,
          child: Image.asset('assets/dice.png', color: white),
        ),
        onPressed: () {
          selected = random.nextInt(items.length);

          Alerts.awesomeDialog(
            context: context,
            dialogType: DialogType.SUCCES,
            animType: AnimType.SCALE,
            okText: 'Ok',
            okOnPress: () => Navigator.pop(context),
            cancelText: 'Cancel',
            cancelBtnPress: () => Navigator.pop(context),
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
