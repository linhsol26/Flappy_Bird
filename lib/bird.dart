import 'package:flutter/cupertino.dart';

class Bird extends StatefulWidget {
  @override
  _BirdState createState() => _BirdState();
}

class _BirdState extends State<Bird> with SingleTickerProviderStateMixin {
  AnimationController _animationController;
  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 500),
    );
    _animationController.forward();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animationController,
      builder: (context, _) {
        if (_animationController.value == 1) {
          _animationController.value = 0;
          _animationController.forward();
        }

        if (_animationController.value <= 1 / 3) {
          return Image.asset("assets/sprites/yellowbird-upflap.png",
              width: 40, height: 40, fit: BoxFit.contain);
        } else if (_animationController.value <= 2 / 3) {
          return Image.asset("assets/sprites/yellowbird-midflap.png",
              width: 40, height: 40, fit: BoxFit.contain);
        } else {
          return Image.asset("assets/sprites/yellowbird-downflap.png",
              width: 40, height: 40, fit: BoxFit.contain);
        }
      },
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
}
