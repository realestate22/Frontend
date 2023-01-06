import 'package:flutter/material.dart';

import '../models.dart';

/// {@template todo_item_template}
/// An individual [Todo] [Item] with its [Checkbox].
/// {@endtemplate}
class TodoItemTile extends StatefulWidget {
  /// {@macro todo_item_template}
  const TodoItemTile({
    Key? key,
    required this.item,
  }) : super(key: key);

  final Item item;

  @override
  _TodoItemTileState createState() => _TodoItemTileState();
}

class _TodoItemTileState extends State<TodoItemTile> {
  void _onChanged(bool? val) {
    if(val==null){
      return;
    }
    setState(() {
      widget.item.completed = val;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Checkbox(
        onChanged: _onChanged,
        value: widget.item.completed,
      ),
      title: Text(widget.item.description),
    );
  }
}
