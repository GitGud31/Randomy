import 'package:Randomy/controllers/items_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../components/textfield_builder.dart';
import '../consts/colors.dart';
import '../models/item.dart';
import 'home.dart';

class AddItemScreen extends ConsumerStatefulWidget {
  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _AddItemScreenState();
}

class _AddItemScreenState extends ConsumerState<AddItemScreen> {
  final _itemController = TextEditingController();
  final _nameController = TextEditingController();
  late bool _isDisabled;

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

  void _addItem(ItemsNotifier itemsNotifier) {
    _isDisabled = true;

    itemsNotifier.add(Item(
      creatorName: _nameController.value.text,
      itemName: _itemController.value.text,
    ));

    _nameController.clear();
    _itemController.clear();

    context.goNamed("home");
  }

  @override
  Widget build(BuildContext context) {
    final itemsNotifier = ref.watch(itemsProvider.notifier);

    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text('Add Item', style: appBarStyle),
          elevation: 0,
          leading: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () => context.goNamed("home")),
        ),
        body: SafeArea(
          child: ListView(
            padding: const EdgeInsets.all(16),
            children: [
              TextFieldBuilder(
                controller: _itemController,
                labelText: 'Item',
                onChanged: _disableConfirmButton,
              ),
              const SizedBox(height: 30),
              TextFieldBuilder(
                controller: _nameController,
                onChanged: _disableConfirmButton,
                labelText: 'Your name',
              ),
              const SizedBox(height: 30),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    fixedSize: Size(
                  MediaQuery.of(context).size.width - 30,
                  36,
                )),
                child: const Text('Confirm'),
                onPressed: _isDisabled ? null : () => _addItem(itemsNotifier),
              ),
            ],
          ),
        ));
  }
}
