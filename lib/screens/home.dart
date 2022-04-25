import 'package:Randomy/controllers/items_controller.dart';
import 'package:Randomy/screens/add_item.dart';
import 'package:Randomy/utils/alerts.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../components/item_tile.dart';
import '../components/random_picker_button.dart';
import '../consts/colors.dart';

class HomeScreen extends ConsumerStatefulWidget {
  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final items = ref.watch(itemsProvider);
    final itemsNotifier = ref.watch(itemsProvider.notifier);

    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          RandomPickerButton(
            key: const Key('random button'),
          ),
          const SizedBox(height: 10),
          FloatingActionButton(
              heroTag: const Key('selection page button'),
              child: Icon(Icons.add, size: 30, color: white),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => AddItemScreen(),
                  ),
                );
              }),
        ],
      ),
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        title: Text('Randomy', style: appBarStyle),
        leading: IconButton(icon: Icon(Icons.brightness_6), onPressed: () {}),
        actions: [
          IconButton(
            icon: Icon(Icons.delete),
            onPressed: () async => Alerts.awesomeDialog(
              context: context,
              animType: AnimType.SCALE,
              dialogType: DialogType.ERROR,
              cancelText: 'Cancel',
              okText: 'Yes',
              okOnPress: () {
                itemsNotifier.empty();
                Navigator.of(context).pop();
              },
              cancelBtnPress: () => Navigator.of(context).pop(),
              body: Column(
                children: [
                  Text(
                    'Are you sure that you want yo delete all ?',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                ],
              ),
            ),
          ),
          IconButton(
            icon: Icon(Icons.help),
            onPressed: () async => Alerts.simpleDialog(context),
          ),
        ],
      ),
      body: SafeArea(
        child: ListView.builder(
          padding: const EdgeInsets.all(20),
          itemCount: items.length,
          itemBuilder: (_, index) => ItemTileBuilder(
            items: items,
            index: index,
            onDismissed: (direction) => itemsNotifier.delete(index),
          ),
        ),
      ),
    );
  }
}
