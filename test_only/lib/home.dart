import 'package:flutter/material.dart';
import 'package:test_only/styles.dart';
import 'package:test_only/to_do/to_do_list_content.dart';
import 'add_to_do_button.dart';
import 'fake_data.dart';
/// {@template home}
/// Home widget of the application.
/// {@endtemplate}
class Home extends StatelessWidget {
  /// {@macro home}
  const Home({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  AppColors.backgroundFadedColor,
                  AppColors.backgroundColor,
                ],
                stops: [0.0, 1],
              ),
            ),
          ),
          TodoListContent(
              todos: fakeData,
            ),
          const Align(
            alignment: Alignment.bottomRight,
            child: AddTodoButton(),
          )
        ],
      ),
    );
  }
}
