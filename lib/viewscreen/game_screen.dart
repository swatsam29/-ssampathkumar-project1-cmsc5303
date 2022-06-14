import 'dart:math';
import 'package:flutter/material.dart';
import 'package:lesson1/viewscreen/view/view_widgets.dart';
import '../model/game_model.dart';

class _Controller {
  _GameScreenState state;
  late GameModel gameInfo;

  final TextEditingController _controller = TextEditingController();
  _Controller(this.state) {
    gameInfo = GameModel(
      balls: [false, false, false],
      strikes: [false, false, false],
    );
    generateKey();
  }
  void clearField() {
    _controller.text = '';
    state.render(() {});
  }

  String validateInput() {
    if (_controller.text.length > 3) {
      gameInfo.isInvalid = true;
      gameInfo.errorMessage = 'Invalid: must be in three digits';
    }
    if (_controller.text.length < 3) {
      gameInfo.isInvalid = true;
      gameInfo.errorMessage = 'Invalid: must be in three digits';
    }

    String data = _controller.text.toString();
    if (!(data[0].contains(
          RegExp("[0-9]"),
        )) ||
        !(data[1].contains(
          RegExp("[0-9]"),
        )) ||
        !(data[2].contains(
          RegExp("[0-9]"),
        ))) {
      gameInfo.isInvalid = true;
      gameInfo.errorMessage = 'Invalid: only numbers are allowed';
    }

    if ((data[0] == data[1]) || (data[0] == data[2]) || (data[2] == data[1])) {
      gameInfo.isInvalid = true;
      gameInfo.errorMessage = 'Invalid repeated digits are not allowed';
    }
    state.render(() {});
    return data;
  }

  void submit() {
    if (state.formKey.currentState!.validate()) {
      gameInfo.isInvalid = false;
      state.render(() {});

      String data = validateInput();

      gameInfo.guess = data;

      if (gameInfo.isInvalid == false) {
        if (gameInfo.key!.contains(gameInfo.guess![0])) {
          if (gameInfo.key![0] == gameInfo.guess![0]) {
            gameInfo.strikes[0] = true;
            gameInfo.balls[0] = false;
          } else {
            gameInfo.strikes[0] = false;
            gameInfo.balls[0] = true;
          }
        } else {
          gameInfo.balls[0] = false;
          gameInfo.strikes[0] = false;
        }

        if (gameInfo.key!.contains(gameInfo.guess![1])) {
          if (gameInfo.key![1] == gameInfo.guess![1]) {
            gameInfo.strikes[1] = true;
            gameInfo.balls[1] = false;
          } else {
            gameInfo.strikes[1] = false;
            gameInfo.balls[1] = true;
          }
        } else {
          gameInfo.balls[1] = false;
          gameInfo.strikes[1] = false;
        }

        if (gameInfo.key!.contains(gameInfo.guess![2])) {
          if (gameInfo.key![2] == gameInfo.guess![2]) {
            gameInfo.strikes[2] = true;
            gameInfo.balls[2] = false;
          } else {
            gameInfo.strikes[2] = false;
            gameInfo.balls[2] = true;
          }
        } else {
          gameInfo.balls[2] = false;
          gameInfo.strikes[2] = false;
        }

        fillCircles();
        if (gameInfo.strikesCount == 3) {
          endGame();
        }
      }
      state.render(() {});
    }
  }

  newGame() {
    generateKey();
    gameInfo.ballsCount = 0;
    gameInfo.strikesCount = 0;
    gameInfo.balls = [false, false, false];
    gameInfo.strikes = [false, false, false];
    gameInfo.guess = '';
    _controller.text = '';
    state.render(() {});
  }

