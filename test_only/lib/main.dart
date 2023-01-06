import 'package:flutter/material.dart';
import 'add_to_do_button.dart';
import 'home.dart';

void main() => runApp(const MyApp());

/// {@template my_app}
/// Entry point for the application.
/// {@endtemplate}
class MyApp extends StatelessWidget {
  /// {@macro my_app}
  const MyApp();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark(),
      home: //const Home(),
      Test()
    );
  }
}
class Test extends StatelessWidget {
  const Test({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
              child: Container(
                color: Colors.white,
                width: 100,
                height: 400,
              )
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





