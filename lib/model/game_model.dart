class GameModel {
  bool isInvalid;
  List<bool> balls;
  List<bool> strikes;
  int ballsCount;
  int strikesCount ;
  String? key;
  String? guess;
  String errorMessage;
  GameModel({
    this.isInvalid = false,
    required this.balls,
    required this.strikes,
    this.strikesCount=0,
    this.ballsCount=0,
    this.key,
    this.guess,
    this.errorMessage=''
  });
}
