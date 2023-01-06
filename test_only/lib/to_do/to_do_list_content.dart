import 'package:flutter/material.dart';
import 'package:test_only/to_do/to_do_card.dart';

import '../models.dart';
/// {@template todo_list_content}
/// List of [Todo]s.
/// {@endtemplate}
class TodoListContent extends StatelessWidget {
  const TodoListContent({
    Key? key,
    required this.todos,
  }) : super(key: key);

  final List<Todo> todos;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: todos.length,
      padding: const EdgeInsets.all(16),
      itemBuilder: (context, index) {
        final _todo = todos[index];
        return TodoCard(todo: _todo);
      },
    );
  }
}