import 'dart:math';

import 'package:flappy_bird/base.dart';
import 'package:flappy_bird/message.dart';
import 'package:flappy_bird/pipe.dart';
import 'package:flappy_bird/score.dart';
import 'package:flutter/material.dart';
import 'package:flappy_bird/utils/speed.dart';
import 'package:flappy_bird/utils/bird_position.dart';
import 'package:flappy_bird/utils/score.dart';
import 'package:provider/provider.dart';
import 'package:flappy_bird/bird.dart';

class Play extends StatefulWidget {
  @override
  _PlayState createState() => _PlayState();
}

class _PlayState extends State<Play> with SingleTickerProviderStateMixin {
  AnimationController _animationController;
  ScrollController _controller = ScrollController(keepScrollOffset: true);

  int currentPoint = 0;
  int currentOffSet = 0;
  double startOffSet = 200.0;
  int pipe = 300;
  int highScore = 0;
  double height = 600.0;
  double width = 300.0;
  double range = -100.0;

  bool isStart = false;
  bool isEnd = false;
  bool isTap = false;
  bool init = false;

  Speed _speed = new Speed();
  Random random = new Random();
  List<double> _randomNumer;

  BirdPosition _birdPosition = new BirdPosition();

  void setSpeed(double v, double s) {
    _speed.velocity = v;
    _speed.speed = s;
  }

  void setVelocity(double v) {
    _speed.velocity = v;
  }

  double getSpeedPipe() => ((_speed.speed) * currentOffSet).toDouble();

  double onCollision() =>
      (startOffSet + 25 + (52 + 100) * (currentPoint)).toDouble();

  double birdPos() {
    if (isStart == false) {
      return height / 2 - 50;
    }
    if (isTap) {
      return 0;
    } else {
      return height - 300;
    }
  }

  void initHighScore() async {
    highScore = await getHighScore();
  }

  bool isEndGame() {
    if (_birdPosition.position <= 320 + range * _randomNumer[currentPoint] ||
        _birdPosition.position >= 385 + range * _randomNumer[currentPoint]) {
      isEnd = true;
      return true;
    } else {
      if (highScore < currentPoint) {
        highScore = currentPoint;
        setHighScore(highScore);
      }
      return false;
    }
  }

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
        vsync: this, duration: Duration(milliseconds: 1000));
    _animationController.forward();
    _randomNumer = List.generate(pipe, (index) => random.nextDouble());
    setSpeed(10, 2);

    _animationController.addListener(() {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (isStart == true) {
          _controller.jumpTo(getSpeedPipe());
          if (getSpeedPipe() - onCollision() >= -42.0 &&
              getSpeedPipe() - onCollision() <= 42.0) {
            if (isEndGame()) {
            } else if (getSpeedPipe() - onCollision() == 41.0) {
              currentPoint++;
            }
          }

          if (!isEnd) {
            currentOffSet++;
          } else {
            isStart = false;
            isEnd = false;
          }

          if (_birdPosition.position == height - 130) {
            isStart = false;
            isEnd = false;
          }
        }
        setState(() {});
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    if (init == false) {
      _birdPosition = Provider.of<BirdPosition>(context);
      initHighScore();
      init = true;
    }

    if (isStart == false && isEnd == false) {
      currentPoint = 0;
      currentOffSet = 0;
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _controller.jumpTo(0);
      });
    }

    return GestureDetector(
        onTap: () {
          if (isStart == false) {
            isStart = true;
          }
          isTap = true;
          Future.delayed(Duration(milliseconds: 150), () {
            isTap = false;
          });
        },
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          color: Colors.white,
          child: FittedBox(
            child: SizedBox(
              height: height,
              width: width,
              child: Stack(
                children: [
                  SizedBox(
                    height: height - 100,
                    width: width,
                    child: Image.asset(
                      "assets/sprites/background-day.png",
                      fit: BoxFit.fitWidth,
                    ),
                  ),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    controller: _controller,
                    child: Row(
                      children: List.generate(pipe, (index) {
                        if (index == 0) {
                          return SizedBox(
                            width: startOffSet,
                          );
                        } else if (index % 2 == 0 && index != 0) {
                          return Transform.translate(
                            offset: Offset(
                                0, range * _randomNumer[(index - 2) ~/ 2]),
                            child: Pipe(),
                          );
                        } else {
                          return SizedBox(
                            width: 100,
                          );
                        }
                      }),
                    ),
                  ),
                  AnimatedPositioned(
                    duration: Duration(milliseconds: 500),
                    top: birdPos(),
                    left: 80,
                    child: Opacity(opacity: isStart ? 1 : 0, child: Bird()),
                  ),
                  Center(
                    child: Message(
                      isStart: isStart,
                      score: highScore,
                    ),
                  ),
                  (isStart)
                      ? Padding(
                          padding: const EdgeInsets.only(bottom: 500),
                          child: Center(
                              child: Score(
                            score: currentPoint,
                            isStart: isStart,
                          )),
                        )
                      : Container(),
                  Positioned(
                    top: height - 100,
                    child: Builder(builder: (context) {
                      if (_animationController.value == 1) {
                        _animationController.value = 0;
                        _animationController.forward();
                      }
                      return Base(
                        value: _animationController.value,
                      );
                    }),
                  ),
                ],
              ),
            ),
          ),
        ));
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
}
