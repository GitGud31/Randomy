import 'dart:ui';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';

class Alerts {
  static simpleDialog(BuildContext context) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Description'),
          content: const Text(
            'Simple Application that selects a random element from user List on inputs.',
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Close'),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ],
        );
      },
    );
  }

  static awesomeDialog({
    required BuildContext context,
    required AnimType animType,
    required DialogType dialogType,
    required Widget body,
    required String cancelText,
    required VoidCallback cancelBtnPress,
    required String okText,
    required VoidCallback okOnPress,
  }) {
    return AwesomeDialog(
      context: context,
      animType: animType,
      dialogType: dialogType,
      body: Container(
        padding: const EdgeInsets.all(16),
        child: body,
      ),
      btnCancel: TextButton(child: Text(cancelText), onPressed: cancelBtnPress),
      btnOk: ElevatedButton(child: Text(okText), onPressed: okOnPress),
    )..show();
  }
}
