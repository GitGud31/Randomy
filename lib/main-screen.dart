import 'package:flutter/material.dart';

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

  @override
  void initState() {
    super.initState();
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
        floatingActionButton: FloatingActionButton(onPressed: () {
          _showBottomSheet(context);
        }),
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: const Text('Randomy', style: TextStyle(color: Colors.black)),
        ),
        body: ListView.builder(
          itemCount: 20,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text('${_text} ${index}'),
            );
          },
        ),
      ),
    );
  }

  void _showBottomSheet(BuildContext context) {
    showModalBottomSheet(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(25.0))),
        context: context,
        isScrollControlled: true,
        builder: (_) {
          return Padding(
            padding: MediaQuery.of(context).viewInsets,
            child: Wrap(
              children: [
                Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.all(10),
                  child: TextFormField(
                    autofocus: true,
                    enabled: true,
                    controller: _controller,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Type here...',
                    ),
                    onChanged: (text) {
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
                RaisedButton(
                    child: const Text('Confirm'),
                    onPressed: _isDisabled
                        ? null
                        : () {
                            _text = _controller.value.text;
                            print(_text);
                            Navigator.of(context).pop();
                          }),
              ],
            ),
          );
        });
  }
}

// ///INPUT SCREEN
// class InputScreen extends StatefulWidget {
//   static Route<dynamic> route() {
//     return MaterialPageRoute(builder: (BuildContext context) => InputScreen());
//   }

//   @override
//   _InputScreenState createState() => _InputScreenState();
// }

// class _InputScreenState extends State<InputScreen> {
//   final _controller = TextEditingController();
//   bool _isDisabled;

//   @override
//   void initState() {
//     super.initState();
//     _isDisabled = true;
//     _controller.addListener(() {});
//   }

//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         centerTitle: true,
//         elevation: 0,
//         backgroundColor: Colors.transparent,
//         title: const Text('Write something',
//             style: TextStyle(color: Colors.black)),
//         leading: BackButton(color: Colors.black),
//       ),
//       body: ListView(
//         children: [
//           Container(
//             alignment: Alignment.center,
//             padding: const EdgeInsets.all(10),
//             child: TextFormField(
//               controller: _controller,
//               decoration: InputDecoration(
//                 border: OutlineInputBorder(),
//                 labelText: 'Type here...',
//               ),
//               onChanged: (text) {
//                 if (_controller.value.text.isEmpty) {
//                   setState(() {
//                     _isDisabled = true;
//                   });
//                 } else {
//                   setState(() {
//                     _isDisabled = false;
//                   });
//                 }
//               },
//             ),
//           ),
//           RaisedButton(
//               child: const Text('Confirm'),
//               onPressed: _isDisabled
//                   ? null
//                   : () {
//                     String text = _controller.value.text;
//                     print(text);
//                       //Navigator.of(context).pop();
//                     }),
//         ],
//       ),
//     );
//   }
// }
