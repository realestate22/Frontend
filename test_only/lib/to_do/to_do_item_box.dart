import 'package:flutter/material.dart';
import 'package:test_only/to_do/to_do_item_tile.dart';

import '../models.dart';
/// {@template todo_items_box}
/// Box containing the list of a [Todo]'s items.
///
/// These items can be checked.
/// {@endtemplate}
class TodoItemsBox extends StatelessWidget {
  /// {@macro todo_items_box}
  const TodoItemsBox({
    Key? key,
    required this.items,
  }) : super(key: key);

  final List<Item> items;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        for (final item in items) TodoItemTile(item: item),
      ],
    );
  }
}