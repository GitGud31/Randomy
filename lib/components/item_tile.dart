import 'package:flutter/material.dart';

import '../models/item.dart';

class ItemTileBuilder extends StatelessWidget {
  const ItemTileBuilder({
    Key? key,
    required this.index,
    required this.items,
  }) : super(key: key);

  final List<Item> items;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 4.0,
      child: Container(
        decoration: BoxDecoration(border: Border.all(width: 2)),
        child: ListTile(
          //TODO: keep, till title color is fixed
          tileColor: Colors.amber[400],
          title: Text(
            '${items[index].itemName}',
            style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
          ),
          subtitle: Text(
            '${items[index].creatorName}',
          ),
        ),
      ),
    );
  }
}
