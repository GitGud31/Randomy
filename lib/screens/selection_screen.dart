import 'package:Randomy/controllers/items_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../components/textfield_builder.dart';
import '../models/item.dart';
import 'main_screen.dart';

class SelectionScreen extends ConsumerStatefulWidget {
  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _SelectionScreenState();
}

class _SelectionScreenState extends ConsumerState<SelectionScreen> {
  final _itemController = TextEditingController();
  final _nameController = TextEditingController();
  late bool _isDisabled;

  final appBarTitleStyle = TextStyle(fontSize: 25, fontWeight: FontWeight.bold);
  final confirmButtonStyle = ButtonStyle(
    backgroundColor: MaterialStateProperty.all<Color>(Colors.amber),
    shape: MaterialStateProperty.all(
      RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(20)),
      ),
    ),
  );

  @override
  void initState() {
    super.initState();
    _isDisabled = true;
    _itemController.addListener(() {});
    _nameController.addListener(() {});
  }

  void dispose() {
    _itemController.dispose();
    _nameController.dispose();
    super.dispose();
  }

  //TODO: implement
  void _disableConfirmButton(String text) {
    if (_itemController.value.text.isEmpty ||
        _nameController.value.text.isEmpty) {
      setState(() {
        _isDisabled = true;
      });
    } else {
      setState(() {
        _isDisabled = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final itemsNotifier = ref.watch(itemsProvider.notifier);

    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text('Selection Page', style: appBarTitleStyle),
          elevation: 0,
          backgroundColor: Colors.transparent,
          leading: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => MainScreen()),
                );
              }),
        ),
        body: Wrap(
          alignment: WrapAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(30.0),
              child: TextFieldBuilder(
                controller: _itemController,
                labelText: 'Type here...',
                onChanged: _disableConfirmButton,
              ),
            ),
            Container(
              padding: const EdgeInsets.all(30.0),
              child: TextFieldBuilder(
                controller: _nameController,
                onChanged: _disableConfirmButton,
                labelText: 'Your name here',
              ),
            ),
            const SizedBox(height: 30),
            ElevatedButton(
                style: confirmButtonStyle,
                child: const Text('Confirm'),
                onPressed: _isDisabled
                    ? null
                    : () {
                        _isDisabled = true;

                        itemsNotifier.add(
                          Item(
                            creatorName: _nameController.value.text,
                            itemName: _itemController.value.text,
                          ),
                        );

                        _nameController.clear();
                        _itemController.clear();

                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (_) => MainScreen()),
                        );
                      }),
          ],
        ));
  }
}