  void endGame() {
    showDialog(
        barrierColor: Colors.transparent,
        barrierDismissible: false,
        context: state.context,
        builder: (_) {
          return Center(
            child: Card(
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 25),
                height: 160,
                decoration: BoxDecoration(
                  color: Colors.blue.withOpacity(0.96),
                ),
                child: Padding(
                  padding:
                      const EdgeInsets.only(left: 13.0, top: 25, bottom: 15),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Strike Out~~~',
                        style: TextStyle(
                            fontSize: 16,
                            color: Colors.black87,
                            fontWeight: FontWeight.w700),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      const Text(
                        'Press OK for new game',
                        style: TextStyle(
                            fontSize: 16,
                            color: Colors.black87,
                            fontWeight: FontWeight.w300),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: Padding(
                          padding: const EdgeInsets.only(right: 5.0),
                          child: ElevatedButton(
                            onPressed: () {
                              newGame();
                              Navigator.pop(state.context);
                            },
                            child: const Text(
                              'OK',
                              style: TextStyle(
                                  fontSize: 15,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        });
  }

  fillCircles() {
    List<bool> falseStrikes = [];
    List<bool> trueStrikes = [];
    List<bool> falseBalls = [];
    List<bool> trueBalls = [];

    falseStrikes =
        gameInfo.strikes.where((element) => element == false).toList();
    trueStrikes = gameInfo.strikes.where((element) => element == true).toList();
    falseBalls = gameInfo.balls.where((element) => element == false).toList();
    trueBalls = gameInfo.balls.where((element) => element == true).toList();

    gameInfo.strikes = [];
    gameInfo.balls = [];
    gameInfo.strikes = trueStrikes + falseStrikes;
    gameInfo.balls = trueBalls + falseBalls;
    gameInfo.ballsCount = trueBalls.length;
    gameInfo.strikesCount = trueStrikes.length;
  }

  void generateKey() {
    Random random = Random();
    int x = random.nextInt(9);
    int y = random.nextInt(9);
    int z = random.nextInt(9);

    if (x == y) {
      while (x == y) {
        y = random.nextInt(9);
      }
    }
    if (z == y || z == x) {
      while (z == x || z == y) {
        z = random.nextInt(9);
      }
    }

    gameInfo.key = '$x$y$z';
    state.render(() {});
  }
}

class GameScreen extends StatefulWidget {
  const GameScreen({Key? key}) : super(key: key);
  static const String routeName = '/gameScreen';
  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  late _Controller con;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
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
        actions: [
          ElevatedButton(
            onPressed: con.newGame,
            child: const Text(
              'New Game',
              style: TextStyle(
                  fontSize: 15,
                  color: Colors.white,
                  fontWeight: FontWeight.w500),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 15.0, left: 20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Key:  ${con.gameInfo.key ?? ''}',
                style: const TextStyle(
                    fontSize: 16, fontWeight: FontWeight.normal),
              ),
              const SizedBox(
                height: 8,
              ),
              Text(
                'Guess:  ${con.gameInfo.guess ?? ''}',
                style: const TextStyle(
                    fontSize: 16, fontWeight: FontWeight.normal),
              ),
              const SizedBox(
                height: 25,
              ),
              Text(
                'Balls: ${con.gameInfo.ballsCount}',
                style: const TextStyle(
                    fontSize: 15, fontWeight: FontWeight.normal),
              ),
              const SizedBox(
                height: 8,
              ),
              Row(
                children: [
                  ...List.generate(
                    3,
                    (index) => CircleContainer(
                      isFilled: con.gameInfo.balls[index],
                      color: Colors.blueAccent,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                'Strike: ${con.gameInfo.strikesCount}',
                style: const TextStyle(
                    fontSize: 15, fontWeight: FontWeight.normal),
              ),
              const SizedBox(
                height: 8,
              ),
              Row(
                children: [
                  ...List.generate(
                    3,
                    (index) => CircleContainer(
                      isFilled: con.gameInfo.strikes[index],
                      color: Colors.redAccent,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 8,
              ),
              Form(
                key: formKey,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 5.0),
                      child: TextFormField(
                        textAlign: TextAlign.center,
                        controller: con._controller,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          hintText: 'Enter Your Guess (3 digits)',
                          contentPadding:
                              const EdgeInsets.symmetric(horizontal: 20),
                          suffix: InkWell(
                              onTap: () {
                                con.clearField();
                              },
                              child: const Icon(
                                Icons.close,
                                color: Colors.blueAccent,
                                size: 25,
                              )),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Visibility(
                      visible: con.gameInfo.isInvalid,
                      child: Text(
                        con.gameInfo.errorMessage,
                        style: const TextStyle(
                            color: Colors.red,
                            fontSize: 15,
                            fontWeight: FontWeight.w400),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: ElevatedButton(
                        onPressed: con.submit,
                        child: const Text(
                          'Submit',
                          style: TextStyle(fontSize: 15, color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
