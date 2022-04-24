import 'package:Randomy/controllers/items_controller.dart';
import 'package:Randomy/screens/selection_screen.dart';
import 'package:Randomy/utils/alerts.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../components/item_tile.dart';
import '../random_picker_button.dart';

class MainScreen extends ConsumerStatefulWidget {
  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MainScreenState();
}

class _MainScreenState extends ConsumerState<MainScreen> {
  final TextStyle appBarStyle = TextStyle(fontSize: 30);

  @override
  Widget build(BuildContext context) {
    final items = ref.watch(itemsProvider);
    final itemsNotifier = ref.watch(itemsProvider.notifier);

    return SafeArea(
      child: Scaffold(
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
                child: Icon(Icons.add, size: 30, color: Colors.white),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => SelectionScreen(),
                    ),
                  );
                }),
          ],
        ),
        appBar: AppBar(
          centerTitle: true,
          elevation: 0,
          backgroundColor: Colors.transparent,
          title: Text('Randomy', style: appBarStyle),
          leading: IconButton(icon: Icon(Icons.brightness_6), onPressed: () {}),
          actions: [
            IconButton(
              icon: Icon(Icons.delete),
              onPressed: () async {
                Alerts.awesomeDialog(
                  context: context,
                  animType: AnimType.SCALE,
                  dialogType: DialogType.ERROR,
                  cancelText: 'Cancel',
                  okText: 'Yes',
                  cancelBtnPress: () => Navigator.of(context).pop(),
                  okOnPress: () => itemsNotifier.empty(),
                  okBtnColor: Color(0xFFFF0707),
                  body: Center(
                    child: Column(
                      children: [
                        Text(
                          'Are you sure that you want yo delete all ?',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
            IconButton(
              icon: Icon(Icons.help),
              onPressed: () async => Alerts.simpleDialog(context),
            ),
          ],
        ),
        body: ListView.builder(
          itemCount: items.length,
          itemBuilder: (_, index) {
            return Padding(
              padding:
                  const EdgeInsets.only(top: 20.0, left: 20.0, right: 20.0),
              child: Dismissible(
                key: UniqueKey(),
                direction: DismissDirection.endToStart,
                background: Material(
                  child: Container(
                    padding: const EdgeInsets.only(right: 8),
                    alignment: Alignment.centerRight,
                    child: Icon(Icons.delete, color: Colors.white),
                    decoration: BoxDecoration(color: Colors.red),
                  ),
                ),
                onDismissed: (direction) => itemsNotifier.delete(index),
                child: ItemTileBuilder(items: items, index: index),
              ),
            );
          },
        ),
      ),
    );
  }
}
