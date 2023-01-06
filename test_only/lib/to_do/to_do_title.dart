import 'package:flutter/material.dart';

/// {@template todo_title}
/// Title of a [Todo].
/// {@endtemplate}
class TodoTitle extends StatelessWidget {
  /// {@macro todo_title}
  const TodoTitle({
    Key? key,
    required this.title,
  }) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
    );
  }
}
