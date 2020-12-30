import 'dart:math';

import 'package:flutter/material.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}


//TODO: add video demo
//TODO: Code improvement/cleaning
//TODO: add comments

class _MainScreenState extends State<MainScreen> {
  final _controller = TextEditingController();
  bool _isDisabled;
  List<String> _data;
  Random random;

  PersistentBottomSheetController
      _controllerBottomSheet; // <------ Instance variable
  final _scaffoldKey = GlobalKey<ScaffoldState>(); // <

  @override
  void initState() {
    super.initState();
    random = Random();
    _data = List<String>();
    _isDisabled = true;
    _controller.addListener(() {});
  }

  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _disableButton(String _) {
    if (_controller.value.text.isEmpty) {
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
    return SafeArea(
      child: Theme(
        data: ThemeData(
          floatingActionButtonTheme: FloatingActionButtonThemeData(
            backgroundColor: Colors.amber,
          ),
          appBarTheme: AppBarTheme(
              centerTitle: true, color: Colors.transparent, elevation: 0),
        ),
        child: Scaffold(
          floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
          floatingActionButton: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              FloatingActionButton(
                  child: CircleAvatar(
                    radius: 20,
                    backgroundColor: Colors.transparent,
                    child: Image.asset('assets/dice.png', color: Colors.white),
                  ),
                  onPressed: () async {
                    int selected = random.nextInt(_data.length);
                    await showDialog(
                        context: context,
                        builder: (_) {
                          return AlertDialog(
                            title: const Text('SELECTED'),
                            content: Text('${_data[selected]}'),
                          );
                        });
                  }),
              SizedBox(height: 10),
              FloatingActionButton(
                  child: Icon(Icons.add, color: Colors.white, size: 30),
                  onPressed: () {
                    _showBottomSheet(context, (data) {
                      setState(() {
                        _data.add(data);
                      });
                    });
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
          body: ListView.builder(
            itemCount: _data.length,
            itemBuilder: (_, index) {
              return Padding(
                padding:
                    const EdgeInsets.only(top: 20.0, left: 20.0, right: 20.0),
                child: Dismissible(
                  key: Key(_data[index]),
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
                      _data.removeAt(index);
                    });
                  },
                  child: Material(
                    elevation: 4.0,
                    child: Container(
                      decoration: BoxDecoration(border: Border.all(width: 2)),
                      child: ListTile(
                        title: Text('${_data[index]}'),
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  //BottomSheet handler method
  void _showBottomSheet(BuildContext context, Function(String) callback) {
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(15.0))),
        builder: (contextBottomSheet) {
          return Padding(
            padding: MediaQuery.of(context).viewInsets,
            child: Wrap(
              children: [
                Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.only(
                      left: 30.0, top: 30.0, right: 30.0, bottom: 15.0),
                  child: Theme(
                    data: ThemeData(primaryColor: Colors.black),
                    child: TextFormField(
                      autofocus: true,
                      controller: _controller,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(15)),
                        ),
                        labelText: 'Type here...',
                      ),
                      onChanged: _disableButton,
                    ),
                  ),
                ),
                SizedBox(width: MediaQuery.of(contextBottomSheet).size.width / 2.9),
                Container(
                  padding: const EdgeInsets.only(bottom: 16.0),
                  child: RaisedButton(
                      color: Colors.amber,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                      ),
                      child: const Text('Confirm',
                          style: TextStyle(color: Colors.white)),
                      onPressed: _isDisabled
                          ? null
                          : () {
                              callback(_controller.value.text);
                              _isDisabled = true;
                              _controller.clear();
                              Navigator.of(contextBottomSheet).pop();
                            }),
                ),
              ],
            ),
          );
        });
  }
}
