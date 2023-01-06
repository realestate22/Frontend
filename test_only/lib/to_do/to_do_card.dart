import 'package:flutter/material.dart';
import 'package:test_only/to_do/to_do_item_box.dart';
import 'package:test_only/to_do/to_do_pop_up.dart';
import 'package:test_only/to_do/to_do_title.dart';

import '../hero_dialog_route.dart';
import '../models.dart';
import '../styles.dart';



/// {@template todo_card}
/// Card that display a [Todo]'s content.
///
/// On tap it opens a [HeroDialogRoute] with [_TodoPopupCard] as the content.
/// {@endtemplate}
class TodoCard extends StatelessWidget {
  /// {@macro todo_card}
  const TodoCard({
    Key? key,
    required this.todo,
  }) : super(key: key);

  final Todo todo;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          HeroDialogRoute(
            builder: (context) => Center(
              child: TodoPopupCard(todo: todo),
            ),
          ),
        );
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Material(
          color: AppColors.cardColor,
          borderRadius: BorderRadius.circular(12),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: <Widget>[
                TodoTitle(title: todo.description),
                const SizedBox(
                  height: 8,
                ),
                if (todo.items != null) ...[
                  const Divider(),
                  TodoItemsBox(items: todo.items!),
                ]
              ],
            ),
          ),
        ),
      ),
    );
  }
}