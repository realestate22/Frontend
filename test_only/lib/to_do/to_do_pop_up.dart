import 'package:flutter/material.dart';
import 'package:test_only/to_do/to_do_item_box.dart';
import 'package:test_only/to_do/to_do_title.dart';

import '../models.dart';
import '../styles.dart';
/// {@template todo_popup_card}
/// Popup card to expand the content of a [Todo] card.
///
/// Activated from [_TodoCard].
/// {@endtemplate}
class TodoPopupCard extends StatelessWidget {
  const TodoPopupCard({Key? key, required this.todo}) : super(key: key);
  final Todo todo;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Material(
        borderRadius: BorderRadius.circular(16),
        color: AppColors.cardColor,
        child: SizedBox(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TodoTitle(title: todo.description),
                  const SizedBox(
                    height: 8,
                  ),
                  if (todo.items != null) ...[
                    const Divider(),
                    TodoItemsBox(items: todo.items!),
                  ],
                  Container(
                    margin: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.black12,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const TextField(
                      maxLines: 8,
                      cursorColor: Colors.white,
                      decoration: InputDecoration(
                          contentPadding: EdgeInsets.all(8),
                          hintText: 'Write a note...',
                          border: InputBorder.none),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
