import 'package:Randomy/controllers/list-controller.dart';
import 'package:Randomy/user.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'random-selected-button.dart';
import 'selection-page.dart';

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
            RandomSelectButton(data: listController.list),
            SizedBox(height: 10),
            FloatingActionButton(
                child: Icon(Icons.add, color: Colors.white, size: 30),
                onPressed: () {
                  // _showBottomSheet(context, (data) {
                  //   setState(() {
                  //     _data.add(data.itemName);
                  //   });
                  // });
                  Get.to(SelectionPage(), arguments: listController);
                }),
          ],
        ),
        appBar: AppBar(
          title: const Text('Randomy',
              style: TextStyle(color: Colors.black, fontSize: 30)),
          actions: [
            IconButton(
              icon: Icon(Icons.help, color: Colors.amber),
              onPressed: () async {
                await showDialog(
                    context: context,
                    builder: (_) {
                      return AlertDialog(
                        title: const Text('Description'),
                        content: const Text(
                            'Simple Application that selects a random element from user List on inputs.'),
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
                    //key: Key(_data[index]),
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
                        //_data.removeAt(index);
                        listController.list.removeAt(index);
                      });
                    },
                    child: Material(
                      elevation: 4.0,
                      child: Container(
                        decoration: BoxDecoration(border: Border.all(width: 2)),
                        child: ListTile(
                          //title: Text('${_data[index]}'),
                          title: Text('${listController.list[index].itemName}'),
                          subtitle:
                              Text('${listController.list[index].creatorName}'),
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
