import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  // void _navigateToInputScreen() {
  //   Navigator.of(context).push(InputScreen.route());
  // }

  final _controller = TextEditingController();
  bool _isDisabled;
  String _text;
  List<String> _data;
  Random random;

  @override
  void initState() {
    super.initState();
    random = Random();
    _data = List<String>();
    _text = '';
    _isDisabled = true;
    _controller.addListener(() {});
  }

  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
        floatingActionButton: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            FloatingActionButton(
                child: Icon(Icons.radio_button_off),
                onPressed: () async {
                  int winner = random.nextInt(_data.length);

                  await showDialog(
                      context: context,
                      builder: (_) {
                        return AlertDialog(
                          title: Text('SELECTED'),
                          content: Text('${_data[winner]}'),
                        );
                      });
                }),
            FloatingActionButton(
                child: Icon(Icons.add),
                onPressed: () {
                  _showBottomSheet(context, (data) {
                    //
                    setState(() {
                      _data.add(data);
                    });
                  });
                }),
          ],
        ),
        //TODO: Add ABOUT THIS APP ALERT DIALOG
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: const Text('Randomy', style: TextStyle(color: Colors.black)),
        ),
        body: ListView.builder(
          itemCount: _data.length,
          itemBuilder: (context, index) {
            //TODO: Swipe to dismiss TILE
            return Padding(
              padding:
                  const EdgeInsets.only(top: 10.0, left: 16.0, right: 16.0),
              child: Card(
                elevation: 4.0,
                child: ListTile(
                  title: Text('${_data[index]}'),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  void _showBottomSheet(BuildContext context, Function(String) callback) {
    showModalBottomSheet(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(15.0))),
        context: context,
        isScrollControlled: true,
        builder: (_) {
          return Padding(
            padding: MediaQuery.of(context).viewInsets,
            child: Wrap(
              children: [
                Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.only(
                      left: 30.0, top: 30.0, right: 30.0, bottom: 15.0),
                  child: TextFormField(
                    autofocus: true,
                    enabled: true,
                    controller: _controller,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Type here...',
                    ),
                    onChanged: (_) {
                      //TODO: IMPROVE code
                      if (_controller.value.text.isEmpty) {
                        setState(() {
                          _isDisabled = true;
                        });
                      } else {
                        setState(() {
                          _isDisabled = false;
                        });
                      }
                    },
                  ),
                ),
                SizedBox(width: MediaQuery.of(context).size.width / 3),
                Container(
                  padding: const EdgeInsets.only(bottom: 16.0),
                  child: RaisedButton(
                      child: const Text('Confirm'),
                      onPressed: _isDisabled
                          ? null
                          : () {
                              _text = _controller.value.text;
                              print(_text);
                              callback(_text);
                              _isDisabled = true;
                              _controller.clear();
                              Navigator.of(context).pop();
                            }),
                ),
              ],
            ),
          );
        });
  }
}
