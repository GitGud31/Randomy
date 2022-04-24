import 'package:flutter/foundation.dart';

@immutable
class Item {
  final String creatorName;
  final String itemName;

  const Item({
    required this.creatorName,
    required this.itemName,
  });

  Item copyWith({String? itemName, String? creatorName}) {
    return Item(
      creatorName: creatorName ?? this.itemName,
      itemName: itemName ?? this.creatorName,
    );
  }
}
