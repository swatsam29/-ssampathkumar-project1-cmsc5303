import 'package:flutter/material.dart';
import 'package:lesson1/viewscreen/game_screen.dart';
import 'package:lesson1/viewscreen/start_screen.dart';

void main() {
  runApp(const Lesson1App());
}


class Lesson1App extends StatelessWidget {
  const Lesson1App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        textTheme: const TextTheme(
          headline1: TextStyle(
            fontSize: 64.0,
            color: Colors.red,
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            textStyle: const TextStyle(fontSize: 28.0,),
          ),
        ),
      ),
      initialRoute: StartScreen.routeName,
      routes: {
        StartScreen.routeName: (BuildContext context) => const StartScreen(),
        GameScreen.routeName: (BuildContext context) => const GameScreen(),
      },
    );
  }
}
