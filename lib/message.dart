import 'package:flutter/material.dart';
import 'package:flappy_bird/score.dart';

class Message extends StatelessWidget {
  final bool isStart;
  final int score;

  const Message({Key key, this.isStart, this.score}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
        duration: Duration(milliseconds: 500),
        opacity: isStart ? 0 : 1,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset("assets/sprites/message.png"),
            SizedBox(
              height: 30,
            ),
            Score(score: score),
          ],
        ));
  }
}
