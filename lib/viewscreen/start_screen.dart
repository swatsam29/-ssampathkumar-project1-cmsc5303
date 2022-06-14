import 'package:flutter/material.dart';
import 'package:lesson1/viewscreen/game_screen.dart';
class _Controller{
  _StartScreenState state;
  bool showGameScreen =false;
  _Controller(this.state);
  void startGame(){
    Navigator.pushReplacementNamed(state.context, GameScreen.routeName);
  }
}

class StartScreen extends StatefulWidget {
  const StartScreen({Key? key}) : super(key: key);
  static const String routeName = '/';

  @override
  State<StartScreen> createState() => _StartScreenState();
}

class _StartScreenState extends State<StartScreen> {
  late _Controller con;
  @override
  initState() {
    super.initState();
    con = _Controller(this);
  }

  render(fn) => setState(fn);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Baseball Game',
          style: TextStyle(
              fontSize: 16, color: Colors.white, fontWeight: FontWeight.w500),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 25),
              decoration: const BoxDecoration(color: Colors.white, boxShadow: [
                BoxShadow(
                  spreadRadius: 5,
                  blurRadius: 6,
                  offset: Offset(5, 9),
                  color: Colors.grey,
                )
              ]),
              child: Padding(
                padding: const EdgeInsets.only(left: 13.0,top: 25,bottom: 15),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Play Ball~~~',
                      style: TextStyle(
                          fontSize: 16,
                          color: Colors.black87,
                          fontWeight: FontWeight.w700),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const Text(
                      'Press start',
                      style: TextStyle(
                          fontSize: 16,
                          color: Colors.black87,
                          fontWeight: FontWeight.w300),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: ElevatedButton(
                        onPressed: con.startGame,
                        child: const Text(
                          'Start',
                          style: TextStyle(
                              fontSize: 15,
                              color: Colors.white,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
