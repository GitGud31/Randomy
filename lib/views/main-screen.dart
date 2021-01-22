import 'package:Randomy/controllers/list-controller.dart';
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
              icon: Icon(Icons.help),
              onPressed: () async {
                await showDialog(
                    context: context,
                    builder: (_) {
                      return AlertDialog(
                        title: Text('Description'),
                        content: Text(
                          'Simple Application that selects a random element from user List on inputs.',
                          style: TextStyle(
                              color:
                                  Get.isDarkMode ? Colors.white : Colors.black),
                        ),
                      );
                    });
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
                    key: Key(listController.list[index].toString()),
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
      ),
    );
  }
}