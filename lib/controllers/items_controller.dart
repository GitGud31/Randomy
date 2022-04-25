import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/item.dart';

final itemsProvider = StateNotifierProvider<ItemsNotifier, List<Item>>((ref) {
  const initialValue = <Item>[];

  return ItemsNotifier(initialValue);
});

class ItemsNotifier extends StateNotifier<List<Item>> {
  ItemsNotifier(List<Item> state) : super(state);

  void add(Item item) => state = [...state, item];

  void delete(int index) => state.removeAt(index);

  void empty() => state = [];
}
