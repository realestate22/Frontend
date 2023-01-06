import 'dart:math';

import 'package:flutter/material.dart';
import 'package:test_only/styles.dart';


/// Tag-value used for the add todo popup button

/// {@template add_todo_popup_card}
/// Popup card to add a new [Todo]. Should be used in conjuction with
/// [HeroDialogRoute] to achieve the popup effect.
///
/// Uses a [Hero] with tag [_heroAddTodo].
/// {@endtemplate}
class AddTodoPopupCard extends StatelessWidget {
  /// {@macro add_todo_popup_card}
  const AddTodoPopupCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.topLeft,
      width: 400,
      height: 500,
      padding: const EdgeInsets.symmetric(horizontal: 32.0),
      margin: EdgeInsets.only(top:400),
      child: Material(
        color: AppColors.accentColor,
        elevation: 2,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(32)),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const TextField(
                  decoration: InputDecoration(
                    hintText: 'New todo',
                    border: InputBorder.none,
                  ),
                  cursorColor: Colors.white,
                ),
                const Divider(
                  color: Colors.white,
                  thickness: 0.2,
                ),
                const TextField(
                  decoration: InputDecoration(
                    hintText: 'Write a note',
                    border: InputBorder.none,
                  ),
                  cursorColor: Colors.white,
                  maxLines: 6,
                ),
                const Divider(
                  color: Colors.white,
                  thickness: 0.2,
                ),
                ElevatedButton(
                  onPressed: () {},
                  child: const Text('Add'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
