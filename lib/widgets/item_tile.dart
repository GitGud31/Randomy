import 'package:flutter/material.dart';

import '../consts/colors.dart';
import '../models/item.dart';

class ItemTileBuilder extends StatelessWidget {
  const ItemTileBuilder({
    required this.key,
    required this.index,
    required this.items,
    required this.onDismissed,
  }) : super(key: key);

  final Key key;
  final List<Item> items;
  final int index;
  final void Function(DismissDirection)? onDismissed;

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: key,
      direction: DismissDirection.endToStart,
      background: Container(
        padding: const EdgeInsets.only(right: 8),
        alignment: Alignment.centerRight,
        child: const Icon(Icons.delete, color: white),
        decoration: const BoxDecoration(color: red),
      ),
      onDismissed: onDismissed,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 10),
        child: Material(
          elevation: 4.0,
          child: Container(
            decoration: BoxDecoration(border: Border.all(width: 2)),
            child: ListTile(
              title: Text('${items[index].itemName}', style: tileTitleStyle),
              subtitle: Text('${items[index].creatorName}'),
            ),
          ),
        ),
      ),
    );
  }
}
