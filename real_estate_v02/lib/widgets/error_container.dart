import 'package:flutter/material.dart';

class ErrorContainer extends StatelessWidget {
  const ErrorContainer();

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Icon(
        Icons.error,
        color: Colors.red,
      ),
    );
  }
}
