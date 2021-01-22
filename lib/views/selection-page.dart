import 'package:Randomy/views/main-screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../utils/user.dart';

class SelectionPage extends StatefulWidget {
  @override
  _SelectionPageState createState() => _SelectionPageState();
}

class _SelectionPageState extends State<SelectionPage> {
  final _itemController = TextEditingController();
  final _nameController = TextEditingController();
  bool _isDisabled;

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

  void _disableButton(String _) {
    if (_itemController.value.text.isEmpty) {
      setState(() {
        _isDisabled = true;
      });
    } else {
      setState(() {
        _isDisabled = false;
      });
    }

    if (_nameController.value.text.isEmpty) {
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
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          leading: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                Get.offNamed('/MainScreen');
              }),
          title: Text('Selection Page', style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold)),
          elevation: 0,
          backgroundColor: Colors.transparent,
        ),
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: Wrap(
            children: [
              Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.only(
                    left: 30.0, top: 30.0, right: 30.0, bottom: 15.0),
                child: TextFormField(
                  style: TextStyle(
                      color: Get.isDarkMode ? Colors.white : Colors.black),
                  autofocus: true,
                  controller: _itemController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(15)),
                    ),
                    labelText: 'Type here...',
                  ),
                  onChanged: _disableButton,
                ),
              ),
              Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.only(
                    left: 30.0, top: 30.0, right: 30.0, bottom: 15.0),
                child: TextFormField(
                  style: TextStyle(
                      color: Get.isDarkMode ? Colors.white : Colors.black),
                  autofocus: true,
                  controller: _nameController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(15)),
                    ),
                    labelText: 'Your name here',
                  ),
                  onChanged: _disableButton,
                ),
              ),
              SizedBox(width: MediaQuery.of(context).size.width / 2.9),
              Container(
                padding: const EdgeInsets.only(bottom: 16.0),
                child: RaisedButton(
                    color: Colors.amber,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                    ),
                    child: Text('Confirm'),
                    onPressed: _isDisabled
                        ? null
                        : () {
                            _isDisabled = true;

                            User user = User();

                            user.creatorName = _nameController.value.text;
                            user.itemName = _itemController.value.text;

                            Get.arguments.list.add(user);

                            _nameController.clear();
                            _itemController.clear();

                            Get.offNamed('/MainScreen');
                          }),
              ),
            ],
          ),
        ));
  }
}
