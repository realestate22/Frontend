import 'package:flutter/material.dart';
import 'add_to_do_pop_up_card.dart';
import 'styles.dart';

import 'custom_rect_tween.dart';
import 'hero_dialog_route.dart';

/// {@template add_todo_button}
/// Button to add a new [Todo].
///
/// Opens a [HeroDialogRoute] of [_AddTodoPopupCard].
///
/// Uses a [Hero] with tag [_heroAddTodo].
/// {@endtemplate}
class AddTodoButton extends StatelessWidget {
  /// {@macro add_todo_button}
  const AddTodoButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.antiAlias,
      decoration: const BoxDecoration(
        color: AppColors.accentColor,
        shape: BoxShape.circle,
      ),
      child: IconButton(
        style: ButtonStyle(backgroundColor: MaterialStatePropertyAll(Colors.transparent)),
        onPressed: () {
          Navigator.of(context).push(HeroDialogRoute(builder: (context) {
            return const AddTodoPopupCard();
          }));
        },
        padding: EdgeInsets.zero,
        icon: const Icon(
          Icons.add_rounded,
          size: 56,
        ),
      ),
    );
  }
}
