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

    void _picker() {
      selected = random.nextInt(items.length);

      Alerts.awesomeDialog(
        context: context,
        dialogType: DialogType.success,
        animType: AnimType.scale,
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
    }

    return FloatingActionButton(
        child: Container(
          margin: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: transparent,
            image: DecorationImage(
              image: AssetImage('assets/toss.png'),
            ),
          ),
        ),
        onPressed: items.isEmpty ? null : _picker);
  }
}
