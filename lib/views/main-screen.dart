import 'package:Randomy/controllers/list-controller.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../random-selected-button.dart';
import 'utilities/app-theme.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

//TODO: add comments

class _MainScreenState extends State<MainScreen> {
  final ListController listController = Get.put(ListController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          RandomSelectButton(
            data: listController.list,
            key: Key('random button'),
          ),
          SizedBox(height: 10),
          FloatingActionButton(
              heroTag: Key('selection page button'),
              child: Icon(Icons.add, size: 30, color: Colors.white),
              onPressed: () {
                Get.toNamed('/SelectionPage', arguments: listController);
              }),
        ],
      ),
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: Text('Randomy', style: TextStyle(fontSize: 30)),
        leading: IconButton(
            icon: Icon(Icons.brightness_4_sharp),
            onPressed: () {
              Get.changeTheme(
                  Get.isDarkMode ? AppTheme.lightTheme : ThemeData.dark());
            }),
        actions: [
          IconButton(
            icon: Icon(Icons.delete),
            onPressed: () async {
              AwesomeDialog(
                context: context,
                animType: AnimType.SCALE,
                dialogType: DialogType.ERROR,
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
                btnCancel: FlatButton(
                  child: const Text('cancel'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                btnCancelColor: Colors.blue,
                btnOkText: 'yes',
                btnOkColor: Color(0xFFFF0707),
                btnOkOnPress: () {
                  listController.list.clear();
                },
              )..show();
            },
          ),
          IconButton(
            icon: Icon(Icons.help),
            onPressed: () async {
              Get.dialog(
                AlertDialog(
                  title: Text('Description'),
                  content: Text(
                    'Simple Application that selects a random element from user List on inputs.',
                    style: TextStyle(
                        color: Get.isDarkMode ? Colors.white : Colors.black),
                  ),
                ),
                useSafeArea: true,
              );
            },
          ),
        ],
      ),
      body: Obx(() => ListView.builder(
            itemCount: listController.list.length,
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
                  onDismissed: (direction) {
                    // Remove the item from the data source.
                    setState(() {
                      listController.list.removeAt(index);
                    });
                  },
                  child: Material(
                    elevation: 4.0,
                    child: Container(
                      decoration: BoxDecoration(border: Border.all(width: 2)),
                      child: ListTile(
                        //TODO: keep, till title color is fixed
                        tileColor: Colors.amber[400],
                        title: Text(
                          '${listController.list[index].itemName}',
                          style: TextStyle(
                              fontSize: 25, fontWeight: FontWeight.bold),
                        ),
                        subtitle: Text(
                          '${listController.list[index].creatorName}',
                        ),
                      ),
                    ),
                  ),
                ),
              );
            },
          )),
    ));
  }
}
